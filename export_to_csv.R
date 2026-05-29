# ---------------------------------------------------------------------------
# PTCy meta-analysis — export extraction workbook to tidy CSVs
#
# Reads PTCy_MA_extraction_template_v1.0.xlsx, writes one CSV per data sheet
# into 02_extraction/. Also runs lightweight validation checks.
#
# Usage:
#   Rscript export_to_csv.R
# or from within R:
#   source("export_to_csv.R")
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(readxl)
  library(dplyr)
  library(readr)
  library(tibble)
  library(stringr)
  library(purrr)
})

XLSX <- "PTCy_MA_extraction_template_v1.2_post_block9.xlsx"
OUT_DIR <- file.path("02_extraction")
if (!dir.exists(OUT_DIR)) dir.create(OUT_DIR, recursive = TRUE)

# Sheets to export. README and codebook are reference only.
DATA_SHEETS <- c("cohorts", "studies", "arms", "outcomes",
                 "outcomes_subgroup", "rob")

# The first 3 rows of each data sheet are: header, required/optional flag,
# field notes. Data starts at row 4.
read_sheet <- function(sheet) {
  hdr <- read_excel(XLSX, sheet = sheet, n_max = 1, col_names = FALSE,
                    .name_repair = "minimal")
  col_names <- as.character(unlist(hdr[1, ]))
  df <- read_excel(XLSX, sheet = sheet, skip = 3, col_names = col_names,
                   .name_repair = "minimal")
  # Drop rows that are completely empty
  keep <- rowSums(!is.na(df) & df != "") > 0
  df[keep, , drop = FALSE]
}

# ---- read everything ------------------------------------------------------
message("Reading workbook ...")
tabs <- map(set_names(DATA_SHEETS, DATA_SHEETS), read_sheet)
walk2(DATA_SHEETS, tabs, ~ message(sprintf("  %s: %d rows × %d cols",
                                            .x, nrow(.y), ncol(.y))))

# ---- type coercion --------------------------------------------------------
# Excel will return everything as character if any cell holds NR/UNCL etc.
# That's fine for export; downstream brms code coerces numerics with
# vapply(x, function(v) ifelse(v %in% c("NR","NA","UNCL","PEND"), NA_real_,
#                              as.numeric(v)), 0)

# ---- write CSVs -----------------------------------------------------------
message("\nWriting CSVs to ", OUT_DIR, " ...")
iwalk(tabs, function(df, name) {
  path <- file.path(OUT_DIR, paste0(name, ".csv"))
  write_csv(df, path, na = "")
  message("  wrote ", path)
})

# ---- validation checks ----------------------------------------------------
message("\nValidation checks:")

problems <- list()

# 1. event_count <= denominator_n in outcomes / outcomes_subgroup
check_events <- function(df, label) {
  if (!all(c("event_count", "denominator_n") %in% names(df))) return()
  bad <- df |>
    mutate(
      events_num = suppressWarnings(as.numeric(event_count)),
      denom_num  = suppressWarnings(as.numeric(denominator_n))
    ) |>
    filter(!is.na(events_num), !is.na(denom_num), events_num > denom_num)
  if (nrow(bad) > 0) {
    problems[[paste0(label, ":events>n")]] <<- bad
    message(sprintf("  [FAIL] %s: %d rows have event_count > denominator_n",
                    label, nrow(bad)))
  } else {
    message(sprintf("  [OK]   %s: events <= n in all rows", label))
  }
}
check_events(tabs$outcomes, "outcomes")
check_events(tabs$outcomes_subgroup, "outcomes_subgroup")

# 2. denominator_n matches arms.n_patients (allowing attrition flagged in notes)
if (nrow(tabs$outcomes) > 0 && nrow(tabs$arms) > 0) {
  joined <- tabs$outcomes |>
    mutate(arm_id = suppressWarnings(as.integer(arm_id)),
           denom_num = suppressWarnings(as.numeric(denominator_n))) |>
    left_join(tabs$arms |>
                mutate(arm_id = suppressWarnings(as.integer(arm_id)),
                       n_arm = suppressWarnings(as.numeric(n_patients))) |>
                select(arm_id, n_arm), by = "arm_id") |>
    filter(!is.na(denom_num), !is.na(n_arm), denom_num > n_arm)
  if (nrow(joined) > 0) {
    problems[["outcomes:denom>n_arm"]] <- joined
    message(sprintf("  [WARN] outcomes: %d rows have denominator_n > arms.n_patients (attrition?)",
                    nrow(joined)))
  } else {
    message("  [OK]   outcomes: denominator_n <= arms.n_patients in all rows")
  }
}

# 3. % columns each sum to <=100 per arm
pct_groups <- list(
  disease = c("disease_aml_pct","disease_all_pct","disease_mds_pct",
              "disease_mpn_pct","disease_cml_pct","disease_lymphoma_pct",
              "disease_mm_pct","disease_cll_pct","disease_saa_pct",
              "disease_other_pct"),
  donor   = c("donor_msd_pct","donor_mud_pct","donor_mmud_pct",
              "donor_haplo_pct","donor_ucb_pct"),
  graft   = c("graft_pbsc_pct","graft_bm_pct","graft_ucb_pct"),
  conditioning = c("conditioning_mac_pct","conditioning_ric_pct",
                   "conditioning_nma_pct")
)
if (nrow(tabs$arms) > 0) {
  for (grp in names(pct_groups)) {
    cols <- intersect(pct_groups[[grp]], names(tabs$arms))
    if (length(cols) < 2) next
    df_num <- tabs$arms |>
      select(arm_id, all_of(cols)) |>
      mutate(across(all_of(cols),
                    ~ suppressWarnings(as.numeric(.x))))
    df_num$pct_sum <- rowSums(df_num[, cols], na.rm = TRUE)
    bad <- df_num |> filter(pct_sum > 100.5)
    if (nrow(bad) > 0) {
      problems[[paste0("arms:", grp, "_pct_sum>100")]] <- bad
      message(sprintf("  [WARN] arms: %d rows have %s percentages summing to >100",
                      nrow(bad), grp))
    } else {
      message(sprintf("  [OK]   arms: %s percentages <=100 in all rows", grp))
    }
  }
}

# 4. comparison eligibility — each eligible arm has a comparator in same study
if (nrow(tabs$arms) > 0) {
  for (cmp in c("comparison_1_eligible", "comparison_2_eligible",
                "comparison_3_eligible")) {
    if (!cmp %in% names(tabs$arms)) next
    elig <- tabs$arms |>
      filter(.data[[cmp]] == "Y") |>
      group_by(study_id) |>
      summarise(n_elig = n(), .groups = "drop") |>
      filter(n_elig < 2)
    if (nrow(elig) > 0) {
      message(sprintf("  [WARN] %s: %d study/ies have <2 eligible arms",
                      cmp, nrow(elig)))
    } else {
      message(sprintf("  [OK]   %s: every eligible arm has a comparator", cmp))
    }
  }
}

# ---- write validation report ---------------------------------------------
if (length(problems) > 0) {
  rpt <- file.path(OUT_DIR, "_validation_failures.rds")
  saveRDS(problems, rpt)
  message("\nValidation failures saved to ", rpt)
  message("Inspect with: readRDS('", rpt, "')")
} else {
  message("\nAll validation checks passed.")
}

# ---- analytic-dataset builder (convenience) ------------------------------
build_analytic <- function(category, subtype, timepoint,
                            comparison = 1, only_primary = TRUE) {
  cmp_col <- paste0("comparison_", comparison, "_eligible")
  tabs$outcomes |>
    mutate(arm_id    = suppressWarnings(as.integer(arm_id)),
           study_id  = suppressWarnings(as.integer(study_id)),
           cohort_id = suppressWarnings(as.integer(cohort_id)),
           event_count    = suppressWarnings(as.numeric(event_count)),
           denominator_n  = suppressWarnings(as.numeric(denominator_n))) |>
    filter(outcome_category == category,
           outcome_subtype  == subtype,
           timepoint == !!timepoint,
           if (only_primary) is_primary_definition == "Y" else TRUE) |>
    inner_join(
      tabs$arms |> mutate(arm_id = suppressWarnings(as.integer(arm_id))),
      by = "arm_id"
    ) |>
    inner_join(
      tabs$studies |>
        mutate(study_id = suppressWarnings(as.integer(study_id))) |>
        select(study_id, cohort_id, pub_year, region, era_category,
               primary_for_cohort),
      by = c("study_id", "cohort_id")
    ) |>
    filter(.data[[cmp_col]] == "Y",
           primary_for_cohort %in% c("Y", "partial"))
}

message("\nDone. ",
        "Call build_analytic(category, subtype, timepoint, comparison=N) ",
        "to build a brms-ready dataset.")
