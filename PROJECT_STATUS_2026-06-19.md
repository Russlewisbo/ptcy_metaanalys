# Project Status — 2026-06-19

## Session Summary

This session focused on supplementary materials preparation for Lancet Haematology
submission, post-Block-9 GRADE reassessment, and a systematic sweep of the Quarto
website for stale pre-Block-9 values.

---

## Completed This Session

### 1. GRADE Reassessment (Post-Block-9)
- **File:** `04_writing/GRADE_certainty_assessment_combined_post_block9.md`
- No certainty ratings changed level, but evidence profiles shifted:
  - C1 BSI lost large-magnitude upgrade (OR 2.39→1.87, below ≥2.0); gained I² downgrade (0%→71%)
  - C1 IFI gained large-magnitude upgrade (OR 0.73→0.43, meets ≤0.50); τ worsened (1.05→1.64)
  - C1 NRM M2 mediation now indeterminate (M2 OR 1.02→0.90, wide CrI)
  - C2 CMV dissolved to null (0.77→0.92); direction-reversal narrative weakened
  - C2 NRM dropped to not assessable (k=5→2)
  - C2 OS attenuated (0.69→0.81) but M2 mediation essentially vanished

### 2. Supplementary Materials Outline
- **File:** `04_writing/Supplementary_materials_outline.md`
- 14 appendix sections (S1–S14) mapped to Lancet requirements
- Priority order for drafting established

### 3. PRISMA 2020 Flow Diagram
- **File:** `04_writing/PRISMA_2020_flow_data.md`
- Full upstream cascade populated:
  - 4,145 (EMBASE 2,603 + PubMed 1,061 + SCOPUS 481)
  - → −1,220 duplicates → 2,925 screened
  - → −2,408 title/abstract excluded → 517 sought
  - → −52 not retrieved or not in English → 465 full-text
  - → −214 excluded → 251 in review → 117 in meta-analysis

### 4. Appendix S3: Excluded Studies Table
- **Files:** `04_writing/Appendix_S3_excluded_studies.md`, `04_writing/Table_S3_excluded_studies.csv`
- All 214 excluded studies labeled (77 recovered via alphabetical matching against Paperpile corpus)
- Confidence flags: 137 original, 59 probable, 8 matched, 10 manual_resolved
- **Action needed:** Verify the 69 probable/manual labels against source PDFs before submission

### 5. Appendix S4: Study Characteristics
- **Files:** `04_writing/Appendix_S4_study_characteristics.md`, `04_writing/Table_S4a_study_characteristics.csv`, `04_writing/Table_S4b_arm_characteristics.csv`
- 225 comparative studies, 520 arms, 177,758 patients
- Cross-check found and corrected errors in initial draft:
  - PTCy haplo was 47% (not 67%), MUD 24% (not 15%), BM 11% (not 29%)
  - Comparator MSD was 22% (not 35%)

### 6. Website Stale Value Sweep
Hardcoded pre-Block-9 numbers fixed across 4 files:

| File | Fix |
|------|-----|
| `discussion.qmd` | 220→251 studies, 457→525 arms, 3,050→3,604 outcomes, 10→14 RCTs (3 locations) |
| `grade.qmd` | 220→251, 10→14 RCTs, 457→525 arms |
| `methods.qmd` | 220→251, 457→525, 10→14 RCTs, 190→214 excluded |
| `diagnostics.qmd` | NRM C2 k=5→k=2; updated k≥15 examples |
| `sensitivity.qmd` | CMV primary k=18→k=22; IFI LOO caption updated; C2 expanded arm caption updated |

### 7. IFI Leave-One-Out Analysis
- **File:** `03_models/post_block9/loo_tbl.rds`
- Frequentist REML (metafor) — pending Bayesian refit when brms is available
- Key finding shift: Haebe S 2023 replaced Yanada M 2026 as dominant heterogeneity driver
  - Pre-Block-9: Yanada exclusion collapsed τ 1.05→0.38
  - Post-Block-9: Haebe exclusion drops τ 1.11→0.82; Yanada has minimal influence

### 8. CMV Sensitivity Investigation
- Haplo-only (k=12) and post-2020 (k=17) subsets identified but NOT re-fitted
- Pre-Block-9 posteriors still used as fallback on the website
- Data ready in `03_models/post_block9/data_c1_cmv.csv`

### 9. AGENTS.md Updated
- Comprehensive project memory for future sessions

---

## Not Completed / Blocked

### Blocked by missing R packages
- **Website re-render failed:** `tidyverse` not installed in current environment.
  All .qmd pages source `_common.R` which requires tidyverse. The edits to
  `diagnostics.qmd`, `sensitivity.qmd`, `discussion.qmd`, `grade.qmd`, and
  `methods.qmd` have NOT been verified by rendering.
- **Bayesian sensitivity refits:** `brms` not installed. The following models
  need Bayesian refitting:
  - C1 CMV haplo-only (k=12)
  - C1 CMV post-2020 (k=17)
  - IFI LOO (currently frequentist approximation)

### Remaining supplementary sections not yet drafted
- S1: Search strategy (needs extraction from PROSPERO protocol)
- S5: Risk of bias traffic-light figures
- S6: Model specification (ready to draft from refit_block9.R)
- S7: MCMC diagnostics tables
- S9: Sensitivity analyses compilation
- S10: Publication bias (RoBMA interpretation)
- S12: Cohort overlap map
- S13: PROSPERO protocol
- S14: PRISMA 2020 checklist

---

## How to Resume

### Immediate next steps
```bash
# 1. Install missing packages
Rscript -e 'install.packages(c("tidyverse", "brms", "kableExtra"))'

# 2. Re-render website to verify all edits
cd 05_website && quarto render

# 3. Re-fit Bayesian sensitivity models (requires brms + Stan)
# Script to be prepared — needs CMV haplo/post-2020 and IFI LOO
```

### Key files modified this session
```
04_writing/
  GRADE_certainty_assessment_combined_post_block9.md  (NEW)
  Supplementary_materials_outline.md                   (NEW)
  PRISMA_2020_flow_data.md                             (NEW)
  Appendix_S3_excluded_studies.md                      (NEW)
  Table_S3_excluded_studies.csv                        (NEW)
  Appendix_S4_study_characteristics.md                 (NEW)
  Table_S4a_study_characteristics.csv                  (NEW)
  Table_S4b_arm_characteristics.csv                    (NEW)

05_website/
  discussion.qmd    (EDITED — corpus counts)
  grade.qmd         (EDITED — corpus counts)
  methods.qmd       (EDITED — corpus counts)
  diagnostics.qmd   (EDITED — k examples)
  sensitivity.qmd   (EDITED — captions)

03_models/post_block9/
  loo_tbl.rds       (NEW — frequentist IFI LOO)

AGENTS.md           (UPDATED)
```

---

## Environment Notes
- R 4.6.0, no tidyverse/brms/kableExtra installed
- metafor 5.0.1 installed this session
- Quarto available at: `/home/ussellr/positron-ide-archlinux-installer/src/usr/share/positron/resources/app/quarto/bin/quarto`
- `freeze: auto` means only edited .qmd pages need re-execution on next render
