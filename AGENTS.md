# PTCy Meta-Analysis — Project Memory

**Last updated:** 2026-06-19
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)

---

## Project Overview

Bayesian meta-analysis of post-transplant cyclophosphamide (PTCy) as GVHD prophylaxis
after allogeneic HSCT. Three-comparison framework examining infection, GVHD, and survival
outcomes with a GVHD-mediation model (steroid exposure as mediator).

---

## Current Phase

**Phase 4 (verification):** Self-audit done; BMT director spot-check NOT started.
**Phase 5 (analysis):** Post-Block-9 Bayesian refit COMPLETE (19 models fitted).
**Website:** Quarto site renders cleanly (11 pages, last built 2026-06-19).
**Writing:** Draft sections exist in `04_writing/` but are not finalized.

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

**Key mediation finding:** NRM benefit is completely steroid-mediated (M2 attenuates to null);
OS benefit only partially mediated; CMV harm is steroid-independent.

**Key cross-comparison finding:** CMV direction reverses — harmful vs CNI+MTX (C1) but
null/protective vs ATG (C2), driven by comparator immunosuppressive depth.

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
│   │   ├── robma_*.rds      # RoBMA publication bias models
│   │   ├── freq_results.csv # Frequentist sanity checks
│   │   └── Table2_post_block9.csv, pre_vs_post_comparison.csv
│   ├── MANIFEST.md          # Detailed model documentation (pre-Block-9)
│   └── *.rds                # Pre-Block-9 models (frozen baseline)
├── 04_writing/              # Draft manuscript sections
│   ├── Results_OS_NRM.md, Results_infection_outcomes.md, Results_C2.md
│   ├── Discussion_mechanistic_asymmetry.md
│   ├── GRADE_certainty_assessment*.md
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
- **Priors:** Weakly informative — N(0, 0.82) on treatment effect, N(0, 0.50) on τ
- **MCMC:** 4 chains × 3,000 post-warmup draws (12,000 total)
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
2. **GRADE reassessment** — may need updates given post-Block-9 shifts
3. **Publication bias (RoBMA)** — models exist in post_block9/ but not fully interpreted
4. **Schema v1.3 lock** — add extraction_notes, steroid_pct_source; deprecate second_line exposure
5. **Cohort-merger resolution** — GETH, PMH Desai, MDACC Mehta, JSTCT clusters
6. **Open anomalies:** Moiseev 2016 design classification; Alousi outcome 225 denominator
7. **Manuscript finalization** — draft sections in 04_writing/ need integration
8. **Website polish** — renders cleanly but may need content updates for final results

---

## Rendering the Website

```bash
# Quarto is bundled with Positron:
/home/ussellr/positron-ide-archlinux-installer/src/usr/share/positron/resources/app/quarto/bin/quarto render
# Run from 05_website/ directory. Output goes to ../docs/
```

`freeze: auto` is enabled — unchanged .qmd pages use cached results.
