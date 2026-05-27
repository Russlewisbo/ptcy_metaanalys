# PTCy meta-analysis — 03_models/ manifest

**Date saved:** 2026-05-27  
**Outcome:** CMV any-reactivation (Comparison 1: PTCy vs CNI+MTX/MMF)  
**Endpoint strategy:** Strategy C — `any_reactivation`, D+100 > D+180 > end_of_followup (priority order)  
**Session:** Positron R 4.5.1 · brms 2.23.0 · rstan backend  

---

## Brms model objects

| File | Model | k | N | Description |
|---|---|---|---|---|
| `m1.rds` | M1 | 18 | 3,357 | Direct-effect RE model: `events_n ~ ptcy_binary + tp_early + (1\|study_id)` |
| `m2.rds` | M2 | 18 | 3,357 | GVHD-mediation model: adds `mi(steroid_pct_c)` + MI imputation for 4 studies |
| `m1_post2020.rds` | M1_sens | 13 | 2,685 | Post-2020 sensitivity (letermovir era): same formula as M1 |
| `m1_haplo.rds` | M1_haplo | 11 | 2,227 | Haplo-donor sensitivity (haplo ≥50% in PTCy arm): same formula as M1 |

### Key posterior summaries

| Model | PTCy OR (median) | 95% CrI | P(OR>1) | P(OR>1.5) | τ (median) |
|---|---|---|---|---|---|
| M1 — full corpus | 1.41 | [1.20, 1.65] | 100% | 22% | 0.57 |
| M2 — GVHD-adjusted | 1.43 | [1.18, 1.73] | 100% | 31% | 0.60 |
| M1_sens — post-2020 | 1.80 | [1.49, 2.18] | 100% | 97% | 0.63 |
| M1_haplo — haplo-only | 1.70 | [1.39, 2.10] | 100% | 89% | 0.61 |

### Model priors (M1 / M1_sens / M1_haplo — shared)

| Parameter | Prior | Rationale |
|---|---|---|
| β_ptcy | Normal(0, 0.82) | OR 0.25–4.0 at 95% — plausible clinical range |
| β_tp_early | Normal(0, 0.50) | Timepoint offset; tight |
| Intercept | Normal(0, 1.50) | Baseline rates 7–93% |
| τ (sd_study_id) | HalfNormal(0, 0.50) | Weakly informative; consistent with metafor τ̂=0.56 |

### Additional M2 priors

| Parameter | Prior |
|---|---|
| β_steroid | Normal(0, 0.04) — per 1pp steroid change |
| Imputation intercept | Normal(30, 20) |
| Imputation sigma | Exponential(1) |

### M2 steroid covariate result

- β_steroid = 0.024 [0.016, 0.034]; OR per +10pp steroid = 1.27 [1.17, 1.41]; P(β>0) = 100%
- **No mediation**: PTCy OR unchanged at 1.43 after steroid adjustment

---

## Analytic datasets

| File | Rows | Cols | Description |
|---|---|---|---|
| `cmv_brms_clean.rds` | 36 | 19 | Primary dataset: 1 row per arm, 18 paired studies. Multi-arm studies pooled. |
| `cmv_m2.rds` | 36 | 19 | M2 variant: `steroid_pct_c` NaN replaced with NA for brms MI |
| `cmv_post2020.rds` | 26 | 19 | Post-2020 subset: pub_year ≥ 2020 (k=13) |
| `cmv_haplo.rds` | 22 | 19 | Haplo-only subset: donor_haplo_pct ≥ 50% in PTCy arm (k=11) |
| `strat_C.rds` | 18 | 14 | Wide paired format (PTCy vs control per study) — used for metafor |

### Key dataset columns

- `study_id`, `cohort_id`, `first_author`, `pub_year`, `study_design`
- `ptcy_used` (Y/N), `ptcy_binary` (1/0)
- `events_n`, `denom_n` — CMV any-reactivation counts
- `timepoint` — D+100 / D+180 / end_of_followup (Strategy C priority)
- `tp_early` — 1 if D+100 or D+180, 0 if EoF
- `steroid_pct` — arm-level systemic steroid exposure % (75% non-missing)
- `steroid_pct_c` — centred version (grand mean subtracted)
- `agvhd_ci_pct` — aGVHD II-IV cumulative incidence % at D+100 (55% non-missing)
- `agvhd_ci_pct_c` — centred version
- `era_modern` — 1 if pub_year ≥ 2018

---

## Posterior draws

| File | Draws | Chains | Description |
|---|---|---|---|
| `post_m1.rds` | 12,000 | 4×3,000 | Full corpus M1 draws_df |
| `post_m2.rds` | 12,000 | 4×3,000 | GVHD-adjusted M2 draws_df |
| `post_m1_post2020.rds` | 12,000 | 4×3,000 | Post-2020 sensitivity draws_df |
| `post_m1_haplo.rds` | 12,000 | 4×3,000 | Haplo-only sensitivity draws_df |

### Key column names in draws

- `b_ptcy_binary` — log-OR for PTCy (M1, M1_sens, M1_haplo)
- `b_eventsn_ptcy_binary` — log-OR for PTCy in M2 (multivariate model)
- `bsp_eventsn_misteroid_pct_c` — steroid covariate β in M2
- `sd_study_id__Intercept` — τ in M1/M1_sens/M1_haplo
- `sd_study_id__eventsn_Intercept` — τ in M2

---

## Frequentist metafor objects (sanity checks)

| File | k | Endpoint | OR | 95% CI | I² |
|---|---|---|---|---|---|
| `res_d100.rds` | 5 | any_react D+100 only | 1.12 | [0.78, 1.62] | 26% |
| `res_d100_d180.rds` | 7 | any_react D+100>D+180 | 1.09 | [0.79, 1.51] | 20% |
| `res_stratC.rds` | 18 | any_react Strategy C | 1.22 | [0.87, 1.71] | 69% |

---

## Heterogeneity investigation (from M1 random effects)

τ = 0.57 [0.40, 0.86]. Two primary drivers identified:

1. **CMV seroprevalence / geography**: High-seroprevalence centres (Brazil, China, Russia) show
   positive REs (Kerbauy, Liu YC, Pirogova); low-seroprevalence Western centres cluster near null.

2. **Letermovir prophylaxis asymmetry (post-2020)**: Control arms benefited more from letermovir,
   widening the PTCy–CMV gap rather than closing it (post-2020 OR = 1.80 vs full-corpus 1.41).

Notable outlier studies (|RE| > 0.5, 95% CrI excludes 0):
- Negative: Khimani 2021 (−0.94), Iqbal 2023 (−0.86), Haebe 2023 (−0.71), Jamy 2022 (−0.58)
- Positive: Kerbauy 2021 (+0.83), Liu YC 2025 (+0.66), Pirogova 2016 (+0.51)

---

## Reload instructions

```r
library(brms); library(dplyr)

m1          <- readRDS("03_models/m1.rds")
m2          <- readRDS("03_models/m2.rds")
m1_post2020 <- readRDS("03_models/m1_post2020.rds")
m1_haplo    <- readRDS("03_models/m1_haplo.rds")

cmv_brms_clean <- readRDS("03_models/cmv_brms_clean.rds")
post_m1        <- readRDS("03_models/post_m1.rds")
or_m1          <- exp(post_m1$b_ptcy_binary)
tau_m1         <- post_m1$`sd_study_id__Intercept`
```
