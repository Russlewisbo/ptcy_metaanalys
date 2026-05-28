# PTCy meta-analysis — 03_models/ manifest

**Last updated:** 2026-05-27 (expanded with Comparison 2)  
**Project:** PTCy meta-analysis — Bayesian random-effects models  
**Session:** R 4.5.1 · brms 2.23.0 · rstan backend · 4 chains × 3,000 post-warmup draws  
**Working directory:** `ptcy_metaanalys/`

---

## Quick-reference: All Outcome Posteriors

| Outcome | Model | k | N | OR (median) | 95% CrI | P(directional) | τ |
|---|---|---|---|---|---|---|---|
| **Overall survival** | M1 | 35 | 17,661 | 0.77 | [0.71, 0.83] | P(<1) = 100% | 0.59 |
| | M2 (+steroid) | 35 | 17,661 | 0.83 | [0.75, 0.92] | P(<1) = 100% | 0.54 |
| **Non-relapse mortality** | M1 | 15 | 2,081 | 0.86 | [0.70, 1.08] | P(<1) = 90% | 0.56 |
| | M2 (+steroid) | 15 | 2,081 | 1.02 | [0.79, 1.33] | P(<1) = 43% | 0.40 |
| **aGVHD grade II–IV** | M1 | 24 | 3,837 | 0.63 | [0.54, 0.74] | P(<1) = 100% | 0.66 |
| **CMV any-reactivation** | M1 | 18 | 3,357 | 1.41 | [1.20, 1.65] | P(>1) = 100% | 0.57 |
| | M2 (+steroid) | 18 | 3,357 | 1.43 | [1.18, 1.73] | P(>1) = 100% | 0.60 |
| | M3 (+aGVHD CI%) | 18 | 3,357 | 1.52 | [1.25, 1.87] | P(>1) = 100% | 0.56 |
| | M1_sens post-2020 | 13 | 2,685 | 1.80 | [1.49, 2.18] | P(>1) = 100% | 0.63 |
| | M1_haplo haplo≥50% | 11 | 2,227 | 1.70 | [1.39, 2.10] | P(>1) = 100% | 0.61 |
| **BSI any pathogen** | M1 | 6 | 1,319 | 2.39 | [1.85, 3.10] | P(>1) = 100% | 0.64 |
| **IFI any** | M1 | 8 | 3,816 | 0.73 | [0.53, 1.00] | P(<1) = 97.5% | 1.05 |
| | M1 excl. Yanada | 7 | 3,575 | 0.75 | [0.54, 1.02] | P(<1) = 96.5% | 0.38 |

**Key mediation finding (C1):** NRM benefit is completely steroid-mediated (M1 OR 0.86 → M2 OR 1.02); OS benefit is only partially mediated (M1 OR 0.77 → M2 OR 0.83, 29% attenuation); CMV harm is steroid-independent (M1 1.41 → M2 1.43, no attenuation).

### Comparison 2: PTCy vs ATG (k = 40 paired studies)

| Outcome | Model | k | N | OR (median) | 95% CrI | P(directional) | τ |
|---|---|---|---|---|---|---|---|
| **Overall survival** | M1 | 10 | 10,624 | 0.69 | [0.61, 0.78] | P(<1) = 100% | 0.56 |
| | M2 (+steroid) | 10 | 10,624 | 0.78 | [0.68, 0.90] | P(<1) = 99.9% | 0.70 |
| **Non-relapse mortality** | M1 | 5 | 1,186 | 0.65 | [0.43, 0.97] | P(<1) = 98.2% | 0.38 |
| | M2 (+steroid, MI) | 5 | 1,186 | 0.76 | [0.48, 1.16] | P(<1) = 90% | 0.21 |
| **aGVHD grade II–IV** | M1 | 6 | 784 | 0.59 | [0.42, 0.84] | P(<1) = 99.8% | 0.27 |
| **CMV any-reactivation** | M1 | 12 | 1,267 | 0.77 | [0.60, 0.99] | P(<1) = 98% | 0.53 |
| | M2 (+steroid) | 12 | 1,267 | 0.82 | [0.64, 1.05] | P(<1) = 93.7% | 0.58 |

**Key mediation finding (C2):** OS benefit partially attenuates (0.69→0.78, ~30%); NRM attenuates and CrI crosses null (0.65→0.76); pattern parallels C1.

**Key cross-comparison finding:** CMV direction reverses — harmful vs CNI+MTX (C1 OR 1.41) but protective vs ATG (C2 OR 0.77). ATG causes deeper T-cell depletion than PTCy, making the comparator's immunosuppressive depth the key determinant.

**Sparse outcomes not modeled (C2):** BSI (k=3) and IFI (k=4) had too few paired studies for random-effects modeling.

### Comparison 2: Sensitivity — expanded arm inclusion

Reclassifies PTCy+ATG combo arms (n=7) as PTCy-side, mixed-ATG arms (n=2) by `ptcy_used`, excludes "neither" arms (n=3). Adds 6 previously unpaired studies.

| Outcome | Primary OR [CrI] | Sensitivity OR [CrI] | k (prim → sens) | Interpretation |
|---|---|---|---|---|
| OS | 0.69 [0.61, 0.78] | 0.74 [0.66, 0.83] | 10 → 11 | Robust |
| aGVHD II–IV | 0.59 [0.42, 0.84] | 0.59 [0.45, 0.78] | 6 → 8 | Robust (CrI narrows) |
| CMV | 0.77 [0.60, 0.99] | 0.91 [0.75, 1.12] | 12 → 14 | Attenuates; PTCy+ATG combo dilutes signal |

NRM unchanged (no new studies contributed data).

---

## Brms Model Objects

### Comparison 1 (C1): PTCy vs CNI+MTX/MMF

#### Survival outcomes

| File | Size | Outcome | Model | k | N | Formula |
|---|---|---|---|---|---|---|
| `m1_os.rds` | 6.4 MB | Overall survival | M1 direct | 35 | 17,661 | `events_n \| trials(denom_n) ~ ptcy_binary + tp_early + (1\|study_id)` |
| `m2_os.rds` | 8.6 MB | Overall survival | M2 steroid | 35 | 17,661 | adds `mi(steroid_pct_c)`; 7 studies imputed |
| `m1_nrm.rds` | 4.1 MB | NRM | M1 direct | 15 | 2,081 | same formula as M1_os |
| `m2_nrm.rds` | 5.4 MB | NRM | M2 steroid | 15 | 2,081 | adds `mi(steroid_pct_c)`; 3 studies imputed |

##### GVHD outcome

| File | Size | Outcome | Model | k | N | Notes |
|---|---|---|---|---|---|---|
| `m1_agvhd.rds` | 5.1 MB | aGVHD grade II–IV | M1 direct | 24 | 3,837 | D+100 dominant (k=23); 1 D+180 |

##### CMV outcome (primary + sensitivity models)

| File | Size | Model | k | N | Notes |
|---|---|---|---|---|---|
| `m1.rds` | 4.4 MB | M1 direct | 18 | 3,357 | Full corpus, Strategy C |
| `m2.rds` | 5.8 MB | M2 steroid-adjusted | 18 | 3,357 | `mi(steroid_pct_c)`; 4 studies imputed |
| `m3_agvhd.rds` | 7.6 MB | M3 aGVHD-adjusted | 18 | 3,357 | `mi(agvhd_ci_pct_c)`; 8 studies imputed |
| `m1_post2020.rds` | 3.8 MB | M1_sens post-2020 | 13 | 2,685 | pub_year ≥ 2020 |
| `m1_haplo.rds` | 3.6 MB | M1_haplo haplo-only | 11 | 2,227 | donor_haplo_pct ≥ 50% in PTCy arm |

##### Infection outcomes (BSI, IFI)

| File | Size | Outcome | Model | k | N | Timepoint strategy |
|---|---|---|---|---|---|---|
| `m1_bsi.rds` | 3.5 MB | BSI any pathogen | M1 direct | 6 | 1,319 | D+100 > D+180 > EoF > D+30 |
| `m1_ifi.rds` | 3.7 MB | IFI any | M1 direct | 8 | 3,816 | D+100 > D+180 > EoF > D+365 |

**Note on BSI:** 7 of 13 initially paired studies had NR (not-reported) event counts and are excluded from `bsi_brms_clean.rds`. The 6 retained studies are: Meyer 2025, Salas 2022, Cao 2022, Guo 2026, Li 2022, Mikulska 2018.

**Note on IFI:** Yanada 2026 has 0 IFI events in 241 PTCy patients (zero-event arm; ultra-modern prophylaxis era). This single study accounts for essentially all of the IFI τ = 1.05; excluding it collapses τ to 0.38 while barely moving the OR (0.73→0.75). See `loo_ifi.rds`.

### Comparison 2 (C2): PTCy vs ATG

**Arm classification:** 101 arms eligible → 82 clean PTCy-only (ptcy=Y, atg=N) vs ATG-only (ptcy=N, atg=Y) arms in 40 paired studies. Excluded: 7 PTCy+ATG combo, 2 mixed, 3 neither (no PTCy/no ATG), 7 unpaired single-side studies.

**Shared formula:** Same as C1 M1: `events_n | trials(denom_n) ~ ptcy_binary + tp_early + (1|study_id)`. aGVHD drops `tp_early` (all D+100).

#### Primary models

| File | Size | Outcome | Model | k | N | Notes |
|---|---|---|---|---|---|---|
| `c2_m1_os.rds` | 3.7 MB | OS | M1 direct | 10 | 10,624 | 2yr (k=7), 1yr (k=2), EoF (k=1) |
| `c2_m2_os.rds` | 3.8 MB | OS | M2 steroid | 10 | 10,624 | `steroid_pct_c` directly observed (no MI needed) |
| `c2_m1_nrm.rds` | 3.1 MB | NRM | M1 direct | 5 | 1,186 | 2yr (k=3), D+100 (k=1), EoF (k=1) |
| `c2_m2_nrm.rds` | 3.9 MB | NRM | M2 steroid (MI) | 5 | 1,186 | `mi(steroid_pct_c)`; 1 study (353) imputed |
| `c2_m1_agvhd.rds` | 3.1 MB | aGVHD II–IV | M1 direct | 6 | 784 | All D+100; no `tp_early` term |
| `c2_m1_cmv.rds` | 4.0 MB | CMV | M1 direct | 12 | 1,267 | Strategy C: D+100 (k=3), 1yr (k=3), EoF (k=6) |
| `c2_m2_cmv.rds` | 4.1 MB | CMV | M2 steroid | 12 | 1,267 | `steroid_pct_c` directly observed (no MI needed) |

#### Sensitivity models — expanded arm inclusion

Reclassifies PTCy+ATG arms as PTCy-side, mixed-ATG by `ptcy_used`. Adds 6 studies.

| File | Size | Outcome | k | N | Notes |
|---|---|---|---|---|---|
| `c2_sens_m1_os.rds` | 3.9 MB | OS | 11 | 10,973 | +1 study vs primary |
| `c2_sens_m1_agvhd.rds` | 3.4 MB | aGVHD II–IV | 8 | 1,117 | +2 studies vs primary |
| `c2_sens_m1_cmv.rds` | 4.3 MB | CMV | 14 | 2,020 | +2 studies vs primary; OR attenuates 0.77→0.91 |

NRM unchanged (no new studies contributed NRM data).

#### BSI descriptive supplement (Mantel-Haenszel, k=3)

| File | Size | Description |
|---|---|---|
| `c2_mh_bsi.rds` | <1 KB | `rma.mh` object; MH fixed-effect OR = 2.03 [1.33, 3.09], p = 0.001 |
| `Fig_c2_bsi_mh_forest.pdf` | — | Forest plot (3 studies) |

**I² = 69% (Q-p = 0.04) — sources of heterogeneity:**

1. **Outcome definition mismatch (primary driver).** Meyer 2025 and Berro 2021 define BSI as any positive blood culture (standard microbiological definition). Bordat 2026 defines "severe bacterial infections" as fatal sepsis or those requiring ICU admission — a far more restrictive endpoint capturing only the most severe events. The two any-culture studies show PTCy excess (OR 3.27, 1.35); the ICU/fatal-only study does not (OR 0.91).

2. **Timepoint mismatch.** Meyer and Berro report BSI at D+100; Bordat at D+365 (1 year). The longer window dilutes the early post-transplant period where PTCy-related immunosuppression is most relevant to BSI risk.

3. **Donor-type confound in the dominant study.** Meyer 2025 contributes ~60% of the pooled weight. Its PTCy arm is 54% haploidentical while the ATG arm is 100% MUD — a donor-type imbalance that may inflate the apparent PTCy BSI excess independently of GVHD prophylaxis. In contrast, Berro 2021 (matched MRD pairs, MAC) shows a smaller effect (OR 1.35) and Bordat 2026 (all MRD, RIC) shows none (OR 0.91).

| Study | Definition | Timepoint | Donor (PTCy / ATG) | Conditioning | PTCy rate | ATG rate | OR |
|---|---|---|---|---|---|---|---|
| Meyer 2025 | Any positive blood culture | D+100 | 54% haplo / 100% MUD | RIC | 44.1% | 19.5% | 3.27 |
| Berro 2021 | Bacteremia (any culture) | D+100 | MRD / MRD | MAC | 42.9% | 35.7% | 1.35 |
| Bordat 2026 | Severe BSI (ICU/fatal only) | D+365 | MRD / MRD | RIC | 19.5% | 21.1% | 0.91 |

**Interpretation:** The MH pooled OR should be cited with strong caveats. These three studies are not measuring the same construct. The C2 BSI signal is driven primarily by Meyer 2025, which has the broadest BSI definition and the largest donor-type imbalance.

---

## Posterior Draws

### Comparison 1

All draws_df objects: 12,000 rows × model-specific columns (4 chains × 3,000 post-warmup).

| File | Size | Outcome/model | Key PTCy column | Key τ column |
|---|---|---|---|---|
| `post_os.rds` | 3.6 MB | OS M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_m2_os.rds` | 5.2 MB | OS M2 | `b_eventsn_ptcy_binary` | `sd_study_id__eventsn_Intercept` |
| `post_nrm.rds` | 1.9 MB | NRM M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_m2_nrm.rds` | 2.8 MB | NRM M2 | `b_eventsn_ptcy_binary` | `sd_study_id__eventsn_Intercept` |
| `post_agvhd.rds` | 2.7 MB | aGVHD M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_m1.rds` | 2.2 MB | CMV M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_m2.rds` | 3.2 MB | CMV M2 | `b_eventsn_ptcy_binary` | `sd_study_id__eventsn_Intercept` |
| `post_m3_agvhd.rds` | 3.9 MB | CMV M3 | `b_eventsn_ptcy_binary` | `sd_study_id__eventsn_Intercept` |
| `post_m1_post2020.rds` | 1.7 MB | CMV post-2020 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_m1_haplo.rds` | 1.6 MB | CMV haplo-only | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_bsi.rds` | 1.1 MB | BSI M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_ifi.rds` | 1.3 MB | IFI M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |

### Additional draws column names for M2/M3 steroid/aGVHD covariates (C1)

| Model | Covariate β column |
|---|---|
| CMV M2 | `bsp_eventsn_misteroid_pct_c` |
| NRM M2 | `bsp_eventsn_misteroid_pct_c` |
| OS M2 | `bsp_eventsn_misteroid_pct_c` |
| CMV M3 | `bsp_eventsn_miagvhd_ci_pct_c` |

### Comparison 2

| File | Size | Outcome/model | Key PTCy column | Key τ column |
|---|---|---|---|---|
| `post_c2_os.rds` | 1.5 MB | OS M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_m2_os.rds` | 1.6 MB | OS M2 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_nrm.rds` | 1.1 MB | NRM M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_m2_nrm.rds` | 1.6 MB | NRM M2 | `b_eventsn_ptcy_binary` | `sd_study_id__eventsn_Intercept` |
| `post_c2_agvhd.rds` | 1.1 MB | aGVHD M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_cmv.rds` | 1.7 MB | CMV M1 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_m2_cmv.rds` | 1.8 MB | CMV M2 | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_sens_os.rds` | 1.6 MB | OS sens | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_sens_agvhd.rds` | 1.3 MB | aGVHD sens | `b_ptcy_binary` | `sd_study_id__Intercept` |
| `post_c2_sens_cmv.rds` | 1.9 MB | CMV sens | `b_ptcy_binary` | `sd_study_id__Intercept` |

**Note:** C2 M2 models for OS and CMV use `steroid_pct_c` as a direct covariate (100% observed), so the PTCy column is `b_ptcy_binary` (not `b_eventsn_ptcy_binary`). Only NRM M2 uses `mi()` imputation (1 study missing), giving the multivariate `b_eventsn_ptcy_binary` column name.

---

## Analytic Datasets

### Comparison 1

One row per arm (pooled across multi-arm studies within the same study_id × ptcy_binary combination).

| File | Rows | Outcome | k | N | Notes |
|---|---|---|---|---|---|
| `os_brms_clean.rds` | 70 | Overall survival | 35 | 17,661 | Timepoint: 2yr dominant (k=22), 1yr (k=9), EoF (k=4) |
| `nrm_brms_clean.rds` | 30 | NRM | 15 | 2,081 | Timepoint: 2yr (k=7), 1yr (k=6), EoF (k=2) |
| `agvhd_brms_clean.rds` | 48 | aGVHD II–IV | 24 | 3,837 | Timepoint: D+100 (k=23), D+180 (k=1) |
| `cmv_brms_clean.rds` | 36 | CMV | 18 | 3,357 | Strategy C: D+100 (k=5), D+180 (k=2), EoF (k=11) |
| `cmv_m2.rds` | 36 | CMV (M2 variant) | 18 | 3,357 | steroid_pct NaN→NA for MI |
| `cmv_m3.rds` | 36 | CMV (M3 variant) | 18 | 3,357 | agvhd_ci_pct NaN→NA for MI |
| `cmv_post2020.rds` | 26 | CMV post-2020 | 13 | 2,685 | pub_year ≥ 2020 |
| `cmv_haplo.rds` | 22 | CMV haplo-only | 11 | 2,227 | donor_haplo_pct ≥ 50% in PTCy arm |
| `bsi_brms_clean.rds` | 12 | BSI (pooled) | 6 | 1,319 | 3 control arms in Mikulska 2018 pooled to 1 |
| `ifi_brms_clean.rds` | 16 | IFI (pooled) | 8 | 3,816 | 2 arms in Haebe 2023 pooled |
| `strat_C.rds` | 18 | CMV Strategy C | 18 | 3,357 | Wide format (PTCy + ctrl per row) — metafor input |

### Comparison 2

| File | Rows | Outcome | k | N | Notes |
|---|---|---|---|---|---|
| `c2_os_brms_clean.rds` | 20 | Overall survival | 10 | 10,624 | 2yr (k=7), 1yr (k=2), EoF (k=1) |
| `c2_nrm_brms_clean.rds` | 10 | NRM | 5 | 1,186 | 2yr (k=3), D+100 (k=1), EoF (k=1) |
| `c2_agvhd_brms_clean.rds` | 12 | aGVHD II–IV | 6 | 784 | All D+100 |
| `c2_cmv_brms_clean.rds` | 24 | CMV | 12 | 1,267 | Strategy C: D+100 (k=3), 1yr (k=3), EoF (k=6) |
| `c2_sens_os_brms_clean.rds` | 22 | OS (sensitivity) | 11 | 10,973 | +1 study |
| `c2_sens_agvhd_brms_clean.rds` | 16 | aGVHD (sensitivity) | 8 | 1,117 | +2 studies |
| `c2_sens_cmv_brms_clean.rds` | 28 | CMV (sensitivity) | 14 | 2,020 | +2 studies |

### Key columns (all datasets)

| Column | Description |
|---|---|
| `study_id`, `cohort_id` | Study and cohort identifiers (numeric) |
| `first_author`, `pub_year`, `study_design` | Study metadata |
| `ptcy_used` | "Y" / "N" |
| `ptcy_binary` | 1 = PTCy arm, 0 = control |
| `events_n`, `denom_n` | Outcome event count and denominator |
| `timepoint` | Timepoint used (Strategy C selection) |
| `tp_early` | 1 if D+100 or D+180, 0 if EoF |
| `steroid_pct` | Arm-level systemic steroid exposure % |
| `steroid_pct_c` | Centred version (grand mean subtracted) |
| `agvhd_ci_pct` | aGVHD II–IV cumulative incidence % at D+100 (CMV datasets only) |
| `agvhd_ci_pct_c` | Centred version |
| `era_modern` | 1 if pub_year ≥ 2018 (CMV datasets only) |

---

## Frequentist Metafor Objects (Sanity Checks)

| File | k | Endpoint | OR [95% CI] | I² | τ | Q-p |
|---|---|---|---|---|---|---|
| `res_os_freq.rds` | 35 | OS, 1yr > 2yr > EoF | 0.75 [0.63, 0.89] | 68% | 0.38 | <0.001 |
| `res_nrm_freq.rds` | 15 | NRM, 1yr > 2yr > EoF | 0.78 [0.56, 1.09] | 39% | 0.38 | 0.071 |
| `res_agvhd_freq.rds` | 24 | aGVHD II–IV, D+100 > D+180 > EoF | 0.58 [0.43, 0.78] | 63% | 0.56 | <0.001 |
| `res_stratC.rds` | 18 | CMV any_react, Strategy C | 1.22 [0.87, 1.71] | 69% | 0.56 | <0.001 |
| `res_bsi_freq.rds` | 6 | BSI any_pathogen, D+100 > D+180 > EoF | 2.45 [1.86, 3.21] | 0% | 0.00 | 0.338 |
| `res_ifi_freq.rds` | 8 | IFI any, D+100 > D+180 > EoF | 0.87 [0.35, 2.17] | 82% | 1.12 | <0.001 |
| `res_d100.rds` | 5 | CMV any_react D+100 only | 1.12 [0.78, 1.62] | 26% | 0.21 | 0.365 |
| `res_d100_d180.rds` | 7 | CMV any_react D+100 > D+180 | 1.09 [0.79, 1.51] | 20% | 0.19 | 0.294 |

---

## Sensitivity Analyses

### CMV leave-one-out (not a separate model set — done via sequential brm() refits)
Not stored as individual model objects; summary table only:
- `loo_ifi.rds` (922 B): tibble with OR, CrI, P(<1), τ for all 8 IFI LOO models + full corpus reference row

**Key contrast from LOO:**
| Model | OR [95% CrI] | P(<1) | τ |
|---|---|---|---|
| Full corpus (k=8) | 0.73 [0.53, 1.00] | 97.5% | 1.05 |
| Excl. Yanada 2026 (k=7) | 0.75 [0.54, 1.02] | 96.5% | **0.38** |

Yanada 2026 (0/241 IFI in PTCy arm) is entirely responsible for τ inflation; OR is robust to its exclusion.

---

## Output Files

### Table 2 — Master Results Table

| File | Size | Description |
|---|---|---|
| `Table2_results.html` | 28 KB | Full styled gt table, all 9 model rows (M1 + M2 for survival/CMV, sensitivity rows). Open in browser. |
| `Table2_results.csv` | 2.5 KB | Machine-readable version with all raw posterior estimates |

C1 Table 2 rows (in order):
1. OS M1
2. OS M2 (GVHD-adjusted)
3. NRM M1
4. NRM M2 (GVHD-adjusted)
5. aGVHD grade II–IV M1
6. CMV M1
7. CMV M2 (GVHD-adjusted)
8. CMV sensitivity: post-2020
9. CMV sensitivity: haplo-only

### Comparison 2 Results Tables

| File | Size | Description |
|---|---|---|
| `c2_Table2_results.csv` | <1 KB | M1 + M2 results for all 4 C2 outcomes (7 rows) |
| `c2_sensitivity_comparison.csv` | <1 KB | Primary vs expanded-arm sensitivity comparison (6 rows: 3 outcomes × 2 analyses) |

### Summary Figures

| File | Size | Description |
|---|---|---|
| `Fig_summary_all_outcomes.pdf` | 38 KB | C1 six-outcome dot-and-interval summary forest plot (M1 primary + M2 open circles for OS/NRM). Publication-ready at 10×7 inches. |
| `Fig_summary_all_outcomes.png` | 190 KB | Same figure, 300 dpi PNG |
| `Fig_c2_summary.pdf` | — | C2 four-outcome summary forest plot (OS, NRM, aGVHD, CMV; M1 + M2). 10×7 inches. |
| `Fig_c2_summary.png` | — | Same figure, 300 dpi PNG |
| `Fig_c1_vs_c2_combined.pdf` | — | **Combined forest plot** — C1 and C2 side by side (faceted). All outcomes, M1 + M2. 10×7 inches. |
| `Fig_c1_vs_c2_combined.png` | — | Same figure, 300 dpi PNG |

C1 figure layout: outcomes on y-axis (BSI, CMV, IFI, aGVHD, NRM, OS top-to-bottom), log OR on x-axis; filled circles = M1; open circles = M2 (OS and NRM only); annotated with OR [95% CrI] and τ. Coloured left-margin bars indicate outcome group (survival, GVHD, infection).

Combined figure layout: two facets (C1: PTCy vs CNI+MTX, C2: PTCy vs ATG); outcomes on y-axis; filled circles = M1, open = M2; annotated with OR [95% CrI]. Highlights the CMV direction reversal.

---

## Model Priors (Shared Across All M1 Models)

```r
priors_m1 <- c(
  prior(normal(0, 0.82), class = b,   coef = ptcy_binary),  # OR 0.25–4.0 at 95%
  prior(normal(0, 0.50), class = b,   coef = tp_early),      # timepoint offset
  prior(normal(0, 1.50), class = Intercept),                  # baseline rate 7–93%
  prior(normal(0, 0.50), class = sd,  group = study_id)      # between-study SD
)
```

### M2 Additional Priors (steroid covariate + imputation)

```r
# These differ only in the resp = eventsn tag for multivariate models
prior(normal(0, 0.04), class = b, coef = misteroid_pct_c, resp = eventsn)
prior(normal(30, 20),  class = Intercept,                  resp = steroidpctc)
prior(exponential(1),  class = sigma,                       resp = steroidpctc)
```

### M3 Additional Priors (aGVHD covariate + imputation)

```r
prior(normal(0, 0.05), class = b, coef = miagvhd_ci_pct_c, resp = eventsn)
prior(normal(0, 10),   class = Intercept,                   resp = agvhdcipctc)
prior(exponential(1),  class = sigma,                        resp = agvhdcipctc)
```

---

## MCMC Diagnostics

### Comparison 1

- All models: max R̂ ≤ 1.001, no R̂ > 1.01
- All models: Bulk ESS > 2,800 for all population-level parameters
- IFI M1: min Neff ratio 0.275 (acceptable; driven by imputed rows in LOO variants)
- BSI M1: min Neff ratio 0.289 (acceptable at k=6)
- CMV M3: min Neff ratio 0.24 (acceptable; higher adapt_delta = 0.95 used)

### Comparison 2

- All 10 models: max R̂ ≤ 1.005, no R̂ > 1.01
- All models: Bulk ESS > 1,000; Tail ESS > 400
- `c2_m1_nrm`: lowest Tail ESS = 405 (k=5; acceptable for small corpus)
- `c2_m2_nrm`: MI model; lowest Tail ESS = 1,357
- All other C2 models: min Bulk ESS > 2,200, min Tail ESS > 3,200

---

## Writing Outputs (04_writing/)

| File | Size | Content |
|---|---|---|
| `Results_OS_NRM.md` | 8.0 KB | §3.1: OS and NRM Results text — M1 posteriors, M2 mediation contrast, bridge to aGVHD |
| `Results_infection_outcomes.md` | 11 KB | §3.3: CMV (M1/M2/M3), BSI, IFI (with Yanada LOO), infection synthesis |
| `Discussion_mechanistic_asymmetry.md` | 5.7 KB | ~590-word Discussion paragraph — unifying T-cell lymphodepletion vs GVHD-mediated TRM framework |
| `GRADE_certainty_assessment.md` | 17 KB | Full GRADE table + narrative for all six outcomes |

### GRADE certainty ratings (from `GRADE_certainty_assessment.md`)

| Outcome | Certainty | Key limitation |
|---|---|---|
| Overall survival | ⊕⊕◯◯ LOW | I²=68%; observational; partial steroid confounding |
| Non-relapse mortality | ⊕◯◯◯ VERY LOW | Complete M2 attenuation; CrI crosses null; N=2,081 |
| aGVHD grade II–IV | ⊕⊕◯◯ LOW | I²=63%; observational; upgraded for confounders opposing effect |
| CMV reactivation | ⊕⊕◯◯ LOW | I²=69%; observational; upgraded for sensitivity consistency |
| BSI any pathogen | ⊕◯◯◯ VERY LOW | k=6; 7 studies NR-excluded; small corpus |
| IFI any | ⊕◯◯◯ VERY LOW | τ=1.05 (Yanada-driven); CrI touches null; definition heterogeneity |

---

## Reload Instructions

### Minimal session (posteriors only — fastest)

```r
library(brms); library(dplyr)

# OS
post_os    <- readRDS("03_models/post_os.rds")
post_m2_os <- readRDS("03_models/post_m2_os.rds")
or_os      <- exp(post_os$b_ptcy_binary)
or_m2_os   <- exp(post_m2_os$b_eventsn_ptcy_binary)
tau_os     <- post_os$`sd_study_id__Intercept`

# NRM
post_nrm    <- readRDS("03_models/post_nrm.rds")
post_m2_nrm <- readRDS("03_models/post_m2_nrm.rds")
or_nrm      <- exp(post_nrm$b_ptcy_binary)
or_m2_nrm   <- exp(post_m2_nrm$b_eventsn_ptcy_binary)

# aGVHD
post_agvhd <- readRDS("03_models/post_agvhd.rds")
or_agvhd   <- exp(post_agvhd$b_ptcy_binary)

# CMV (M1, M2, M3, sensitivities)
post_m1         <- readRDS("03_models/post_m1.rds")
post_m2         <- readRDS("03_models/post_m2.rds")
post_m3         <- readRDS("03_models/post_m3_agvhd.rds")
post_m1_haplo   <- readRDS("03_models/post_m1_haplo.rds")
post_m1_post2020<- readRDS("03_models/post_m1_post2020.rds")
or_m1    <- exp(post_m1$b_ptcy_binary)
or_m2    <- exp(post_m2$b_eventsn_ptcy_binary)
or_m3    <- exp(post_m3$b_eventsn_ptcy_binary)

# BSI / IFI
post_bsi <- readRDS("03_models/post_bsi.rds")
post_ifi <- readRDS("03_models/post_ifi.rds")
or_bsi   <- exp(post_bsi$b_ptcy_binary)
or_ifi   <- exp(post_ifi$b_ptcy_binary)

# IFI LOO table
loo_tbl <- readRDS("03_models/loo_ifi.rds")
```

### Full model reload (for diagnostics or extending models)

```r
# ── Comparison 1 ──
m1_os   <- readRDS("03_models/m1_os.rds")
m2_os   <- readRDS("03_models/m2_os.rds")
m1_nrm  <- readRDS("03_models/m1_nrm.rds")
m2_nrm  <- readRDS("03_models/m2_nrm.rds")
m1_agvhd<- readRDS("03_models/m1_agvhd.rds")
m1      <- readRDS("03_models/m1.rds")       # CMV M1
m2      <- readRDS("03_models/m2.rds")       # CMV M2
m3      <- readRDS("03_models/m3_agvhd.rds") # CMV M3
m1_bsi  <- readRDS("03_models/m1_bsi.rds")
m1_ifi  <- readRDS("03_models/m1_ifi.rds")

# ── Comparison 2 ──
c2_m1_os     <- readRDS("03_models/c2_m1_os.rds")
c2_m2_os     <- readRDS("03_models/c2_m2_os.rds")
c2_m1_nrm    <- readRDS("03_models/c2_m1_nrm.rds")
c2_m2_nrm    <- readRDS("03_models/c2_m2_nrm.rds")
c2_m1_agvhd  <- readRDS("03_models/c2_m1_agvhd.rds")
c2_m1_cmv    <- readRDS("03_models/c2_m1_cmv.rds")
c2_m2_cmv    <- readRDS("03_models/c2_m2_cmv.rds")
c2_s_m1_os   <- readRDS("03_models/c2_sens_m1_os.rds")
c2_s_m1_agvhd<- readRDS("03_models/c2_sens_m1_agvhd.rds")
c2_s_m1_cmv  <- readRDS("03_models/c2_sens_m1_cmv.rds")
```

---

### Comparison 2 posteriors reload

```r
# ── Comparison 2 posteriors ──
post_c2_os     <- readRDS("03_models/post_c2_os.rds")
post_c2_m2_os  <- readRDS("03_models/post_c2_m2_os.rds")
post_c2_nrm    <- readRDS("03_models/post_c2_nrm.rds")
post_c2_m2_nrm <- readRDS("03_models/post_c2_m2_nrm.rds")
post_c2_agvhd  <- readRDS("03_models/post_c2_agvhd.rds")
post_c2_cmv    <- readRDS("03_models/post_c2_cmv.rds")
post_c2_m2_cmv <- readRDS("03_models/post_c2_m2_cmv.rds")

# Sensitivity
post_c2_sens_os    <- readRDS("03_models/post_c2_sens_os.rds")
post_c2_sens_agvhd <- readRDS("03_models/post_c2_sens_agvhd.rds")
post_c2_sens_cmv   <- readRDS("03_models/post_c2_sens_cmv.rds")

# C2 results tables
c2_results   <- read.csv("03_models/c2_Table2_results.csv")
c2_sens_comp <- read.csv("03_models/c2_sensitivity_comparison.csv")
```

---

## Remaining Analysis Tasks

The following analyses were planned but not yet completed as of 2026-05-27:

- [ ] **§3.2 aGVHD Results text** — write to `04_writing/Results_aGVHD.md`
- [x] **Comparison 2 analyses** — PTCy vs ATG: M1/M2 for OS, NRM, aGVHD, CMV (completed 2026-05-27)
- [x] **Comparison 2 sensitivity** — expanded arm inclusion (PTCy+ATG, mixed) (completed 2026-05-27)
- [ ] **§3.4 Comparison 2 Results text** — write to `04_writing/Results_C2.md`
- [ ] **Publication bias assessment** — `RoBMA` or Egger's test for outcomes with k ≥ 10
- [ ] **Frequentist sanity checks for C2** — metafor RE models paralleling C1 pipeline
- [ ] **Co-reviewer ROB verification** — BMTD review of `rob` sheet pending
- [ ] **GRADE: confidence intervals in absolute risk terms** — compute risk differences for Table 2
- [ ] **GRADE assessment for C2 outcomes**

---

*Total 03_models/ disk usage: ~151 MB (RDS + figures + tables)*
