# PTCy MA — Block 4 extraction summary (papers 161–210)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 launched, all completed first try — no rate-limit casualties)
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Verifier:** PEND (BMTD second-pass needed)

---

## Headline result

50 papers attempted. **22 extracted** (44%), **28 excluded** (56%). All 9 validation rules pass after 9 fixes (7 comparison-eligibility relabels + 2 IFI_any subtype corrections).

| Sheet | Cumulative (pilot + b1 + b2 + b3 + b4) | Block 4 added |
|---|---|---|
| `cohorts` | 78 (57 + 21) | 21 new clusters |
| `studies` | 105 (83 + 22) | 22 |
| `arms` | 217 (171 + 46) | 46 |
| `outcomes` | 1,549 (1,198 + 351) | 351 |
| `outcomes_subgroup` | 59 (51 + 8) | 8 |
| `rob` | 100 (78 + 22) | 22 |

## Comparison eligibility — cumulative

| Comparison | Block 4 added | Cumulative | Δ |
|---|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | +42 arms | **139 arms** | +43% |
| 2 (PTCy vs ATG-based) | +8 arms | **61 arms** | +15% |
| 3 (within-PTCy variants) | +2 arms | **13 arms** | +18% |

Comparison 1 had a strong block — 42 new arms (the largest single-block contribution) driven by Hamadani (4-arm CIBMTR T-cell lymphoma), Huntley (4-arm), Kanate (3-arm CIBMTR lymphoma), Jamy (3-arm haplo/MUD CMV), and others. Comparison 2 grew more modestly (Haebe, Hamadani, Jimenez, Jin, Kanate, Kanakry-style ATG comparisons). Comparison 3 still rate-limiting.

## Exclusion breakdown (block 4, 28 papers)

| Reason | N |
|---|---|
| Conference abstract | 17 |
| Reference systematic review/MA | 2 |
| Pre-PTCy era (no PTCy contrast) | 2 (Junghanss 2002, Kim 2013) |
| Unclear (Han 2021 — Beijing protocol; Harada 2023 — likely abstract) | 2 |
| Narrative review | 1 |
| Duplicate of earlier paper | 1 (Jahangiri 181→182) |
| Single-arm descriptive | 1 (Kachur letermovir) |
| Non-eligible population: thalassemia | 1 (Lad 2023) |
| No PTCy contrast in mixed cohort | 1 (Hubmann 2016) |
| **Total** | 28 |

**New exclusion category emerged:** pre-PTCy era papers (Junghanss 2002 nonmyeloablative vs myeloablative infection profile; Kim 2013 RIC vs MAC infectious complications). Both predate widespread PTCy adoption and have no PTCy contrast.

## New cohorts added (21)

Notable additions:

- **1064 JDCHCT_TRUMP2_UCBT_vs_PTCyHaplo** — Japanese transplant registry (Harada 2025); newly distinct from JSHCT
- **1070 JSTCT_TRUMP_ALL_PTCyHaplo_UCB** — Japanese ALL subset (Jo 2024)
- **1063 EBMT_CIBMTR_TCL_LWP** — EBMT Lymphoma WP × CIBMTR T-cell lymphoma (Hamadani 2022)
- **1073 CIBMTR_Lymphoma_Haplo_URD** — CIBMTR Lymphoma WP haplo vs URD (Kanate 2016)
- **1060 Jefferson_2step_MRD** — Thomas Jefferson 2-step PTCy protocol (Grosso 2020)
- **1076 AlbertEinstein_SaoPaulo_Kerbauy_haplo_UD** — Brazilian cluster (2 Kerbauy papers)

The full list (1059–1079) is in the workbook cohorts sheet.

## Outcome category coverage — cumulative

```
aGVHD                          362  (+73 this block)
overall_mortality              230  (+57)
cGVHD                          221  (+56)
NRM                            194  (+45)
engraftment_failure            140  (+33)
CMV                            143  (+37)
other_infection                 92  (+25)
infection_related_mortality     48
BSI                             48
IFI_mold                        20
IFI_any                         24  (+9)
IFI_yeast                        7
second_line_GVHD_therapy_use    11
steroid_refractory_aGVHD         9
```

CMV continues steady growth. BSI and IFI categories remain under-represented overall — alphabetical density of these focused papers is in later blocks (M, P, S).

## Validation status

After 9 fixes, all 9 rules pass.

**Fixes applied:**

1. **Study 167 (Haebe Hodgkin):** Arm 176 (URD-HSCT with ATG) `c2 → Y` (correct ATG comparator for PTCy-haplo arm).
2. **Study 168 (Hamadani T-cell lymphoma CIBMTR):** Arm 179 (MUD TCD+ with ATG) `c2 → Y`; arm 177 `c3 → N` (no within-PTCy variant in study).
3. **Study 178 (Huntley Spanish haplo CMV):** Arm 184 `c2 → N`, `c3 → N` (no ATG arm; no within-PTCy variants).
4. **Study 196 (Kanate CIBMTR lymphoma):** Arm 203 (URD with ATG) `c2 → Y`.
5. **Study 208 (Kwon 2017 haplo-cord):** Arm 214 (Haplo-Cord, CNI-based) `c1 → Y` (matched comp1 with PTCy-haplo arm 215).
6. **R6 IFI_any:** Outcomes 1498 and 1510 — subtype `investigator_reported` → `investigator_reported_any` (correct vocabulary for IFI_any).

## v1.2 back-calc — still sustained

`systemic_steroid_for_gvhd_exposure_pct` populated in **164/217 arms (76%)** — slight uptick from 74% after block 3.

## Notable extraction findings

- **Six RCTs still** — no new RCTs in block 4 (Koura 2023 RCT comparing 3 PTCy doses was excluded as conference abstract; will likely become extractable when published).
- **Beijing protocol exclusion** — Han 2021 paper on "unmanipulated haploidentical" appears to use the Beijing protocol (ATG-based, not PTCy); confirms protocol scope discipline.
- **Thalassemia exclusion** — Lad 2023 was correctly excluded under the non-malignancy/SAA-only protocol scope.
- **Pre-PTCy era papers** — two papers from before PTCy widespread adoption (Junghanss 2002, Kim 2013) excluded cleanly. Worth a brief note in the PRISMA flow for the manuscript.
- **Holtan 2023 BMT CTN 1703 PRO** — excluded as conference abstract per skill bundle, which is correct (this is the QoL/PRO companion to BMT CTN 1703; only included if it reports infection data, which it doesn't).
- **EBMT vs CIBMTR working group disambiguation** — the database now has separate cohorts for EBMT ALWP (1024), EBMT CMWP MDS (1035), EBMT CMWP myelofibrosis (1037), EBMT LWP DLBCL (1046), EBMT CIBMTR TCL (1063), and CIBMTR Lymphoma haplo-URD (1073). This separation is essential for the cohort-overlap rule.

## Cumulative database — 4-block snapshot

- **105 studies extracted** across pilot + 4 blocks
- **78 cohort clusters**
- **217 arms**
- **1,549 outcomes**
- **6 RCTs**: BMT CTN 1703, BMT CTN 1203, BMT CTN 1101, HOVON-96, ALLG BM12-CAST, Moiseev 2016 — adequate base for frequentist sanity-check
- **PRISMA exclusion tally**: 103 papers excluded across all blocks (25 + 25 + 28 + 28 - includes pilot's 2 abstracts); most common reasons: conference abstracts (~57), reviews (~10), duplicates (~10), pediatric/non-eligible populations (~5), pre-PTCy era (~2)

## v1.3 candidates updated

Same three persistent candidates from earlier blocks; no new candidates emerged in block 4:
1. Add `arms.extraction_notes` column.
2. Add `arms.systemic_steroid_pct_source` enum.
3. Deprecate `second_line_gvhd_therapy_exposure_pct`.

The cohort-merger review item carries over (GETH cluster, Princess Margaret cluster, possible Brazilian Kerbauy 200/201 vs new 1076 merger).

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (78 cohorts / 105 studies / 217 arms / 1,549 outcomes / 59 subgroup / 100 rob)
- `excluded_papers_block_4.json` (scratch outputs) — 28 excluded papers with reasons

## Block 5 readiness

Ready when you are. Block 5 = study_ids 211–260, alphabetical roughly La–Mo range.

Approximate corpus progress: 210 of 409 papers attempted (51%). At current ~44% extraction rate, expect ~88 more extracted papers across blocks 5–8.
