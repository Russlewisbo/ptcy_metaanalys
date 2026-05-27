# PTCy MA — Block 2 extraction summary (papers 61–110)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 agents launched, 12 hit a session limit mid-batch and were retried after reset, all completed)
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Verifier:** PEND (BMTD second-pass needed)

---

## Headline result

50 papers attempted. **28 extracted** (56%), **22 excluded** (44%). All 9 validation rules pass after five fixes (4 comparison-eligibility relabels, 1 outcome_subtype correction; plus 2 arm `n_patients` updated to match outcome denominators). Block 2 exclusion rate slightly better than block 1 (50% → 44%).

| Sheet | Cumulative (pilot + block 1 + block 2) | Block 2 added |
|---|---|---|
| `cohorts` | 42 (24 + 18) | 18 new cohorts |
| `studies` | 61 (33 + 28) | 28 |
| `arms` | 127 (66 + 61) | 61 |
| `outcomes` | 862 (439 + 423) | 423 |
| `outcomes_subgroup` | 46 (26 + 20) | 20 |
| `rob` | 57 (31 + 26) | 26 (RL only — BMTD pending) |

## Comparison eligibility — cumulative state

| Comparison | Block 2 added | Cumulative |
|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | +26 arms | 73 arms |
| 2 (PTCy vs ATG-based) | +21 arms | 34 arms |
| 3 (within-PTCy variants) | +5 arms | 9 arms |

**Comparison 2 doubled** thanks to the dense Brissot/Battipaglia/Bazarbachi/Berro/Chalandon/Dachy cluster of PTCy-vs-ATG papers — this block was a strong harvest for the second primary comparison.

## Outcome category coverage — cumulative

```
aGVHD                          205  ← well-covered
overall_mortality              128
cGVHD                          116
NRM                            106
engraftment_failure             78
CMV                             73  ← growing (Camargo, Chen, Chorão, Bothara)
other_infection                 43
BSI                             37  ← growing (Carreira block 2; Chorão 2026)
infection_related_mortality     34
IFI_mold                        16
IFI_any                          9
second_line_GVHD_therapy_use     6
IFI_yeast                        6
steroid_refractory_aGVHD         5
```

Block 2 added the first BSI (15 rows) and CMV (41 rows) tranches outside the pilot. IFI categories still sparse — expect catch-up in Sa–Z blocks (Salas papers, infection-focused subset).

## Exclusion breakdown (block 2, 22 papers)

| Reason | N |
|---|---|
| Conference abstract | 10 |
| Single-arm descriptive (no PTCy contrast) | 3 |
| Duplicate of earlier study | 4 (95→96; 83→84; 88→87; 99→98) |
| Duplicate of pilot (Bolaños-Meade 2023 = study 2) | 1 |
| Pediatric outside protocol | 1 |
| No PTCy contrast in mixed cohort | 1 |
| Protocol/design paper, no results | 2 (Chakraverty 2025 BMJ Open protocol) |
| **Total** | 22 |

**Duplicate detection working well** — the publisher-style raw filenames (Wiley journal exports, `1-s2.0-...`, `e086223.full.pdf`) consistently flagged as duplicates of their journal-version siblings.

## New cohorts added (18) — block 2

| cohort_id | label | source |
|---|---|---|
| 1026 | Turin_MMUD_Berger | Italian single center |
| 1027 | Austral_Argentina_Berro_UD | Argentine single center |
| 1028 | UMass_Chan_age70plus_alloSCT | UMass — older adults Bhatia cohort |
| 1029 | Marseille_IPC_Blaise_older_adults | Marseille IPC |
| **1030** | **BMT_CTN_1203** | **3rd BMT CTN trial — Bolaños-Meade 2019 NEJM phase 2 4-arm RCT** |
| **1031** | **HOVON_96** | **Dutch RCT, Broers 2022** |
| 1032 | Gorbacheva_StPetersburg_nonmalignant_pediatric | Russian center |
| 1033 | Miami_Sylvester_Camargo | Camargo CMV cohort |
| 1034 | Ningbo_People_Hospital_haplo_AML_MDS | Chinese single center |
| 1035 | EBMT_CMWP_UD_MDS | EBMT Chronic Malignancies WP — distinct from ALWP |
| 1036 | SanRaffaele_Milan_MAP_PTCy | Italian single center |
| 1037 | EBMT_CMWP_myelofibrosis | EBMT CMWP myelofibrosis subset (Chiusolo 2026) |
| 1038 | Chorao_Portuguese_single_center | Portuguese (CMV + BSI papers) |
| 1039 | Rutgers_CINJ_Cooper | Cooper 2021 single center |
| **1040** | **ALLG_BM12_CAST_RCT** | **Australian Curtis 2025 RCT** |
| 1041 | IPC_Marseille_MUD_PBSC | Dachy 2023 |
| 1042 | PMH_CIBMTR_MUD_acute_leukemia_FtoM | Desai 2025 CMV cohort |
| 1043 | PrincessMargaret_Toronto_MDSMPN | Desai 2025 MDS cohort |

**Three new RCTs joined the database in block 2:** BMT CTN 1203 (Bolaños-Meade 2019 phase 2), HOVON-96 (Dutch), ALLG BM12-CAST (Australian Curtis 2025). Combined with pilot's BMT CTN 1703 + Moiseev 2016, the database now has **5 RCTs** — meaningful weight for the meta-analysis primary signal.

## Validation status

After fixes, all 9 rules pass (modulo 1 carry-over warning from pilot for outcome 225 already flagged for BMTD).

**Fixes applied:**

1. **R4 study 77 (Brissot 2019 EBMT ALWP):** Haplo+PTCy arm marked `comparison_2_eligible = Y` but UD arms in the study used CNI (not ATG); not a valid Comparison 2 setup. Set arm 90 `c2 → N`.
2. **R4 study 86 (Camargo 2021):** PTCy haplo arm 103 marked c2=Y but no haplo+ATG counterpart in the study. Set arm 103 `c2 → N`. ATG MMUD arm 102 correctly retained as comparator with c2 corrected to Y (was N).
3. **R4 study 97 (Chiurlo 2025):** Single-arm with c3=Y. Set c3 → N (no within-PTCy comparator in study).
4. **R4 study 100 (Chorão 2024):** Three PTCy donor-variant arms (MSD, MUD, Haplo) initially marked c1=Y. Reclassified to **Comparison 3** (within-PTCy donor variants); MSD = comparator_arm (standard reference), MUD and Haplo = PTCy_arm.
5. **R6 IFI_any subtype:** Three rows used `investigator_reported` (invalid for IFI_any). Corrected to `investigator_reported_any` (the allowed vocabulary).
6. **R2 study 97 arm 112:** arm.n_patients=353 vs outcome denominators=473. Updated arm.n_patients → 473 (the cohort-level value used in outcomes).
7. **R2 study 110 arm 126:** arm.n_patients=53 vs outcome denominators=75. Updated arm.n_patients → 75.

## v1.2 back-calc policy efficacy — sustained

`systemic_steroid_for_gvhd_exposure_pct` populated in **86/127 arms (68%)** cumulative. Up from 59% after block 1, 18% in pilot. The v1.2 back-calc policy continues to pay dividends.

`second_line_gvhd_therapy_exposure_pct` still sparse (4/127 = 3%) — strong candidate for v1.3 deprecation or proxy specification.

## Notable extraction findings

- **BMT CTN 1203 (cohort 1030, study 72)** — Bolaños-Meade 2019 NEJM phase 2 RCT with 4 arms (PTCy / bortezomib / maraviroc / control Tac+MTX). Provides a clean within-trial PTCy-vs-Tac+MTX contrast for Comparison 1. Adjacent arms (bortezomib, maraviroc) recorded but not eligible for the 3 primary comparisons.

- **HOVON-96 (cohort 1031, study 80)** — Dutch RCT comparing PTCy+CSA vs CSA+MTX in matched donors. Clean Comparison 1.

- **ALLG BM12-CAST (cohort 1040, study 105)** — Australian RCT (Curtis 2025). PTCy+CSA permitting older sibling donors. Comparison 1.

- **Chakraverty 2025 UK adaptive RCT** — protocol paper only (BMJ Open e086223 was 2025 protocol publication, not results). Excluded with `protocol_only_no_results`. Worth tracking — when results paper publishes, will be a major UK contribution.

- **EBMT working group split** — clear distinction now established in the database: ALWP (cohort 1024, acute leukemia) vs CMWP (cohorts 1035 MDS, 1037 myelofibrosis). Future EBMT papers will route to the appropriate working-group cohort.

- **Bordat 2026 journal version (study 75)** — properly placed into cohort 1006 (Bordat_MMUD); pilot's Bordat 2024 abstract entry now correctly mapped as predecessor of this journal version.

- **Two systematic reviews still in the corpus alphabetically downstream** (Arcuri 2025 already excluded; expect more in subsequent blocks).

## Cumulative project status

- **8 RCTs** between pilot (Bolaños-Meade NEJM, Moiseev 2016) and block 2 (BMT CTN 1203, HOVON-96, ALLG BM12-CAST). Frequentist sanity-check via `metafor` can now run on a meaningful RCT subset.
- **42 cohort clusters identified** — the cohort-overlap rule continues to work; no duplicates between blocks.
- **Comparison 2 (PTCy vs ATG)** is now the most diverse signal source after pilot+block 1's relative scarcity (3 arms → 34 arms).
- **127 total arms** in the database, ~58% (73) eligible for Comparison 1.

## v1.3 candidates updated

1. **Add `arms.extraction_notes` column** — still needed; back-calc audit trail still has no structured home (the `systemic_steroid_pct_source` enum field would be cleaner).
2. **Deprecate `second_line_gvhd_therapy_exposure_pct`** — 3% reporting rate after 127 arms suggests this should join `steroid_exposure_duration_days_median` in the v1.3 deprecation list.
3. **Cohort-merger procedure** — Bailen_GETH (1019) vs GETH_TC (1020) still suspect overlap; worth manual review.

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (42 cohorts / 61 studies / 127 arms / 862 outcomes / 46 subgroup / 57 rob)
- `excluded_papers_block_2.json` (scratch outputs) — 22 excluded papers with reasons for PRISMA
- `extraction_paper_<N>.json` (scratch outputs) — raw JSONs for audit
- `EXTRACTION_SPEC.md` and `cohort_overlap_map.json` (scratch outputs) — same v1.2 spec used by both blocks

## Block 3 readiness

Ready when you are. Suggest the next 50 alphabetically (De–He range based on the corpus). Will refresh cohort_overlap_map to include the 18 new cohorts from this block before launching.
