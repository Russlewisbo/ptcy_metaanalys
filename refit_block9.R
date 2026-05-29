# ---------------------------------------------------------------------------
# PTCy meta-analysis — Block 9 refit script
#
# Refits all Bayesian random-effects models on the post-Block-9 corpus
# (251 studies / 525 arms / 3604 outcomes / 14 RCTs).
#
# Assumes the 6 tidy CSVs in 02_extraction/ have already been refreshed from
# PTCy_MA_extraction_template_v1.2_post_block9.xlsx (done by the Python
# consolidator on 2026-05-29; backups of the pre-Block-9 CSVs are in
# 02_extraction/_backup_pre_block9/).
#
# Output: 03_models/post_block9/*.rds + Table2_post_block9.csv
#
# Usage:
#   setwd("/Users/russelllewis/Desktop/ptcy_metaanalys")
#   source("refit_block9.R")
#
# Approx runtime on M-series Mac: ~2–3 hours for all 16 model fits
# (4 chains × 3000 post-warmup × 16 models).
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(readr); library(dplyr); library(tidyr); library(brms)
  library(posterior); library(bayesplot)
})

PROJECT  <- "/Users/russelllewis/Desktop/ptcy_metaanalys"
setwd(PROJECT)
OUT_DIR  <- "03_models/post_block9"
if (!dir.exists(OUT_DIR)) dir.create(OUT_DIR, recursive = TRUE)

# ---------------------------------------------------------------------------
# Load tidy CSVs (already refreshed from post-Block-9 workbook)
# ---------------------------------------------------------------------------
message("Loading tidy CSVs ...")
arms      <- read_csv("02_extraction/arms.csv",       show_col_types = FALSE)
outcomes  <- read_csv("02_extraction/outcomes.csv",   show_col_types = FALSE)
studies   <- read_csv("02_extraction/studies.csv",    show_col_types = FALSE)

# Numeric coercion helper
to_num <- function(x) suppressWarnings(as.numeric(x))

arms <- arms |>
  mutate(across(c(arm_id, study_id, n_patients,
                  systemic_steroid_for_gvhd_exposure_pct),
                to_num))
outcomes <- outcomes |>
  mutate(across(c(arm_id, study_id, event_count, denominator_n,
                  cumulative_incidence_pct, timepoint_days_numeric), to_num))
studies <- studies |>
  mutate(across(c(study_id, pub_year), to_num))

message(sprintf("  arms: %d | outcomes: %d | studies: %d",
                nrow(arms), nrow(outcomes), nrow(studies)))

# ---------------------------------------------------------------------------
# build_analytic() — paired PTCy + comparator dataset for one outcome cell
# ---------------------------------------------------------------------------
build_analytic <- function(category, subtype, timepoint, comparison,
                           fallback_timepoints = NULL,
                           require_primary_for_cohort = TRUE) {

  cmp_col <- paste0("comparison_", comparison, "_eligible")
  primary_ids <- if (require_primary_for_cohort) {
    studies |> filter(primary_for_cohort %in% c("Y", "partial")) |> pull(study_id)
  } else studies$study_id

  elig <- arms |>
    filter(.data[[cmp_col]] == "Y", study_id %in% primary_ids)

  tps <- c(timepoint, fallback_timepoints)
  used <- character(0)
  result <- list()
  preferred_tp <- timepoint

  for (tp in tps) {
    o <- outcomes |>
      filter(outcome_category == category,
             outcome_subtype  == subtype,
             timepoint        == tp,
             !is.na(event_count),   # require actual event counts (no back-calculation)
             arm_id %in% elig$arm_id) |>
      left_join(elig |> select(arm_id, arm_role, n_patients,
                                systemic_steroid_for_gvhd_exposure_pct),
                by = "arm_id")

    # For each study not yet used, build a paired row
    for (sid in unique(o$study_id)) {
      if (sid %in% used) next
      grp <- o |> filter(study_id == sid)
      p <- grp |> filter(arm_role == "PTCy_arm") |> slice(1)
      c <- grp |> filter(arm_role == "comparator_arm") |> slice(1)
      if (nrow(p) == 0 || nrow(c) == 0) next

      pn <- ifelse(is.na(p$denominator_n), p$n_patients, p$denominator_n)
      cn <- ifelse(is.na(c$denominator_n), c$n_patients, c$denominator_n)
      pe <- p$event_count
      ce <- c$event_count

      result[[length(result)+1]] <- tibble(
        study_id = sid, comparison = comparison,
        category = category, subtype = subtype, timepoint_used = tp,
        tp_early = as.integer(tp != preferred_tp),
        ptcy_arm_id = p$arm_id, comp_arm_id = c$arm_id,
        ptcy_n = pn, comp_n = cn,
        ptcy_e = pe, comp_e = ce,
        ptcy_steroid_pct = p$systemic_steroid_for_gvhd_exposure_pct,
        comp_steroid_pct = c$systemic_steroid_for_gvhd_exposure_pct
      )
      used <- c(used, sid)
    }
  }

  if (length(result) == 0) return(tibble())
  bind_rows(result) |>
    filter(!is.na(ptcy_e), !is.na(comp_e), !is.na(ptcy_n), !is.na(comp_n),
           ptcy_n > 0, comp_n > 0,
           ptcy_e <= ptcy_n, comp_e <= comp_n)
}

# ---------------------------------------------------------------------------
# Long format for brms (one row per arm, with ptcy_binary indicator)
# ---------------------------------------------------------------------------
to_long <- function(paired) {
  bind_rows(
    paired |> transmute(study_id, comparison, ptcy_binary = 1L,
                        tp_early, events_n = ptcy_e, denom_n = ptcy_n,
                        steroid_pct = ptcy_steroid_pct),
    paired |> transmute(study_id, comparison, ptcy_binary = 0L,
                        tp_early, events_n = comp_e, denom_n = comp_n,
                        steroid_pct = comp_steroid_pct)
  ) |> mutate(study_id = factor(study_id))
}

# ---------------------------------------------------------------------------
# Model fitters (same priors/specs as the pre-Block-9 brms code per MANIFEST.md)
# ---------------------------------------------------------------------------
priors_m1 <- c(
  prior(normal(0, 2.5), class = "b"),
  prior(normal(0, 1.5), class = "Intercept"),
  prior(student_t(3, 0, 1), class = "sd")
)
priors_m2 <- c(
  prior(normal(0, 2.5), class = "b"),
  prior(normal(0, 1.5), class = "Intercept"),
  prior(student_t(3, 0, 1), class = "sd")
)

fit_m1 <- function(d, label) {
  message(sprintf("\n[m1] %s — fitting on k=%d ...", label, n_distinct(d$study_id)))
  brm(events_n | trials(denom_n) ~ ptcy_binary + tp_early + (1 | study_id),
      data = d, family = binomial(), prior = priors_m1,
      chains = 4, iter = 4000, warmup = 1000, cores = 4,
      control = list(adapt_delta = 0.95, max_treedepth = 12),
      seed = 20260529, refresh = 0)
}

fit_m2_steroid <- function(d, label) {
  # Complete-case analysis: drop arms with missing steroid data
  d2 <- d |>
    filter(!is.na(steroid_pct)) |>
    mutate(steroid_pct_c = scale(steroid_pct, center = TRUE,
                                scale = FALSE)[,1])
  n_drop <- nrow(d) - nrow(d2)
  message(sprintf("\n[m2_steroid] %s — k=%d studies (%d arms dropped for missing steroid)",
                  label, n_distinct(d2$study_id), n_drop))
  brm(events_n | trials(denom_n) ~ ptcy_binary + tp_early + steroid_pct_c + (1 | study_id),
      data = d2, family = binomial(), prior = priors_m2,
      chains = 4, iter = 4000, warmup = 1000, cores = 4,
      control = list(adapt_delta = 0.95, max_treedepth = 12),
      seed = 20260529, refresh = 0)
}

# ---------------------------------------------------------------------------
# Refit specifications
# ---------------------------------------------------------------------------
# Matching pre-Block-9 methodology: require actual event_count (no back-calc),
# use fallback timepoints with tp_early covariate.
specs <- list(
  list(slug="c1_os",       cat="overall_mortality",            sub="OS_event",
       tp="D+365_1yr",   fb=c("D+730_2yr","end_of_followup"), cmp=1, m2=TRUE),
  list(slug="c1_nrm",      cat="NRM",                          sub="NRM_overall",
       tp="D+365_1yr",   fb=c("D+100","end_of_followup"),     cmp=1, m2=TRUE),
  list(slug="c1_agvhd",    cat="aGVHD",                        sub="grade_II_IV",
       tp="D+100",       fb=c("D+180"),                       cmp=1, m2=FALSE),
  list(slug="c1_cmv",      cat="CMV",                          sub="any_reactivation",
       tp="D+100",       fb=c("D+180","end_of_followup"),     cmp=1, m2=TRUE),
  list(slug="c1_bsi",      cat="BSI",                          sub="any_pathogen",
       tp="D+100",       fb=c("D+180","end_of_followup","D+30"), cmp=1, m2=FALSE),
  list(slug="c1_ifi_any",  cat="IFI_any",                      sub="EORTC_MSG_proven_probable_combined",
       tp="end_of_followup", fb=c("D+365_1yr","D+180"),        cmp=1, m2=FALSE),

  list(slug="c2_os",       cat="overall_mortality",            sub="OS_event",
       tp="D+365_1yr",   fb=c("D+730_2yr","end_of_followup"), cmp=2, m2=TRUE),
  list(slug="c2_nrm",      cat="NRM",                          sub="NRM_overall",
       tp="D+365_1yr",   fb=c("D+100","end_of_followup"),     cmp=2, m2=TRUE),
  list(slug="c2_agvhd",    cat="aGVHD",                        sub="grade_II_IV",
       tp="D+100",       fb=c("D+180"),                       cmp=2, m2=FALSE),
  list(slug="c2_cmv",      cat="CMV",                          sub="any_reactivation",
       tp="D+100",       fb=c("D+180","D+365_1yr","end_of_followup"), cmp=2, m2=TRUE),

  # Comparison 3 — new this round
  list(slug="c3_os",       cat="overall_mortality",            sub="OS_event",
       tp="D+365_1yr",   fb=c("D+730_2yr","end_of_followup"), cmp=3, m2=FALSE),
  list(slug="c3_nrm",      cat="NRM",                          sub="NRM_overall",
       tp="D+365_1yr",   fb=c("D+100"),                       cmp=3, m2=FALSE),
  list(slug="c3_agvhd",    cat="aGVHD",                        sub="grade_II_IV",
       tp="D+100",       fb=c("D+180"),                       cmp=3, m2=FALSE),
  list(slug="c3_cgvhd",    cat="cGVHD",                        sub="moderate_severe_NIH",
       tp="D+365_1yr",   fb=c("D+730_2yr"),                   cmp=3, m2=FALSE)
)

# ---------------------------------------------------------------------------
# Run loop — build paired data, fit M1 (and M2 where applicable), save .rds
# ---------------------------------------------------------------------------
results <- list()

for (sp in specs) {
  message("\n==== ", sp$slug, " ====")
  paired <- build_analytic(sp$cat, sp$sub, sp$tp, sp$cmp, sp$fb)
  if (nrow(paired) < 3) {
    message("  skipped — k=", nrow(paired), " < 3")
    next
  }

  write_csv(paired, file.path(OUT_DIR, sprintf("data_%s.csv", sp$slug)))

  long <- to_long(paired)

  m1 <- fit_m1(long, sp$slug)
  saveRDS(m1, file.path(OUT_DIR, sprintf("m1_%s.rds", sp$slug)))
  s1 <- summary(m1)$fixed
  or_med <- exp(s1["ptcy_binary","Estimate"])
  or_lo  <- exp(s1["ptcy_binary","l-95% CI"])
  or_hi  <- exp(s1["ptcy_binary","u-95% CI"])
  tau    <- summary(m1)$random$study_id["sd(Intercept)","Estimate"]
  results[[paste0(sp$slug,"_m1")]] <- tibble(
    slug = sp$slug, model = "m1", k = nrow(paired),
    n_total = sum(paired$ptcy_n + paired$comp_n),
    or_median = or_med, ci_low = or_lo, ci_high = or_hi, tau = tau
  )
  message(sprintf("  m1 OR = %.2f [%.2f, %.2f]  τ = %.2f",
                  or_med, or_lo, or_hi, tau))

  if (isTRUE(sp$m2) && sum(!is.na(long$steroid_pct)) >= 6) {
    m2 <- fit_m2_steroid(long, sp$slug)
    saveRDS(m2, file.path(OUT_DIR, sprintf("m2_%s.rds", sp$slug)))
    s2 <- summary(m2)$fixed
    ptcy_row <- "ptcy_binary"
    tau_val <- summary(m2)$random$study_id["sd(Intercept)","Estimate"]
    results[[paste0(sp$slug,"_m2")]] <- tibble(
      slug = sp$slug, model = "m2_steroid", k = nrow(paired),
      n_total = sum(paired$ptcy_n + paired$comp_n),
      or_median = exp(s2[ptcy_row,"Estimate"]),
      ci_low    = exp(s2[ptcy_row,"l-95% CI"]),
      ci_high   = exp(s2[ptcy_row,"u-95% CI"]),
      tau       = tau_val
    )
    message(sprintf("  m2_steroid OR = %.2f [%.2f, %.2f]  τ = %.2f",
                    exp(s2[ptcy_row,"Estimate"]),
                    exp(s2[ptcy_row,"l-95% CI"]),
                    exp(s2[ptcy_row,"u-95% CI"]),
                    tau_val))
  }
}

# ---------------------------------------------------------------------------
# Assemble Table 2 (post-Block-9 results)
# ---------------------------------------------------------------------------
res_tbl <- bind_rows(results)
write_csv(res_tbl, file.path(OUT_DIR, "Table2_post_block9.csv"))

message("\n=============================================================")
message("Post-Block-9 results table (", nrow(res_tbl), " model fits):")
print(res_tbl, n = Inf)
message("Saved to ", file.path(OUT_DIR, "Table2_post_block9.csv"))
message("All .rds files in ", OUT_DIR, "/")

# ---------------------------------------------------------------------------
# Extract posterior draws for the website
# ---------------------------------------------------------------------------
message("\nExtracting posterior draws for website ...")

model_files <- list.files(OUT_DIR, pattern = "^m[12]_.*\\.rds$", full.names = TRUE)
for (mf in model_files) {
  m <- readRDS(mf)
  post <- as_draws_df(m)
  post_file <- file.path(OUT_DIR, sub("^m[12]_", "post_", basename(mf)))
  saveRDS(post, post_file)
  message(sprintf("  %s → %s (%d draws)", basename(mf), basename(post_file), nrow(post)))
}

message("\nDone. Posterior draws saved to ", OUT_DIR, "/")
message("Run: cd 05_website && quarto render")
