# PTCy meta-analysis — project status (resumption doc)

**Date:** 2026-05-29 (updated after Block 9 refit initiated)
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)
**Working folder:** `/Users/russelllewis/Desktop/ptcy_metaanalys/` (git-tracked, R workspace)

---

## Where we are

**Phase 1–3 complete.** Protocol, schema, and corpus extraction finished. v1.2 database locked.

**Phase 4 partially complete.** Self-audit done; BMT director's second-pass spot-check not yet started.

**Phase 5 in progress — Post-Block-9 refit running.**

### Post-Block-9 database (active workbook: `PTCy_MA_extraction_template_v1.2_post_block9.xlsx`)

| Sheet | Pre Block 9 | Post Block 9 |
|---|---:|---:|
| `cohorts` | 160 | **181** |
| `studies` | 220 | **251** |
| `arms` | 457 | **525** |
| `outcomes` | 3,050 | **3,604** |
| `outcomes_subgroup` | 116 | **126** |
| `rob` | 210 | **241** |
| Excluded (PRISMA-tracked) | 190 | **214** |
| **RCTs** | **10** | **14** |

| Comparison eligibility (arms) | Pre | Post | Δ |
|---|---:|---:|---:|
| C1: PTCy vs CNI+MTX/MMF | 301 | 313 | +12 |
| C2: PTCy vs ATG | 101 | 109 | +8 |
| C3: Within-PTCy variants | 29 | 68 | **+39** |

### New RCTs from Block 9
- **Koura 2025** (Blood Advances) — PTCy + abatacept phase 2
- **Zhang 2023** (BJH) — Reduced-dose PTCy + low-dose ATG
- **Zu 2022** (BMT) — Low-dose PTCy + low-dose ATG
- **Zu 2023** (Blood Cancer J) — Low-dose PTCy + ATG RCT

---

## Model refit status (2026-05-29)

### Completed models (Post-Block-9)

| Model | k | OR [95% CrI] | τ | Change from pre-Block-9 |
|---|---:|---|---:|---|
| C1 OS M1 | 40 | 0.79 [0.73–0.85] | 0.61 | k+5; OR consistent (was 0.77) |
| C1 OS M2 | 32* | 0.86 [0.77–0.96] | 0.58 | Partial mediation preserved (was 0.83) |
| C1 NRM M1 | 12 | 0.88 [0.66–1.18] | 0.72 | k−3; direction consistent (was 0.86) |
| C1 NRM M2 | 9* | 0.90 [0.59–1.36] | 0.60 | CrI wider, still substantial mediation |
| C1 aGVHD M1 | 28 | 0.67 [0.59–0.78] | 0.68 | k+4; OR consistent (was 0.63) |

*\* Complete-case analysis for M2 (arms with missing steroid_pct dropped)*

### All models complete (19 fits)

| Model | k | OR [95% CrI] | τ | Change from pre-Block-9 |
|---|---:|---|---:|---|
| C1 CMV M1 | 22 | 1.26 [1.07–1.47] | 0.75 | k+4; attenuated (was 1.41) |
| C1 CMV M2 | 22 | 1.25 [1.01–1.54] | 0.76 | Consistent attenuation |
| C1 BSI M1 | 6 | 1.87 [1.33–2.62] | 0.96 | Attenuated (was 2.39), still harmful |
| C1 IFI M1 | 6 | 0.43 [0.29–0.63] | 1.64 | k−2; STRONGER protection (was 0.73) |
| C2 OS M1 | 12 | 0.84 [0.76–0.93] | 0.57 | k+2; attenuated (was 0.69) |
| C2 OS M2 | 12 | 0.88 [0.77–1.00] | 0.72 | CrI touches null |
| C2 NRM M1 | 3 | 0.63 [0.30–1.31] | 0.36 | k−2; wider CrI, same direction |
| C2 aGVHD M1 | 9 | 0.58 [0.44–0.77] | 0.55 | k+3; very consistent (was 0.59) |
| **C2 CMV M1** | **16** | **0.96 [0.80–1.16]** | **0.55** | **k+4; attenuated from 0.77 — CrI now crosses null** |
| C2 CMV M2 | 16 | 1.01 [0.82–1.24] | 0.65 | Null after steroid adjustment |
| C3 OS M1 | 6 | 1.11 [0.95–1.30] | 0.92 | **NEW** — null |
| C3 NRM M1 | 5 | 0.96 [0.74–1.24] | 1.22 | **NEW** — null |
| C3 aGVHD M1 | 7 | 1.00 [0.80–1.25] | 0.82 | **NEW** — null |
| C3 cGVHD M1 | 4 | 0.67 [0.39–1.14] | 0.41 | **NEW** — trend toward lower cGVHD |

### ⚠ Critical findings from refit

1. **C2 CMV direction reversal attenuated.** Pre-Block-9: OR 0.77 [0.60–0.99] (PTCy protective vs ATG, k=12). Post-Block-9: OR 0.96 [0.80–1.16] (null, k=16). An earlier run with a missing `D+365_1yr` fallback timepoint had incorrectly shown OR 1.04 by dropping 3 protective studies; this was fixed. Even with the correction, the 4 new Block-9 studies (Xu 2025 OR 1.05, Sayin 2024 OR 1.10, Zu 2022 OR 1.17, Kerbauy 2025 OR 1.29) genuinely attenuate the signal. The CrI now crosses null, weakening the direction reversal narrative.

2. **C2 OS attenuated.** Pre: OR 0.69 → Post: OR 0.84. Still significantly protective, but the magnitude is smaller.

3. **C1 IFI strengthened.** OR 0.73 → 0.43. Stronger protection, but τ = 1.64 indicates extreme heterogeneity. k dropped from 8 to 6.

4. **C1 BSI attenuated.** OR 2.39 → 1.87. Still harmful, but less extreme.

5. **C3 models all null.** All four C3 outcomes (OS, NRM, aGVHD, cGVHD) have CrIs crossing 1. Within-PTCy dose/schedule variants show no detectable differences. cGVHD (OR 0.67) has a trend but k=4 is too sparse.

6. **C1 OS, aGVHD, NRM — stable.** All within ±0.05 of pre-Block-9 values. These are the most robust findings.

### Key methodological notes

1. **Event count requirement**: The refit requires actual `event_count` from the outcomes table (no back-calculation from `cumulative_incidence_pct`). This matches the pre-Block-9 methodology and keeps k values in the expected range.

2. **tp_early covariate**: All models include `tp_early` (0 = preferred timepoint, 1 = fallback) matching the original model specification.

3. **M2 complete-case**: The pre-Block-9 M2 models used `brms::mi()` for missing steroid data imputation. Due to a brms API change (v2.23+), the refit uses complete-case analysis (dropping arms with missing steroid %). This is more conservative but avoids multivariate model complexity.

4. **Fallback timepoints**: Same Strategy C hierarchy as pre-Block-9 (e.g., OS: D+365 > D+730 > EoF).

---

## Pipeline (what ran)

```
1. export_to_csv.R  — re-exported CSVs from post-Block-9 workbook (251 studies)
                       Updated XLSX path to PTCy_MA_extraction_template_v1.2_post_block9.xlsx
                       Validation: all comparison eligibility checks pass

2. refit_block9.R   — refitting all Bayesian models on 251-study corpus
                       Fixed: build_analytic now requires event_count (no back-calc)
                       Fixed: tp_early covariate included in all M1/M2 formulas
                       Fixed: M2 uses complete-case instead of mi() (brms v2.23 change)
                       Output: 03_models/post_block9/*.rds

3. post_refit_process.R — (run after refit completes)
                           Extracts posterior draws, maps to website naming convention
                           Generates frequentist sanity checks
                           Compares pre vs post Block-9 results

4. Website (05_website/) — updated for dual model loading
                            _common.R: checks post_block9/ first, falls back to pre
                            All .qmd pages: dynamic OR computation from posteriors
                            index.qmd: database counts rendered dynamically
```

---

## Files modified in this update

| File | Change |
|---|---|
| `export_to_csv.R` | Updated XLSX path to post-Block-9 workbook |
| `refit_block9.R` | Fixed build_analytic (event_count only), added tp_early, fixed M2 complete-case |
| `post_refit_process.R` | **NEW** — post-processing script for posterior extraction |
| `05_website/_common.R` | Dual model directory support (post_block9 → pre fallback) |
| `05_website/index.qmd` | Dynamic OR/k/N computation; updated date and corpus size |
| `05_website/methods.qmd` | Updated study counts, added C3 description |
| `05_website/results-c1.qmd` | Updated model file paths for dual-directory loading |
| `05_website/results-c2.qmd` | Updated model file paths, graceful M2 column handling |
| `05_website/diagnostics.qmd` | Updated model file paths with fallback resolution |
| `05_website/discussion.qmd` | Updated limitation #5 for 251-study corpus |
| `05_website/rob.qmd` | Updated ROB row count (241) |

---

## What to do next

### After models finish (~30-60 min from start):
```r
source("post_refit_process.R")   # extract posteriors, generate comparison table
```

### Rebuild website:
```bash
cd 05_website && quarto render
```

### Review results:
1. Check `03_models/post_block9/Table2_post_block9.csv` for all OR estimates
2. Check `03_models/post_block9/pre_vs_post_comparison.csv` for CrI overlaps
3. Any non-overlapping CrIs need Discussion explanation

### Pending decisions:
1. **BMT director spot-check** — not yet started
2. **C3 analysis interpretation** — k=68 arms now adequately powered; new models fitting
3. **Publication bias** — RoBMA not yet attempted
4. **GRADE reassessment** — may need updates based on shifted k values

---

## Key files

| Category | File |
|---|---|
| **Active workbook** | `PTCy_MA_extraction_template_v1.2_post_block9.xlsx` |
| **Frozen baseline** | `PTCy_MA_extraction_template_v1.2.xlsx` |
| **Schema** | `PTCy_MA_database_schema_v1.2.md` |
| **Refit script** | `refit_block9.R` |
| **Post-processing** | `post_refit_process.R` |
| **CSV export** | `export_to_csv.R` |
| **Post-Block-9 models** | `03_models/post_block9/*.rds` |
| **Pre-Block-9 models** | `03_models/*.rds` |
| **Website source** | `05_website/*.qmd` |
| **Exclusion log** | `PTCy_MA_extraction_template_v1.2_excluded_papers.json` |
