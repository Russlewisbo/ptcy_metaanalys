# PTCy Meta-Analysis — Project Memory

**Last updated:** 2026-06-19 (evening)
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)

---

## Project Overview

Bayesian meta-analysis of post-transplant cyclophosphamide (PTCy) as GVHD prophylaxis
after allogeneic HSCT. Three-comparison framework examining infection, GVHD, and survival
outcomes with a GVHD-mediation model (steroid exposure as mediator).

---

## Current Phase

**Phase 4 (verification):** Self-audit done; BMT director spot-check NOT started.
**Phase 5 (analysis):** Post-Block-9 Bayesian refit COMPLETE (19 primary models + 2 CMV sensitivity + IFI LOO).
**Phase 6 (writing):** Supplementary materials drafting in progress.
**Website:** Quarto site renders cleanly (11 pages, last built 2026-06-19).
**Writing:** Draft sections + supplementary appendices in `04_writing/`.

---

## Database (Post-Block-9)

Active workbook: `PTCy_MA_extraction_template_v1.2_post_block9.xlsx`
Frozen baseline: `PTCy_MA_extraction_template_v1.2.xlsx` (pre-Block-9)

| Sheet              | Rows   |
|--------------------|--------|
| cohorts            | 181    |
| studies            | 251    |
| arms               | 525    |
| outcomes           | 3,604  |
| outcomes_subgroup  | 126    |
| rob                | 241    |
| Excluded (PRISMA)  | 214    |
| **RCTs**           | **14** |

Schema: `PTCy_MA_database_schema_v1.2.md` (v1.3 amendments deferred)

### PRISMA Flow (upstream)
4,145 (EMBASE 2,603 + PubMed 1,061 + SCOPUS 481)
→ −1,220 duplicates → 2,925 screened
→ −2,408 title/abstract excluded → 517 sought
→ −52 not retrieved or not in English → 465 full-text
→ −214 excluded → 251 in review → 117 in meta-analysis

---

## Comparisons

| Comparison | Definition                                    | Arms |
|------------|-----------------------------------------------|------|
| C1         | PTCy ± CNI/MMF vs CNI + MTX/MMF (no ATG/TCD) | 313  |
| C2         | PTCy vs ATG-based                             | 109  |
| C3         | Within-PTCy regimen variants                  | 68   |

---

## Key Model Results (Post-Block-9)

### C1: PTCy vs CNI+MTX

| Outcome  | Model | k  | OR [95% CrI]      | τ    |
|----------|-------|----|--------------------|----- |
| OS       | M1    | 40 | 0.79 [0.73–0.85]  | 0.61 |
| OS       | M2    | 32 | 0.86 [0.77–0.96]  | 0.58 |
| NRM      | M1    | 12 | 0.88 [0.66–1.18]  | 0.72 |
| NRM      | M2    | 9  | 0.90 [0.59–1.36]  | 0.60 |
| aGVHD    | M1    | 28 | 0.67 [0.59–0.78]  | 0.68 |
| CMV      | M1    | 22 | 1.26 [1.07–1.47]  | 0.75 |
| CMV      | M2    | 22 | 1.25 [1.01–1.54]  | 0.76 |
| BSI      | M1    | 6  | 1.87 [1.33–2.62]  | 0.96 |
| IFI      | M1    | 6  | 0.43 [0.29–0.63]  | 1.64 |

### C1 CMV Sensitivity Models (Post-Block-9, fitted 2026-06-19)

| Subset         | k  | OR [95% CrI]      | τ    | Pre-Block-9 OR |
|----------------|----|--------------------|------|----------------|
| Primary        | 22 | 1.26 [1.07–1.47]  | 0.75 | 1.41           |
| Post-2020      | 17 | 1.53 [1.28–1.85]  | 0.83 | 1.80           |
| Haplo ≥50%     | 12 | 1.38 [1.12–1.71]  | 0.69 | 1.70           |

All three subsets remain significantly > 1 (P(OR>1) ≥ 99.9%).
GRADE robustness upgrade for C1 CMV confirmed.

### IFI Leave-One-Out (Post-Block-9, frequentist REML)

Haebe S 2023 is now the dominant heterogeneity driver (τ: 1.11→0.82 on exclusion).
Yanada M 2026 no longer collapses τ (was τ 1.05→0.38 pre-Block-9).
File: `03_models/post_block9/loo_tbl.rds`

### C2: PTCy vs ATG

| Outcome  | Model | k  | OR [95% CrI]      | τ    |
|----------|-------|----|--------------------|----- |
| OS       | M1    | 10 | 0.81 [0.74–0.90]  | 0.51 |
| OS       | M2    | 10 | 0.82 [0.71–0.94]  | 0.70 |
| NRM      | M1    | —  | (k=2, below min)   | —    |
| aGVHD    | M1    | 9  | 0.58 [0.44–0.77]  | 0.55 |
| CMV      | M1    | 13 | 0.92 [0.73–1.15]  | 0.64 |
| CMV      | M2    | 13 | 0.98 [0.78–1.24]  | 0.74 |

### C3: Within-PTCy Variants (all null)

OS 1.11, NRM 0.96, aGVHD 1.00, cGVHD 0.67 — all CrIs cross 1.

**Key mediation finding:** NRM M2 mediation now indeterminate (M2 OR 0.90 [0.59–1.36]);
OS benefit only partially mediated; CMV harm is steroid-independent.

**Key cross-comparison finding:** CMV harmful vs CNI+MTX (C1 OR 1.26) but null vs ATG
(C2 OR 0.92), consistent with T-cell depletion depth gradient. Direction-reversal
narrative weakened post-Block-9 (C2 was 0.77, now null at 0.92).

---

## GRADE Certainty (Post-Block-9)

| Outcome | C1 | C2 |
|---------|----|----|
| OS      | LOW | LOW |
| NRM     | VERY LOW | Not assessable (k=2) |
| aGVHD   | LOW | LOW |
| CMV     | LOW (robustness upgrade confirmed) | VERY LOW |
| BSI     | VERY LOW (lost large-mag upgrade) | VERY LOW (informal) |
| IFI     | VERY LOW (gained large-mag upgrade) | — |

File: `04_writing/GRADE_certainty_assessment_combined_post_block9.md`

---

## Supplementary Materials Status

| Section | Content | Status |
|---------|---------|--------|
| S1 | Search strategy | Needs extraction from PROSPERO |
| S2 | PRISMA 2020 flow diagram | Numbers complete; needs editable format |
| S3 | Excluded studies (n=214) | **DONE** — all labels recovered |
| S4 | Study/arm characteristics | **DONE** — cross-checked |
| S5 | Risk of bias figures | Not started |
| S6 | Model specification | Ready to draft |
| S7 | MCMC diagnostics | Partially available |
| S8 | Forest plots | Available from website |
| S9 | Sensitivity analyses | Partially available |
| S10 | Publication bias (RoBMA) | Models exist, interpretation pending |
| S11 | GRADE evidence profiles | **DONE** |
| S12 | Cohort overlap map | Not started |
| S13 | PROSPERO protocol | Exists as docx |
| S14 | PRISMA 2020 checklist | Not started |

Files: `04_writing/Supplementary_materials_outline.md`, `04_writing/PRISMA_2020_flow_data.md`,
`04_writing/Appendix_S3_excluded_studies.md`, `04_writing/Table_S3_excluded_studies.csv`,
`04_writing/Appendix_S4_study_characteristics.md`, `04_writing/Table_S4a_study_characteristics.csv`,
`04_writing/Table_S4b_arm_characteristics.csv`

---

## Directory Structure

```
ptcy_metaanalys/
├── 02_extraction/           # Exported CSVs from workbook
│   ├── arms.csv, cohorts.csv, studies.csv, outcomes.csv, rob.csv, ...
│   ├── analytic/            # Analytic datasets built by refit_block9.R
│   ├── _backup_pre_block9/  # Pre-Block-9 CSV backup
│   └── _backup_post_block9/ # Post-Block-9 CSV backup
├── 03_models/               # Pre-Block-9 brms models + posteriors
│   ├── post_block9/         # Post-Block-9 refitted models (ACTIVE)
│   │   ├── m1_c1_*.rds      # M1 brms model objects
│   │   ├── m2_c1_*.rds      # M2 brms model objects
│   │   ├── post_c1_*.rds    # Posterior draw data frames
│   │   ├── data_c1_*.csv    # Analytic datasets used for each model
│   │   ├── m1_post2020.rds, m1_haplo.rds         # CMV sensitivity models
│   │   ├── post_m1_post2020.rds, post_m1_haplo.rds  # CMV sensitivity posteriors
│   │   ├── data_c1_cmv_post2020.csv, data_c1_cmv_haplo.csv  # CMV sensitivity data
│   │   ├── loo_tbl.rds      # IFI leave-one-out (frequentist REML)
│   │   ├── robma_*.rds      # RoBMA publication bias models
│   │   ├── freq_results.csv # Frequentist sanity checks
│   │   └── Table2_post_block9.csv, pre_vs_post_comparison.csv
│   ├── MANIFEST.md          # Detailed model documentation (pre-Block-9)
│   └── *.rds                # Pre-Block-9 models (frozen baseline)
├── 04_writing/              # Draft manuscript sections + supplementary appendices
│   ├── Results_OS_NRM.md, Results_infection_outcomes.md, Results_C2.md
│   ├── Discussion_mechanistic_asymmetry.md
│   ├── GRADE_certainty_assessment_combined_post_block9.md  # Current GRADE
│   ├── Supplementary_materials_outline.md
│   ├── PRISMA_2020_flow_data.md
│   ├── Appendix_S3_excluded_studies.md, Table_S3_excluded_studies.csv
│   ├── Appendix_S4_study_characteristics.md
│   ├── Table_S4a_study_characteristics.csv, Table_S4b_arm_characteristics.csv
│   └── What_this_study_adds.md
├── 05_website/              # Quarto website source
│   ├── _quarto.yml          # Output to ../docs/ for GitHub Pages
│   ├── _common.R            # Shared setup: dual model loading (post_block9 → pre)
│   ├── index.qmd, methods.qmd, results-c1/c2/c3.qmd, forest-plots.qmd
│   ├── sensitivity.qmd, diagnostics.qmd, grade.qmd, rob.qmd, discussion.qmd
│   └── styles.css
├── docs/                    # Rendered website (GitHub Pages target)
├── PTCY_files/              # Source PDFs / paper files
├── export_to_csv.R          # Workbook → CSV export script
├── refit_block9.R           # Post-Block-9 model refit script
├── post_refit_process.R     # Posterior extraction + comparison tables
├── FINAL_STATUS.md          # Status after blocks 1–8 complete (220 studies)
├── PROJECT_STATUS_2026-05-29.md  # Status after Block 9 refit (251 studies)
├── PROJECT_STATUS_2026-06-19.md  # Status after this session
├── STATUS.md                # Earlier interim status (blocks 1–6)
└── PTCy_MA_database_schema_v1.2.md  # Database schema spec
```

---

## How to Load Data

```r
library(tidyverse)

# CSVs (from export_to_csv.R)
studies  <- read_csv("02_extraction/studies.csv")
arms     <- read_csv("02_extraction/arms.csv")
outcomes <- read_csv("02_extraction/outcomes.csv")
cohorts  <- read_csv("02_extraction/cohorts.csv")
rob      <- read_csv("02_extraction/rob.csv")

# Post-Block-9 posteriors (example)
post_c1_os <- readRDS("03_models/post_block9/post_c1_os.rds")
or_draws   <- exp(post_c1_os$b_ptcy_binary)

# CMV sensitivity posteriors
post_cmv_post2020 <- readRDS("03_models/post_block9/post_m1_post2020.rds")
post_cmv_haplo    <- readRDS("03_models/post_block9/post_m1_haplo.rds")
```

Key columns in posteriors: `b_ptcy_binary` (log-OR for PTCy effect),
`sd_study_id__Intercept` (τ). For M2 models with mi() imputation,
PTCy column is `b_eventsn_ptcy_binary`.

---

## Model Specification

- **Framework:** Bayesian random-effects binomial-logistic regression via `brms`
- **M1 formula:** `events_n | trials(denom_n) ~ ptcy_binary + tp_early + (1|study_id)`
- **M2 formula:** Adds `steroid_pct_c` (centered arm-level steroid exposure %)
- **M3 formula:** Adds `agvhd_ci_pct_c` (centered aGVHD II–IV cumulative incidence %)
- **Priors:** Weakly informative — N(0, 2.5) on β, N(0, 1.5) on Intercept, Student-t(3, 0, 1) on τ
- **MCMC:** 4 chains × 4,000 iterations (1,000 warmup), 12,000 post-warmup draws
- **adapt_delta:** 0.95
- **Event counts required:** No back-calculation from cumulative incidence
- **tp_early covariate:** 1 = D+100 or D+180, 0 = EoF/1yr/2yr
- **M2 complete-case** in post-Block-9 refit (brms v2.23+ mi() API change)

---

## Locked Decisions

- `primary_for_cohort = partial` allowed for outcome-specific publications
- Conference abstracts excluded entirely
- Subgroup outcomes extracted opportunistically (no author contact)
- Cohort labels added as papers encountered
- Extract BOTH aGVHD II–IV AND III–IV at D+100
- Back-calculate steroid % from aGVHD II–IV when not directly reported
- Alphabetical 50-paper extraction blocks
- `steroid_exposure_duration_days_median` dropped (0% reporting)

---

## Pending Work

1. **BMT director second-pass verification** — not started
2. **Publication bias (RoBMA)** — models exist in post_block9/ but not fully interpreted
3. **Schema v1.3 lock** — add extraction_notes, steroid_pct_source; deprecate second_line exposure
4. **Cohort-merger resolution** — GETH, PMH Desai, MDACC Mehta, JSTCT clusters
5. **Open anomalies:** Moiseev 2016 design classification; Alousi outcome 225 denominator
6. **Manuscript finalization** — draft sections in 04_writing/ need integration
7. **Remaining supplementary sections:** S1, S5, S6, S7, S9, S10, S12, S13, S14
8. **S3 label verification:** 69 probable/manual labels need checking against source PDFs

---

## Website Stale-Value Sweep (2026-06-19)

All hardcoded pre-Block-9 numbers have been corrected across the website:
- discussion.qmd: corpus counts (220→251, 457→525, 10→14 RCTs)
- grade.qmd: corpus counts
- methods.qmd: corpus counts, exclusion count (190→214)
- diagnostics.qmd: example k values (NRM C2 k=5→k=2)
- sensitivity.qmd: CMV k labels (k=18→22), IFI LOO caption, C2 expanded arm caption

The site was last rendered cleanly on 2026-06-19 with all corrections applied.

---

## Rendering the Website

```bash
cd 05_website
/home/ussellr/positron-ide-archlinux-installer/src/usr/share/positron/resources/app/quarto/bin/quarto render
# Output goes to ../docs/
```

`freeze: auto` is enabled — unchanged .qmd pages use cached results.

**Required R packages:** tidyverse, brms, kableExtra, patchwork, metafor
