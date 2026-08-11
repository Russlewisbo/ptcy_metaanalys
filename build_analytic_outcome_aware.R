# ---------------------------------------------------------------------------
# Outcome-aware cohort deduplication for the PTCy meta-analysis
#
# Problem this solves
# -------------------
# build_analytic() in refit_block9.R filters studies with
#     primary_for_cohort %in% c("Y", "partial")
# The `partial` value means "primary for SOME outcomes but not others"
# (schema v1.0 §5), but the filter is not outcome-aware: every `partial`
# publication from a cohort is retained for EVERY outcome. Where a cohort has
# several `partial` publications, they all enter the same model as if they were
# independent studies, and patients reported in more than one of them are
# counted more than once.
#
# As of 2026-08-11 this affects 9 of 29 analytic datasets; the primary C1
# overall-survival model draws 5 of its 40 studies from cohort 1024 alone.
#
# Usage
# -----
#   source("build_analytic_outcome_aware.R")
#   ov     <- load_cohort_overrides()
#   paired <- build_analytic("survival", "os", "1yr", comparison = 1)
#   paired <- resolve_cohort_duplicates(paired, "os", studies, ov,
#                                       strategy = "override", cohorts = cohorts)
#
# Design note: this module deliberately does NOT silently choose a publication
# when the override registry has no confirmed entry. Silent selection is how
# the current double counting went unnoticed. The default strategy is "flag",
# which changes nothing and reports.
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(dplyr); library(readr); library(tidyr); library(stringr); library(purrr)
})

# ---------------------------------------------------------------------------
# Override registry
# ---------------------------------------------------------------------------
# Columns: cohort_id, outcome_key, study_id, status, basis
#   outcome_key = "*" is the cohort default (used when no outcome-specific row)
#   status      = confirmed | proposed | unresolved
#                 "unresolved" rows are never applied automatically.
load_cohort_overrides <- function(path = "03_models/cohort_overrides.csv") {
  if (!file.exists(path)) {
    warning("No override registry at ", path, "; returning empty registry.")
    return(tibble(cohort_id = character(), outcome_key = character(),
                  study_id = numeric(), status = character(), basis = character()))
  }
  read_csv(path, show_col_types = FALSE, progress = FALSE) |>
    mutate(cohort_id = as.character(cohort_id), study_id = as.numeric(study_id))
}

# Parse machine-readable entries out of cohorts.primary_publication_overrides.
# Recognised format: one "outcome_key:study_id" per line (e.g. "IFI_any:8").
# Free-text entries and the placeholder "NR" are ignored and reported.
parse_inline_overrides <- function(cohorts) {
  raw <- cohorts |>
    filter(!is.na(primary_publication_overrides),
           str_trim(primary_publication_overrides) != "",
           str_trim(primary_publication_overrides) != "NR") |>
    select(cohort_id, primary_publication_overrides) |>
    mutate(cohort_id = as.character(cohort_id))

  parsed <- raw |>
    separate_longer_delim(primary_publication_overrides, delim = "\n") |>
    mutate(entry = str_trim(primary_publication_overrides),
           key   = str_match(entry, "^([A-Za-z0-9_]+)\\s*:\\s*(\\d+)\\s*$")[, 2],
           sid   = suppressWarnings(as.numeric(str_match(entry, "^([A-Za-z0-9_]+)\\s*:\\s*(\\d+)\\s*$")[, 3]))) |>
    filter(!is.na(key))

  list(
    structured = parsed |> transmute(cohort_id, outcome_key = tolower(key), study_id = sid),
    prose_only = raw |> anti_join(parsed |> distinct(cohort_id), by = "cohort_id")
  )
}

# ---------------------------------------------------------------------------
# Audit: which cohorts contribute more than one study to a dataset?
# ---------------------------------------------------------------------------
audit_cohort_duplication <- function(paired, studies) {
  paired |>
    mutate(study_id = as.numeric(study_id)) |>
    left_join(studies |> transmute(study_id = as.numeric(study_id), cohort_id = as.character(cohort_id),
                                   first_author, pub_year, primary_for_cohort),
              by = "study_id") |>
    group_by(cohort_id) |>
    filter(n() > 1) |>
    ungroup() |>
    select(cohort_id, study_id, first_author, pub_year, primary_for_cohort, any_of(c("ptcy_n", "comp_n")))
}

# ---------------------------------------------------------------------------
# Resolution
# ---------------------------------------------------------------------------
# strategy:
#   "flag"           - report duplicates, change nothing (default, safe)
#   "override"       - apply confirmed/proposed registry rows, then cohort
#                      primary_publication_study_id; anything still ambiguous is
#                      left intact and reported
#   "cohort_primary" - keep cohorts$primary_publication_study_id where present
#   "largest_n"      - keep the single largest study per cohort (blunt; use only
#                      as a sensitivity analysis, never as the primary analysis)
resolve_cohort_duplicates <- function(paired, outcome_key, studies,
                                      overrides = NULL,
                                      strategy = c("flag", "override", "cohort_primary", "largest_n"),
                                      cohorts = NULL,
                                      allow_proposed = TRUE,
                                      quiet = FALSE) {
  strategy <- match.arg(strategy)
  if (nrow(paired) == 0) return(paired)
  if (is.null(overrides)) overrides <- load_cohort_overrides()

  key <- tolower(outcome_key)
  smap <- studies |>
    transmute(study_id = as.numeric(study_id), cohort_id = as.character(cohort_id))

  dat <- paired |>
    mutate(study_id = as.numeric(study_id), .row = row_number()) |>
    left_join(smap, by = "study_id")

  dup_cohorts <- dat |> count(cohort_id) |> filter(n > 1) |> pull(cohort_id)
  report <- tibble(cohort_id = character(), action = character(), kept = character(),
                   dropped = character(), basis = character())

  if (length(dup_cohorts) == 0) {
    if (!quiet) message(sprintf("[%s] no cohort contributes >1 study.", outcome_key))
    attr(paired, "dedup_report") <- report
    return(paired)
  }

  if (strategy == "flag") {
    if (!quiet) {
      message(sprintf("[%s] %d cohort(s) contribute >1 study: %s (strategy='flag', nothing removed)",
                      outcome_key, length(dup_cohorts), paste(dup_cohorts, collapse = ", ")))
    }
    attr(paired, "dedup_report") <- dat |>
      filter(cohort_id %in% dup_cohorts) |>
      transmute(cohort_id, action = "flagged", kept = NA_character_,
                dropped = NA_character_, basis = "strategy='flag'")
    return(paired)
  }

  ok_status <- if (allow_proposed) c("confirmed", "proposed") else "confirmed"
  keep_rows <- dat$.row

  for (ch in dup_cohorts) {
    cand <- dat |> filter(cohort_id == ch)
    pick <- NA_real_; basis <- NA_character_

    if (strategy == "override") {
      hit <- overrides |>
        filter(cohort_id == ch, status %in% ok_status,
               tolower(outcome_key) %in% c(key, "*")) |>
        arrange(tolower(outcome_key) != key)          # outcome-specific beats "*"
      hit <- hit |> filter(study_id %in% cand$study_id)
      if (nrow(hit) > 0) {
        pick  <- hit$study_id[1]
        basis <- sprintf("registry (%s, %s)", hit$outcome_key[1], hit$status[1])
      }
    }

    if (is.na(pick) && strategy %in% c("override", "cohort_primary") && !is.null(cohorts)) {
      cp <- cohorts |>
        mutate(cohort_id = as.character(cohort_id)) |>
        filter(cohort_id == ch) |>
        pull(primary_publication_study_id)
      if (length(cp) == 1 && !is.na(cp) && cp %in% cand$study_id) {
        pick  <- cp
        basis <- "cohorts.primary_publication_study_id"
      }
    }

    if (is.na(pick) && strategy == "largest_n" && all(c("ptcy_n", "comp_n") %in% names(cand))) {
      pick  <- cand$study_id[which.max(cand$ptcy_n + cand$comp_n)]
      basis <- "largest total N"
    }

    if (is.na(pick)) {
      report <- add_row(report, cohort_id = ch, action = "UNRESOLVED",
                        kept = paste(cand$study_id, collapse = "|"), dropped = "",
                        basis = "no confirmed override and no usable cohort primary")
      if (!quiet) {
        warning(sprintf("[%s] cohort %s: %d studies and no applicable override - all retained.",
                        outcome_key, ch, nrow(cand)), call. = FALSE)
      }
      next
    }

    drop <- cand |> filter(study_id != pick)
    keep_rows <- setdiff(keep_rows, drop$.row)
    report <- add_row(report, cohort_id = ch, action = "deduplicated",
                      kept = as.character(pick),
                      dropped = paste(drop$study_id, collapse = "|"), basis = basis)
  }

  out <- paired[dat$.row %in% keep_rows, , drop = FALSE]
  attr(out, "dedup_report") <- report
  if (!quiet) {
    message(sprintf("[%s] %d -> %d studies; %d cohort(s) deduplicated, %d unresolved.",
                    outcome_key, nrow(paired), nrow(out),
                    sum(report$action == "deduplicated"), sum(report$action == "UNRESOLVED")))
  }
  out
}

# ---------------------------------------------------------------------------
# Drop-in wrapper for refit_block9.R
# ---------------------------------------------------------------------------
# Replace calls of the form
#     d <- build_analytic(category, subtype, timepoint, comparison = 1)
# with
#     d <- build_analytic_dedup(category, subtype, timepoint, comparison = 1,
#                               outcome_key = "os", strategy = "override")
build_analytic_dedup <- function(category, subtype, timepoint, comparison,
                                 outcome_key,
                                 fallback_timepoints = NULL,
                                 require_primary_for_cohort = TRUE,
                                 strategy = "override",
                                 overrides = NULL,
                                 quiet = FALSE) {
  stopifnot(exists("build_analytic"), exists("studies"))
  paired <- build_analytic(category, subtype, timepoint, comparison,
                           fallback_timepoints = fallback_timepoints,
                           require_primary_for_cohort = require_primary_for_cohort)
  resolve_cohort_duplicates(
    paired, outcome_key, studies, overrides, strategy = strategy,
    cohorts = if (exists("cohorts")) cohorts else NULL, quiet = quiet
  )
}
