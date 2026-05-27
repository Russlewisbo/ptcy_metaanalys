# PTCy MA — Block 3 extraction summary (papers 111–160)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 launched, 1 retried for "prompt too long")
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Verifier:** PEND (BMTD second-pass needed)

---

## Headline result

50 papers attempted. **22 extracted** (44%), **28 excluded** (56%). All 9 validation rules pass after seven `comparison_X_eligible` relabels and one `arm_role` correction.

| Sheet | Cumulative (pilot + b1 + b2 + b3) | Block 3 added |
|---|---|---|
| `cohorts` | 57 (42 + 15) | 15 new clusters |
| `studies` | 83 (61 + 22) | 22 |
| `arms` | 171 (127 + 44) | 44 |
| `outcomes` | 1198 (862 + 336) | 336 |
| `outcomes_subgroup` | 51 (46 + 5) | 5 |
| `rob` | 78 (57 + 21) | 21 |

## Comparison eligibility — cumulative

| Comparison | Block 3 added | Cumulative | Δ vs block 2 end |
|---|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | +24 arms | **97 arms** | +33% |
| 2 (PTCy vs ATG-based) | +19 arms | **53 arms** | +56% |
| 3 (within-PTCy variants) | +2 arms | **11 arms** | +22% |

Comparison 2 continues strong growth (Brissot/Battipaglia/Bazarbachi pattern from block 2 + Bailen/Dybko/Dreger/Garcia-Horton in block 3 added 19 more arms). Comparison 3 still the rate-limiting comparison — sparse single-arm within-PTCy variation papers.

## Exclusion breakdown (block 3, 28 papers)

| Reason | N |
|---|---|
| Conference abstract | 15 |
| Reference systematic review/MA | 2 (ElGohary 2020, Gao F 2021) |
| Narrative review | 2 (Elmariah & Bolaños-Meade, Georges & Storb) |
| Duplicate (publisher filename) | 2 (Dreger 2019, Giebel 2023 Cancer Wiley) |
| Duplicate (Desai 115/116 same paper) | 1 |
| Pediatric outside protocol | 1 (Ersoy 2023) |
| Hemoglobinopathy outside protocol | 1 (Desai 2024) |
| Single-arm descriptive (no PTCy contrast) | 2 (Gimenez, Gjaerde) |
| No PTCy contrast (both arms PTCy in different antivirals) | 1 (Freyer 2022) |
| Unspecified (Freyer alt filename) | 1 |
| **Total** | 28 |

**Pediatric/hemoglobinopathy exclusions cleanly enforced** — both protocol exclusions (Ersoy BK pediatric; Desai hemoglobinopathy) flagged correctly.

## New cohorts added (15)

| cohort_id | label | source |
|---|---|---|
| 1044 | PrincessMargaret_Toronto_MSD_PBSC | Desai 2025 MSD subset |
| 1045 | LMU_Munich_Augsburg_hrAML_sequential | Doppelhammer 2019 |
| 1046 | EBMT_CIBMTR_DLBCL_LWP | Dreger 2019 (EBMT Lymphoma WP × CIBMTR) |
| **1047** | **PALG_Polish_registry** | **3 Dybko papers (122, 123, 124)** |
| 1048 | SantPau_Barcelona_Esquirol_UCBT_Haplo | Esquirol 2020 |
| 1049 | GETH_Esquirol_haplo_PTCy_infections | Esquirol 2021 Spanish multicenter |
| 1050 | GETH_TC_lymphoid_RIC | Fox 2024 |
| 1051 | GETH_TC_EBMT_RIC_HAPLO_MMUD | Fox 2026 |
| **1052** | **BMT_CTN_1101** | **Fuchs 2021 — Haplo BM+PTCy vs UCB RCT** |
| 1053 | Gemelli_Rome_Galli_HC | Galli 2022 BK cystitis |
| 1054 | SouthwestChina_4center_SAA | Gao M 2025 |
| 1055 | CTTC_Canada_haplo_ATGPTCy_vs_PTCy | Garcia-Horton 2026 |
| 1056 | Juravinski_Hamilton_RR_HL | Ge 2025 |
| 1057 | HCUV_INCLIVA_Valencia_AdV | Gimenez 2025 adenovirus |
| 1058 | CYTOALLO_GITMO_AMCLI | Girmenia 2025 Italian multicenter CMV |

**BMT_CTN_1101 (cohort 1052)** is the 6th RCT in the database — Fuchs et al. NEJM 2021 haploidentical BM+PTCy vs UCB. Together with BMT CTN 1703, BMT CTN 1203, HOVON-96, ALLG BM12-CAST, Moiseev 2016 — we now have **6 RCTs**.

## Outcome category coverage — cumulative

```
aGVHD                           289  ← well-covered
overall_mortality               173
cGVHD                           165
NRM                             149
engraftment_failure             107
CMV                             106  ← growing (+33 this block)
other_infection                  67
BSI                              46
infection_related_mortality      43
IFI_mold                         20
IFI_any                          15
IFI_yeast                         7
second_line_GVHD_therapy_use      6
steroid_refractory_aGVHD          5
```

CMV grew substantially this block (Camargo, Chen, Chorão, Dybko 122, Freyer, Gimenez, Girmenia). IFI categories still under-represented — Salas/Massoud/Papanicolaou subsets cluster alphabetically later (M, P, S).

## Validation status

After fixes, all 9 rules pass (modulo carry-over pilot warning R2 outcome 225).

**8 fixes applied:**

1. **Study 111 (Desai 2025 MSD, 4-arm):** Arm 129 (Group II ATG-CNI-MTX) `c2 → Y` (correct ATG comparator); arm 130 (Group III PTCy-ATG-CNI, dual-modality) `c2 → N` (combined PTCy+ATG ambiguous for the comp).
2. **Study 112 (Desai 2026 MRD):** Arm 134 (Group C ATG-CNI-MTX/MMF) `c2 → Y` (ATG comparator); arm 134 `c3 → N` (not a PTCy variant).
3. **Study 120 (Dreger 2019 DLBCL):** Arm 141 (MUD TCD+ with ATG) `c2 → Y` (ATG comparator), `c1 → N` (presence of ATG disqualifies it as clean CNI+MTX comparator).
4. **Study 124 (Dybko 2024 MMUD):** Arms 148 (haplo) and 149 (MMUD) `c1 → N` (no CNI+MTX comparator in study).
5. **Study 137 (Fox 2026):** Arms 156 (HAPLO) and 157 (MMUD-PTCy) `c1 → N` (MMUD-OTHERS arm is mixed/ambiguous, not a clean CNI+MTX comparator).
6. **Study 146 (Garcia-Horton 2026):** Arm 168 (pure PTCy) `arm_role → comparator_arm` (within-PTCy comp3 convention: PTCy-alone = reference; ATG+PTCy = PTCy_arm).
7. **Arm 145 (Esquirol 2021):** `n_patients` 93 → 110 (matches outcome denominators).

## v1.2 back-calc policy — sustained

`systemic_steroid_for_gvhd_exposure_pct` populated in **126/171 arms (74%)** — up from 68% at end of block 2, 59% after block 1, 18% in pilot. The back-calc proxy is now the dominant input for the GVHD-adjusted mediation model.

## Notable extraction findings

- **BMT_CTN_1101 (Fuchs 2021)** — 6th RCT in the database. Haplo BM+PTCy (n=147) vs double UCB (n=143). This is the NEJM 2021 paper. Provides important haploidentical signal for Comparison 3 and an indirect Comparison 1 path via the UCB arm's CNI-based prophylaxis.
- **PALG Polish registry (Dybko cluster)** — three papers (122 CMV, 123 MUD benefits, 124 MMUD subset) all rolled under cohort 1047. Each is `primary_for_cohort = partial` for a different outcome category.
- **EBMT Lymphoma WP** introduced as cohort 1046 (Dreger 2019 DLBCL) — distinct from ALWP (1024) and CMWP (1035, 1037).
- **GETH cluster expanding** — Spanish multicenter group now has separate cohorts for different subsets: 1019 (Bailen MUD/MMUD), 1020 (Bailén AML), 1049 (Esquirol infections), 1050 (Fox lymphoid RIC), 1051 (Fox haplo vs MMUD). May need BMTD review for patient-level overlap; could merge into single GETH_TC cluster if same patient pool.
- **Multiple Desai N papers** (study 111, 112, 115) all from Princess Margaret Toronto; cohorts 1044, 1042, 1043 — possible cohort merger candidate for BMTD review.
- **Two long Wiley journal export filenames** (Giebel 150 → 151; Dreger 121 → 120) cleanly identified as duplicates by subagents.

## Cumulative database — 3-block snapshot

- **6 RCTs**: Bolaños-Meade NEJM 2023 (BMT CTN 1703), Moiseev IS 2016 (Pavlov), Bolaños-Meade 2019 (BMT CTN 1203 phase 2 4-arm), Broers 2022 (HOVON-96), Curtis 2025 (ALLG BM12-CAST), Fuchs 2021 (BMT CTN 1101).
- **57 cohort clusters identified** across pilot and blocks 1–3.
- **53 arms eligible for Comparison 2** — comp2 is now the most actively growing comparison.
- **Comparison 3 (within-PTCy)** still the weakest at 11 arms — expect catch-up in later blocks with more multi-arm trials (e.g., Shaffer-style MUD vs MMUD, donor-variant subgroup papers).

## v1.3 candidates updated

Same three as block 2:
1. Add `arms.extraction_notes` column (back-calc audit trail).
2. Add `arms.systemic_steroid_pct_source` enum (`direct_report | back_calculated_from_aGVHD_II_IV | NR`).
3. Deprecate `second_line_gvhd_therapy_exposure_pct` (still 3-6% reporting rate).

New candidate from block 3:
4. **Cohort merger review** — the GETH/Spanish multicenter clusters (1019, 1020, 1049, 1050, 1051) and Princess Margaret Desai cohorts (1042, 1043, 1044) may have patient-level overlap. Worth a manual BMTD review pass before locking the database.

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (57 cohorts / 83 studies / 171 arms / 1198 outcomes / 51 subgroup / 78 rob)
- `excluded_papers_block_3.json` (scratch outputs) — 28 excluded papers with reasons for PRISMA
- `extraction_paper_<N>.json` (scratch outputs) — raw JSONs for audit

## Block 4 readiness

Ready when you are. Block 4 = study_ids 161–210, alphabetical roughly Go–La range.
