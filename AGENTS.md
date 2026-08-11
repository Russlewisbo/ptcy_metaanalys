# PTCy Meta-Analysis — Project Memory

**Last updated:** 2026-08-11 (evening)
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)

---

## Project Overview

Bayesian meta-analysis of post-transplant cyclophosphamide (PTCy) as GVHD prophylaxis
after allogeneic HSCT. Three-comparison framework examining infection, GVHD, and survival
outcomes with a GVHD-mediation model (steroid exposure as mediator).

---

## Current Phase

**Phase 4 (verification):** Self-audit done; BMT director spot-check NOT started.
**Phase 5 (analysis):** **Set B (cohort-deduplicated) adopted 2026-08-11** and propagated.
An audit found same-cohort double counting in 9 of 29 analytic datasets; models were
refitted with one publication per cohort per outcome. Two previously reported claims did
not survive (see Key Model Results).
**Phase 6 (writing):** Manuscript text, Table 2, GRADE, and all figures updated to Set B.
`Manuscript_LancetHaem_draft.qmd` renders cleanly to HTML (verified 2026-08-11).
**Website:** `05_website/` NOT yet updated for Set B - still shows pre-deduplication numbers.
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

## Key Model Results (Set B — cohort-deduplicated, 2026-08-11)

**Supersedes the post-Block-9 numbers.** An audit found that permitting outcome-specific
(`partial`) primary publications let up to 5 publications from one registry cohort enter
the same model as independent studies. Set B = one publication per cohort per outcome,
resolved via `03_models/cohort_overrides.csv`. Refits live in `03_models/set_b/`
(partial overlay; unaffected models remain in `post_block9/`).

### C1: PTCy vs CNI+MTX

| Outcome  | Model | k  | OR [95% CrI]      | τ    |
|----------|-------|----|--------------------|----- |
| OS       | M1    | 35 | 0.84 [0.76–0.92]  | 0.66 |
| OS       | M2    | 28 | 1.04 [0.89–1.22]  | 0.60 |  ← attenuates to null
| NRM      | M1    | 12 | 0.88 [0.66–1.18]  | 0.72 |
| NRM      | M2    | 9  | 0.90 [0.59–1.36]  | 0.60 |
| aGVHD    | M1    | 28 | 0.67 [0.59–0.78]  | 0.68 |
| CMV      | M1    | 22 | 1.26 [1.07–1.47]  | 0.75 |
| CMV      | M2    | 22 | 1.25 [1.01–1.54]  | 0.76 |
| BSI      | M1    | 6  | 1.87 [1.33–2.62]  | 0.96 |
| IFI      | M1    | 6  | 0.43 [0.29–0.63]  | 1.64 |
| RRM      | M1    | 34 | 0.87 [0.77–0.97]  | 0.47 |
| RRM      | M2    | 27 | 0.85 [0.73–0.99]  | 0.55 |
| IRM      | M1    | 13 | 1.19 [1.00–1.43]  | 0.82 |  ← no longer significant
| cGVHD ms | M1    | 19 | 0.47 [0.38–0.57]  | 0.77 |  ← was 0.33 (2 ineligible studies)

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
| OS       | M1    | 9  | 0.83 [0.75–0.92]  | 0.50 |
| OS       | M2    | 8  | 0.81 [0.70–0.93]  | 0.67 |
| NRM      | M1    | —  | (k=2, below min)   | —    |
| aGVHD    | M1    | 8  | 0.63 [0.47–0.83]  | 0.53 |
| CMV      | M1    | 12 | 0.97 [0.77–1.23]  | 0.63 |
| CMV      | M2    | 12 | 1.00 [0.79–1.26]  | 0.72 |

### C3: Within-PTCy Variants (all null)

OS 1.11, NRM 0.96, aGVHD 1.00, cGVHD 0.67 — all CrIs cross 1.

**Key mediation finding (REVISED):** the C1 OS benefit is NOT separable from GVHD
suppression — M2 attenuates to 1.04 [0.89–1.22]. The earlier "partial mediation with
residual direct benefit" claim was an artifact of duplicated patients. C2 OS remains
steroid-independent (0.83→0.81). CMV harm is steroid-independent. NRM M2 indeterminate.

**Key cross-comparison finding:** CMV harmful vs CNI+MTX (C1 OR 1.26) but null vs ATG
(C2 OR 0.97), consistent with T-cell depletion depth gradient. Direction-reversal
narrative weakened (C2 was 0.77, now null at 0.97).

---

## GRADE Certainty (Set B, revised 2026-08-11)

| Outcome | C1 | C2 |
|---------|----|----|
| OS      | LOW (retained; M2 attenuation = mediation, not bias) | LOW |
| NRM     | VERY LOW (imprecision only; RoB downgrade withdrawn) | Not assessable (k=2) |
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
| S5 | Risk of bias figures | **DONE** (S5a-c); S5d/S5e pending |
| S6 | Model specification | Ready to draft |
| S7 | MCMC diagnostics | Partially available |
| S8 | Forest plots | **DONE** - S8a-S8j as png/pdf/svg in `04_writing/figures/` |
| S9 | Sensitivity analyses | S9a-d pending; **S9e DRAFTED** (`Appendix_S9e_frequentist_concordance.md`) |
| S10 | Publication bias (RoBMA) | Models exist, interpretation pending |
| S11 | GRADE evidence profiles | **DONE** |
| S12 | Cohort overlap map | **DONE** - `Appendix_S12_cohort_overlap.md` + Tables S12a/b/c |
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
│   ├── set_b/               # ADOPTED analysis: cohort-deduplicated refits (partial overlay)
│   │   ├── Table2_setB.csv  # current Table 2
│   │   └── m1_*/m2_*/data_* # only outcomes affected by deduplication
│   ├── dedup_sensitivity/   # Set A/B/C comparison fits for C1 OS
│   └── cohort_overrides.csv # cohort x outcome -> primary study registry
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

# Set B models (ADOPTED). set_b/ is a PARTIAL overlay - prefer it, fall back to post_block9.
resolve <- function(f) if (file.exists(file.path("03_models/set_b", f)))
  file.path("03_models/set_b", f) else file.path("03_models/post_block9", f)
m1_c1_os <- readRDS(resolve("m1_c1_os.rds"))   # k=35 Set B
or_draws <- exp(posterior::as_draws_df(m1_c1_os)$b_ptcy_binary)
# Table 2: 03_models/set_b/Table2_setB.csv  (NOT Table2_post_block9.csv)

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

- `primary_for_cohort = partial` allowed for outcome-specific publications **(SUPERSEDED 2026-08-11:** the flag is still used, but the dataset builder is now outcome-aware - a cohort may contribute only one publication per outcome, resolved via `03_models/cohort_overrides.csv`. See `build_analytic_outcome_aware.R`.**)**
- Conference abstracts excluded entirely
- Subgroup outcomes extracted opportunistically (no author contact)
- Cohort labels added as papers encountered
- Extract BOTH aGVHD II–IV AND III–IV at D+100
- Back-calculate steroid % from aGVHD II–IV when not directly reported
- Alphabetical 50-paper extraction blocks
- `steroid_exposure_duration_days_median` dropped (0% reporting)

---

## Pending Work

### Set B follow-ups (2026-08-11)

1. Cohort 1024 (EBMT_ALWP) lumps 5 heterogeneous registry extractions with reused
   cord-blood control arms - split into donor-stratum sub-cohorts to enable Set C.
2. Cohort 1023 RRM duplicate (studies 50 vs 51, identical n) unresolved; the
   outcome-aware builder declines to choose.
3. Re-examine the C1 NRM -1 risk-of-bias downgrade (mediator/confounder conflation).
4. 5 dangling cohort_ids, 2 missing primary_for_cohort, 10 cohorts with no `Y`,
   4 cohorts with two `Y` - see Appendix S12.
5. `freq_results.csv` is pre-deduplication; regenerate before drafting Table S9e.
6. RoBMA / publication-bias models are pre-deduplication.

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
