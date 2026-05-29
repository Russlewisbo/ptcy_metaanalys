# ── Shared setup for PTCy meta-analysis Quarto website ──
# Sourced at the top of each .qmd page

library(tidyverse)
library(brms)
library(metafor)
library(knitr)
library(kableExtra)

# ── JAMA-style colour palette ──
jama_navy      <- "#2b5c8a"
jama_blue      <- "#4a8cc2"
jama_light_blue <- "#a3c1d4"
jama_steel     <- "#6b7d8d"
jama_grey      <- "#808080"
jama_light_grey <- "#d4d8dc"
jama_dark      <- "#1a2a3a"
jama_black     <- "#2d2d2d"

jama_cols <- c(
  "PTCy"  = jama_navy,
  "Control" = jama_grey,
  "M1"    = jama_navy,
  "M2"    = jama_steel,
  "M3"    = jama_light_blue,
  "C1"    = jama_navy,
  "C2"    = jama_steel
)

jama_fill <- scale_fill_manual(values = jama_cols)
jama_color <- scale_colour_manual(values = jama_cols)

# ── JAMA ggplot theme ──
theme_jama <- function(base_size = 11) {
  theme_minimal(base_size = base_size) %+replace%
    theme(
      text = element_text(family = "sans", colour = jama_black),
      plot.title = element_text(
        size = rel(1.15), face = "bold", colour = jama_dark,
        hjust = 0, margin = margin(b = 8)
      ),
      plot.subtitle = element_text(
        size = rel(0.9), colour = jama_steel,
        hjust = 0, margin = margin(b = 10)
      ),
      plot.caption = element_text(
        size = rel(0.75), colour = jama_grey,
        hjust = 1, margin = margin(t = 8)
      ),
      axis.title = element_text(size = rel(0.95), colour = jama_dark),
      axis.text = element_text(size = rel(0.85), colour = jama_black),
      axis.line = element_line(colour = jama_dark, linewidth = 0.4),
      axis.ticks = element_line(colour = jama_dark, linewidth = 0.3),
      panel.grid.major = element_line(colour = "#e8eaec", linewidth = 0.3),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white", colour = NA),
      plot.background = element_rect(fill = "white", colour = NA),
      legend.position = "bottom",
      legend.title = element_text(size = rel(0.85), face = "bold"),
      legend.text = element_text(size = rel(0.8)),
      legend.key.size = unit(0.8, "lines"),
      strip.text = element_text(
        size = rel(0.95), face = "bold", colour = jama_dark,
        margin = margin(b = 4, t = 4)
      ),
      strip.background = element_rect(fill = "#f0f2f4", colour = NA),
      plot.margin = margin(10, 10, 10, 10)
    )
}

theme_set(theme_jama())

# ── Data paths (relative to 05_website/) ──
# Post-Block-9 models take priority if they exist
post_block9_dir <- "../03_models/post_block9"
model_dir <- if (dir.exists(post_block9_dir) && length(list.files(post_block9_dir, "post_.*\\.rds$")) > 0) {
  post_block9_dir
} else {
  "../03_models"
}
extract_dir <- "../02_extraction"

# ── Helper: load model posteriors (checks post_block9 first) ──
load_post <- function(file) {
  pb9 <- file.path(post_block9_dir, file)
  pre <- file.path("../03_models", file)
  if (file.exists(pb9)) readRDS(pb9) else readRDS(pre)
}

# ── Helper: load brms model object ──
load_model <- function(file) {
  pb9 <- file.path(post_block9_dir, file)
  pre <- file.path("../03_models", file)
  if (file.exists(pb9)) readRDS(pb9) else readRDS(pre)
}

# ── Helper: find ptcy_binary column (handles both old mi() and new naming) ──
ptcy_col <- function(post) {
  if ("b_ptcy_binary" %in% names(post)) return("b_ptcy_binary")
  if ("b_eventsn_ptcy_binary" %in% names(post)) return("b_eventsn_ptcy_binary")
  stop("Cannot find ptcy_binary column in posterior")
}

# ── Helper: OR summary from posterior draws ──
or_summary <- function(post, col, label = "", comparison = "", model = "M1") {
  or_draws <- exp(post[[col]])
  med <- median(or_draws)
  q <- quantile(or_draws, c(0.025, 0.975))
  data.frame(
    comparison = comparison, outcome = label, model = model,
    or = med, lo = q[[1]], hi = q[[2]],
    p_dir = max(mean(or_draws < 1), mean(or_draws > 1)),
    stringsAsFactors = FALSE
  )
}

# ── Helper: format OR with CrI ──
fmt_or <- function(or, lo, hi, digits = 2) {
  sprintf("%.*f [%.*f\u2013%.*f]", digits, or, digits, lo, digits, hi)
}

# ── Helper: study-level forest plot (ggplot2, JAMA-themed) ──
#   dat: paired data frame with ptcy_e, ptcy_n, comp_e, comp_n, study_id
#   studies_df: studies table with study_id, first_author, pub_year
#   title: plot title string
#   subtitle: optional subtitle
forest_study <- function(dat, studies_df, title, subtitle = NULL) {
  require(metafor)

  # Compute study-level log-ORs (0.5 continuity correction for zero cells)
  es <- escalc(measure = "OR",
               ai = ptcy_e, n1i = ptcy_n,
               ci = comp_e, n2i = comp_n,
               data = dat, add = 0.5, to = "only0")

  # Join author labels

  es <- merge(es, studies_df[, c("study_id", "first_author", "pub_year")],
              by = "study_id", all.x = TRUE)
  es$slab <- paste0(es$first_author, " (", es$pub_year, ")")
  # De-duplicate labels (e.g. multi-arm studies)
  if (any(duplicated(es$slab))) {
    dupes <- duplicated(es$slab) | duplicated(es$slab, fromLast = TRUE)
    es$slab[dupes] <- make.unique(es$slab[dupes], sep = " – ")
  }

  # Fit RE model
  fit <- rma(yi, vi, data = es, method = "REML")

  # Build plot data
  es$or  <- exp(es$yi)
  es$lo  <- exp(es$yi - 1.96 * sqrt(es$vi))
  es$hi  <- exp(es$yi + 1.96 * sqrt(es$vi))
  es$weight <- weights(fit)

  # Order by effect size
  es <- es[order(es$yi), ]
  es$slab <- factor(es$slab, levels = es$slab)

  # Pooled estimate
  pooled <- data.frame(
    slab   = "RE Model",
    or     = exp(coef(fit)),
    lo     = exp(fit$ci.lb),
    hi     = exp(fit$ci.ub),
    weight = NA,
    is_pooled = TRUE
  )
  es$is_pooled <- FALSE
  pd <- rbind(es[, c("slab", "or", "lo", "hi", "weight", "is_pooled")], pooled)
  pd$slab <- factor(pd$slab, levels = c("RE Model", levels(es$slab)))

  # Annotation: OR [CI] text
  pd$label <- sprintf("%.2f [%.2f, %.2f]", pd$or, pd$lo, pd$hi)
  # Weight label for studies only
  pd$wt_label <- ifelse(pd$is_pooled, "",
                        sprintf("%.1f%%", pd$weight))

  # Heterogeneity annotation
  het_text <- sprintf("RE Model (I\u00B2 = %.0f%%, \u03C4 = %.2f, p = %s)",
                      fit$I2, sqrt(fit$tau2),
                      ifelse(fit$QEp < 0.001, "< 0.001", sprintf("%.3f", fit$QEp)))

  # Subtitle with k and total N
  n_total <- sum(dat$ptcy_n) + sum(dat$comp_n)
  auto_sub <- sprintf("k = %d studies, N = %s", fit$k, format(n_total, big.mark = ","))
  if (!is.null(subtitle)) auto_sub <- paste0(subtitle, " · ", auto_sub)

  ggplot(pd, aes(x = or, y = slab)) +
    geom_vline(xintercept = 1, linetype = "dashed", colour = jama_grey, linewidth = 0.4) +
    # Study-level estimates
    geom_pointrange(
      data = subset(pd, !is_pooled),
      aes(xmin = lo, xmax = hi),
      size = 0.35, linewidth = 0.4, colour = jama_navy
    ) +
    # Pooled diamond
    geom_pointrange(
      data = subset(pd, is_pooled),
      aes(xmin = lo, xmax = hi),
      shape = 18, size = 0.7, linewidth = 0.7, colour = jama_dark
    ) +
    scale_x_log10() +
    labs(x = "Odds Ratio (log scale)", y = NULL,
         title = title, subtitle = auto_sub,
         caption = het_text) +
    theme_jama(base_size = 10) +
    theme(
      axis.text.y = element_text(
        face = ifelse(levels(pd$slab) == "RE Model", "bold", "plain"),
        size = rel(0.85)
      ),
      plot.caption = element_text(hjust = 0, size = rel(0.8))
    )
}

# ── Helper: GRADE symbol ──
grade_sym <- function(level) {
  switch(tolower(level),
    "high"     = "\u2295\u2295\u2295\u2295",
    "moderate" = "\u2295\u2295\u2295\u2296",
    "low"      = "\u2295\u2295\u2296\u2296",
    "very low" = "\u2295\u2296\u2296\u2296",
    level
  )
}
