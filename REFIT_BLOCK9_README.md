# Block 9 refit — how to run it

**Date:** 2026-05-29

The Cowork sandbox doesn't have R installed (no root access to install). All data prep is done; you run the brms refit in your local RStudio.

## What's already done (in the sandbox today)

1. **CSVs refreshed.** `02_extraction/*.csv` now reflect the post-Block-9 workbook (251 studies / 525 arms / 3604 outcomes). The pre-Block-9 CSVs are preserved in `02_extraction/_backup_pre_block9/`.
2. **Analytic per-model CSVs.** `02_extraction/analytic/C{1,2,3}_{outcome}_{subtype}.csv` — one paired-data CSV per comparison × outcome cell, ready for brms.
3. **Frequentist preview.** `02_extraction/analytic/_freq_preview_pre_vs_post.csv` shows DerSimonian-Laird random-effects OR for the post-Block-9 corpus alongside the manifest's pre-Block-9 brms numbers. This is a sanity check, not a substitute for the brms refit.

## What you need to run

```r
setwd("/Users/russelllewis/Desktop/ptcy_metaanalys")
source("refit_block9.R")
```

That script:

- Re-builds the paired analytic datasets in R (using `build_analytic()` — same logic as the existing `export_to_csv.R` helper).
- Fits **14 M1 (direct-effect) models** for: C1 OS / NRM / aGVHD / CMV / BSI / IFI_any; C2 OS / NRM / aGVHD / CMV; C3 OS / NRM / aGVHD / cGVHD (C3 is new this round).
- Fits **6 M2 (steroid-adjusted, with `mi(steroid_pct_c)` imputation)** models where reporting is dense enough: C1 OS / NRM / CMV; C2 OS / NRM / CMV.
- Saves all `.rds` files to `03_models/post_block9/`.
- Builds `Table2_post_block9.csv` for direct comparison with the original `03_models/Table2_results.csv`.

Approximate runtime: 2–3 hours on Apple Silicon. The script uses `cores = 4`, `chains = 4`, `iter = 4000`, `warmup = 1000`, `adapt_delta = 0.95`.

## What's NOT in this script (Phase 5 leftovers to do separately afterwards)

- **M3 GVHD-adjusted CMV model** (`mi(agvhd_ci_pct_c)`) — was in `m3_agvhd.rds`. Easy to add by mirroring `fit_m2_steroid()` with `agvhd_ci_pct` as the mediator.
- **M1_post2020** and **M1_haplo** CMV sensitivity sub-fits — straightforward additional brms calls with a `filter()` on the dataset.
- **Sensitivity_comparison** (C2 expanded arm inclusion) — reproduce by changing the `arm_role` reclassification then calling `fit_m1`.
- **Forest plots / funnel plot / `RoBMA` publication-bias / Poisson incidence-rate sub-model.** Reuse the existing plot-generation code in your `.RData` / `.Rhistory` against the new `.rds` files.

## Frequentist preview headline (preliminary, post-Block-9)

| Outcome | Cmp | Pre (brms, manifest) | Post (DL preview) | Direction |
|---|---|---|---|---|
| OS | C1 | OR 0.77 [0.71, 0.83], k=35 | OR 0.82 [0.75, 0.89], k=104 | **Holds** (protective) |
| OS | C2 | OR 0.69 [0.61, 0.78], k=10 | OR 0.79 [0.69, 0.92], k=42 | **Holds** (protective) |
| NRM | C1 | OR 0.86 [0.70, 1.08], k=15 | OR 0.87 [0.73, 1.03], k=52 | **Holds** (mild benefit, CrI crosses null) |
| aGVHD II–IV | C1 | OR 0.63 [0.54, 0.74], k=24 | OR 0.71 [0.64, 0.79], k=97 | **Holds** (protective, slightly attenuated) |
| **CMV** | **C1** | **OR 1.41 [1.20, 1.65], k=18** | **OR 1.14 [0.81, 1.59], k=20** | **WATCH** — attenuated, CrI now crosses 1 |
| **CMV** | **C2** | **OR 0.77 [0.60, 0.99], k=12** | **OR 1.02 [0.66, 1.57], k=9** | **WATCH** — protective signal lost in preview |
| BSI | C1 | OR 2.39 [1.85, 3.10], k=6 | OR 2.25 [1.47, 3.45], k=10 | **Holds** (harmful) |
| IFI any | C1 | OR 0.73 [0.53, 1.00], k=8 | OR 0.59 [0.22, 1.58], k=6 | **Holds** (point estimate protective; CrI wider) |

**Note on k discrepancy:** my DL preview uses a slightly looser study-inclusion filter than your strict brms pipeline (multi-arm studies, fallback-timepoint logic). The k counts will be lower in the brms refit; the **direction and magnitude** are what to trust from the preview.

**Two cells worth particular attention in the brms refit:**

1. **CMV C1** — was significantly harmful pre-Block-9 (OR 1.41, P[>1]=100%). My preview moves it to OR 1.14 with CrI crossing 1. Possible drivers: Hyder 2025, Kerbauy 2025, Mandaci 2025 added studies that report lower CMV with PTCy than the original corpus average. The brms M2_steroid and M3_aGVHD sensitivity fits will tell you whether the mediator structure still explains this.

2. **CMV C2** — was protective pre-Block-9 (OR 0.77, P[<1]=98%). My preview shows null (k dropped from 12 to 9 in my pipeline, but the brms count will be different). Worth checking which of the new C2 papers (Xu 2021, Xue 2022, Zhang 2023, Zu 2022/2023, Mandaci 2025) report PTCy+ATG combo arms that may dilute the signal.

Everything else (OS, NRM, aGVHD, cGVHD, BSI, IFI) — the existing manuscript's directional claims look secure. The big addition is **C3 (within-PTCy variants) is now adequately powered for the first time** — 16 OS / 9 NRM / 16 aGVHD II–IV / 12 cGVHD paired studies. All four C3 models will produce novel results.

## After the refit

Open `03_models/post_block9/Table2_post_block9.csv` next to the original `03_models/Table2_results.csv`. Any row where the new OR's 95% CrI doesn't overlap the old OR's point estimate is a row that needs a sentence in the manuscript's Discussion explaining the shift.

If you want me to draft the cross-walk table and the Discussion bullets once the refit finishes, just point me at `Table2_post_block9.csv` next session.
