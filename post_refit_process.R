# ---------------------------------------------------------------------------
# PTCy meta-analysis — Post-refit processing
#
# Run AFTER refit_block9.R completes.
# 1. Extracts posterior draws from all fitted brms models
# 2. Saves them in the format the website expects (post_*.rds)
# 3. Copies clean brms datasets for website
# 4. Generates frequentist sanity-check models (metafor)
# 5. Compares pre-Block-9 vs post-Block-9 results
#
# Usage:
#   source("post_refit_process.R")
# ---------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(readr); library(dplyr); library(brms); library(posterior)
  library(metafor); library(tibble)
})

POST_DIR <- "03_models/post_block9"
PRE_DIR  <- "03_models"

if (!dir.exists(POST_DIR)) stop("Run refit_block9.R first — ", POST_DIR, " not found.")

# ---------------------------------------------------------------------------
# 1. Extract posterior draws from all model .rds files
# ---------------------------------------------------------------------------
message("=== Extracting posterior draws ===")

model_files <- list.files(POST_DIR, pattern = "^m[12]_.*\\.rds$", full.names = TRUE)
if (length(model_files) == 0) stop("No model files found in ", POST_DIR)

for (mf in model_files) {
  m <- readRDS(mf)
  post <- as_draws_df(m)
  
  # Map model file name to posterior file name
  # m1_c1_os.rds → post_c1_os.rds; m2_c1_os.rds → post_m2_c1_os.rds
  bn <- basename(mf)
  if (grepl("^m1_", bn)) {
    post_name <- sub("^m1_", "post_", bn)
  } else if (grepl("^m2_", bn)) {
    post_name <- sub("^m2_", "post_m2_", bn)
  } else {
    post_name <- paste0("post_", bn)
  }
  
  saveRDS(post, file.path(POST_DIR, post_name))
  message(sprintf("  %s → %s (%d draws)", bn, post_name, nrow(post)))
}

# ---------------------------------------------------------------------------
# 2. Save clean brms datasets (for website data tables)
# ---------------------------------------------------------------------------
message("\n=== Saving clean datasets ===")
data_files <- list.files(POST_DIR, pattern = "^data_.*\\.csv$", full.names = TRUE)
for (df in data_files) {
  d <- read_csv(df, show_col_types = FALSE)
  rds_name <- sub("\\.csv$", ".rds", basename(df))
  rds_name <- sub("^data_", "", rds_name)
  rds_name <- paste0(rds_name, "_brms_clean.rds")
  # Convert to long format for website compatibility
  saveRDS(d, file.path(POST_DIR, rds_name))
  message(sprintf("  %s → %s", basename(df), rds_name))
}

# ---------------------------------------------------------------------------
# 3. Generate frequentist sanity checks
# ---------------------------------------------------------------------------
message("\n=== Frequentist sanity checks ===")

data_files <- list.files(POST_DIR, pattern = "^data_.*\\.csv$", full.names = TRUE)
freq_results <- list()

for (df in data_files) {
  d <- read_csv(df, show_col_types = FALSE)
  slug <- sub("^data_", "", sub("\\.csv$", "", basename(df)))
  
  if (nrow(d) < 3) next
  
  tryCatch({
    es <- escalc(measure = "OR", ai = ptcy_e, bi = ptcy_n - ptcy_e,
                 ci = comp_e, di = comp_n - comp_e, data = d)
    res <- rma(yi, vi, data = es, method = "REML")
    
    freq_results[[slug]] <- tibble(
      slug = slug,
      freq_or = exp(res$beta[1]),
      freq_ci_lo = exp(res$ci.lb),
      freq_ci_hi = exp(res$ci.ub),
      I2 = res$I2,
      tau2 = res$tau2,
      k = res$k
    )
    
    saveRDS(res, file.path(POST_DIR, paste0("res_freq_", slug, ".rds")))
    message(sprintf("  %s: freq OR = %.2f [%.2f, %.2f], I² = %.0f%%",
                    slug, exp(res$beta[1]), exp(res$ci.lb), exp(res$ci.ub), res$I2))
  }, error = function(e) {
    message(sprintf("  %s: FAILED — %s", slug, e$message))
  })
}

if (length(freq_results) > 0) {
  freq_tbl <- bind_rows(freq_results)
  write_csv(freq_tbl, file.path(POST_DIR, "freq_results.csv"))
}

# ---------------------------------------------------------------------------
# 4. Compare pre vs post Block-9 results
# ---------------------------------------------------------------------------
message("\n=== Pre vs Post Block-9 comparison ===")

pre_file <- file.path(PRE_DIR, "Table2_results.csv")
post_file <- file.path(POST_DIR, "Table2_post_block9.csv")

if (file.exists(pre_file) && file.exists(post_file)) {
  pre <- read_csv(pre_file, show_col_types = FALSE)
  post <- read_csv(post_file, show_col_types = FALSE)
  
  comp <- post |>
    left_join(pre, by = c("slug", "model"), suffix = c("_post", "_pre")) |>
    mutate(
      or_shift = or_median_post - or_median_pre,
      k_change = k_post - k_pre,
      cri_overlap = ci_low_post <= ci_high_pre & ci_high_post >= ci_low_pre
    ) |>
    select(slug, model, k_pre, k_post, k_change,
           or_median_pre, or_median_post, or_shift,
           ci_low_pre, ci_high_pre, ci_low_post, ci_high_post, cri_overlap)
  
  write_csv(comp, file.path(POST_DIR, "pre_vs_post_comparison.csv"))
  message("\nComparison saved to ", file.path(POST_DIR, "pre_vs_post_comparison.csv"))
  print(comp, n = Inf)
  
  non_overlap <- comp |> filter(!cri_overlap)
  if (nrow(non_overlap) > 0) {
    message("\n⚠ NON-OVERLAPPING CrIs detected — investigate:")
    print(non_overlap)
  } else {
    message("\n✓ All CrIs overlap between pre and post Block-9.")
  }
} else {
  message("  Skipping comparison — pre or post Table2 not found.")
}

# ---------------------------------------------------------------------------
# 5. Copy posterior files to match website naming convention
# ---------------------------------------------------------------------------
message("\n=== Creating website-compatible posterior files ===")

# The website expects files like:
#   post_os.rds, post_m2_os.rds, post_nrm.rds, post_agvhd.rds,
#   post_m1.rds (CMV), post_m2.rds (CMV), post_bsi.rds, post_ifi.rds,
#   post_c2_os.rds, post_c2_m2_os.rds, etc.

# Mapping from refit slugs to website names
name_map <- list(
  # C1
  "post_c1_os.rds"      = "post_os.rds",
  "post_m2_c1_os.rds"   = "post_m2_os.rds",
  "post_c1_nrm.rds"     = "post_nrm.rds",
  "post_m2_c1_nrm.rds"  = "post_m2_nrm.rds",
  "post_c1_agvhd.rds"   = "post_agvhd.rds",
  "post_c1_cmv.rds"     = "post_m1.rds",       # CMV M1 was named post_m1.rds
  "post_m2_c1_cmv.rds"  = "post_m2.rds",       # CMV M2 was named post_m2.rds
  "post_c1_bsi.rds"     = "post_bsi.rds",
  "post_c1_ifi_any.rds" = "post_ifi.rds",
  # C2
  "post_c2_os.rds"      = "post_c2_os.rds",
  "post_m2_c2_os.rds"   = "post_c2_m2_os.rds",
  "post_c2_nrm.rds"     = "post_c2_nrm.rds",
  "post_m2_c2_nrm.rds"  = "post_c2_m2_nrm.rds",
  "post_c2_agvhd.rds"   = "post_c2_agvhd.rds",
  "post_c2_cmv.rds"     = "post_c2_cmv.rds",
  "post_m2_c2_cmv.rds"  = "post_c2_m2_cmv.rds"
)

for (src_name in names(name_map)) {
  src_path <- file.path(POST_DIR, src_name)
  dst_name <- name_map[[src_name]]
  dst_path <- file.path(POST_DIR, dst_name)
  if (file.exists(src_path)) {
    file.copy(src_path, dst_path, overwrite = TRUE)
    message(sprintf("  %s → %s", src_name, dst_name))
  } else {
    message(sprintf("  [SKIP] %s not found", src_name))
  }
}

message("\n=== Post-refit processing complete ===")
message("Website posterior files are in: ", POST_DIR, "/")
message("Next: update 05_website/_common.R model_dir, then: cd 05_website && quarto render")
