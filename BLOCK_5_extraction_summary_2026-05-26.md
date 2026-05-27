# PTCy MA — Block 5 extraction summary (papers 211–260)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 launched, 1 retried for missing JSON)
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Verifier:** PEND (BMTD second-pass needed)

---

## Headline result

50 papers attempted. **25 extracted** (50%), **25 excluded** (50%). All 9 validation rules pass after 18 fixes (3 R4/R6 logical errors + 15 IFD→IFI category typos).

| Sheet | Cumulative (pilot + b1 + b2 + b3 + b4 + b5) | Block 5 added |
|---|---|---|
| `cohorts` | 99 (78 + 21) | 21 new clusters |
| `studies` | 130 (105 + 25) | 25 |
| `arms` | 270 (217 + 53) | 53 |
| `outcomes` | 1,861 (1,549 + 312) | 312 |
| `outcomes_subgroup` | 68 (59 + 9) | 9 |
| `rob` | 123 (100 + 23) | 23 |

## Comparison eligibility — cumulative

| Comparison | Block 5 added | Cumulative | Δ |
|---|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | +34 arms | **173 arms** | +24% |
| 2 (PTCy vs ATG-based) | +10 arms | **71 arms** | +16% |
| 3 (within-PTCy variants) | +6 arms | **19 arms** | +46% |

Comparison 3 saw the biggest relative growth (+46%) thanks to Li Y 2022 (within-PTCy regimen variants), Modi 2021 MAC vs RIC, and others.

## Exclusion breakdown (block 5, 25 papers)

| Reason | N |
|---|---|
| Conference abstract | 10 |
| Narrative review | 6 |
| Systematic review / meta-analysis | 2 |
| Pre-PTCy era (no PTCy contrast) | 2 |
| Single-arm descriptive (no PTCy stratification) | 1 |
| No PTCy contrast (protocol-excluded patients) | 1 |
| Duplicate (Luznik 228 = 226) | 1 |
| Survey (no patient outcomes) | 1 |
| Reference MA | 1 |

**High narrative-review density** in this alphabetical slice (Luo XH, Ma X, Mariotti, Martinez-Cibrian, Matsui & Ogimi, McCurdy & Fuchs).

## New cohorts added (21)

| cohort_id | label | source |
|---|---|---|
| 1080 | EUROGRAFT_2017_multicenter | EBMT Lorentino 2017 |
| 1081 | Hubei_AA_haplo_multicenter | Chinese AA Liu cohort |
| 1082 | TaipeiVGH_Liu_IFD | Taiwan single-center |
| 1083 | Singapore_2center_RR_lymphoma_alloHSCT | Loke 2025 — single-arm descriptive (PRISMA-tracked, no outcomes) |
| **1084** | **BMT_CTN_1301** | **Luznik 2022 NEJM — 7th RCT** |
| 1085 | Hacettepe_Ankara_haplo_PTCy | Malkan 2023 |
| **1086** | **Hamburg_Massoud_single_center** | **Massoud 2022 — known anchor paper from planning chat** |
| 1087 | DanaFarber_Maurer_URD_PBSCT | Maurer 2023 |
| 1088 | DFCI_BWH_MDS_AML_HCTCI | Mehta A 2026 |
| 1089-1091 | MDACC Mehta cluster (3 cohorts) | MDACC's Mehta papers cover different subsets |
| 1092 | CIBMTR_ALL_Wieduwilt_dataset | Mehta RS 2023 ALL |
| 1093 | Genoa_Rome_Foscarnet_CMV_2010_2015 | Metafuni 2018 |
| 1094 | SanMartino_Genoa_preBSI | Mikulska 2018 |
| 1095-1096 | WSU Karmanos Modi cluster | 2 Modi papers same institution |
| 1097 | KUMC_Mohyuddin_haplo_EBV | EBV viremia |
| **1098** | **EBMT_TCWP_MD_PTCy_ATG** | **Moiseev I 2025 EBMT TCWP** (new EBMT working group) |
| 1099 | Pavlov_StPetersburg_MRD_BMT | Moiseev IS 2017 (distinct from cohort 1007 MUD RCT) |
| 1100 | Stanford_MAC_HLAmatched_AML_ALL | Molina 2026 |

## Seventh RCT joined the database

**BMT_CTN_1301 (Luznik 2022, NEJM)** — Phase III RCT of calcineurin inhibitor-free GVHD prophylaxis (PTCy alone or PTCy+bortezomib vs CNI-based). 3 arms; comparison_1_eligible. Joins:
1. BMT CTN 1703 (Bolaños-Meade 2023 NEJM)
2. Moiseev 2016 (Pavlov MUD)
3. BMT CTN 1203 (Bolaños-Meade 2019 phase 2)
4. HOVON-96 (Broers 2022)
5. ALLG BM12-CAST (Curtis 2025)
6. BMT CTN 1101 (Fuchs 2021)
7. **BMT CTN 1301 (Luznik 2022) — new this block**

## Outcome category coverage — cumulative

```
aGVHD                          443  (+81 this block)
overall_mortality              276  (+46)
cGVHD                          272  (+51)
NRM                            239  (+45 + 2 NRM_overall fixes)
engraftment_failure            165  (+25)
CMV                            159  (+16)
other_infection                101  (+9)
infection_related_mortality     50  
BSI                             62  (+14)
IFI_mold                        25  (+5 after IFD→IFI typo fix)
IFI_any                         34  (+9 after typo fix)
IFI_yeast                       11  (+4)
second_line_GVHD_therapy_use    16
steroid_refractory_aGVHD        16  (+7)
```

## Validation status

After 18 fixes, all 9 rules pass.

**Fixes applied:**

1. **Study 253 (Modi 2021 MAC vs RIC):** Both arms initially marked `PTCy_arm` for Comparison 3 within-PTCy conditioning intensity variant. Reset MAC arm (260) → `comparator_arm` (MAC as reference for RIC variant).
2. **Outcomes 1690, 1691 (Mehta RS 2022):** `NRM` category with subtype `any_grade` (invalid). Fixed to `NRM_overall`.
3. **Fifteen IFD→IFI typo corrections:** Multiple block 5 subagents wrote `IFD_mold`, `IFD_yeast`, `IFD_any` instead of the canonical `IFI_*` (invasive fungal infection) vocabulary. All 15 corrected. Block 5 had a higher typo rate than prior blocks (perhaps from the China IFD-focused papers in Li/Liu cluster).

## v1.2 back-calc — sustained

`systemic_steroid_for_gvhd_exposure_pct` populated in **199/270 arms (74%)** — stable from block 4's 76%.

## Notable extraction findings

- **Massoud 2022 (cohort 1086)** finally extracted — this was an anchor paper from the planning chat ("known included papers"). Hamburg single-center PTCy vs ATG comparison, immune reconstitution focus, AML/MDS.
- **EBMT Transplant Complications WP (cohort 1098)** — new EBMT working group emerges. Moiseev I 2025 used the TCWP registry (distinct from ALWP, CMWP, LWP).
- **Pavlov RCT cluster sub-divided:** cohort 1007 (Pavlov_StPetersburg_RCT, Moiseev 2016 MUD/BMT) now distinct from cohort 1099 (Pavlov_StPetersburg_MRD_BMT, Moiseev 2017 MRD/BMT). Two separate trials at the same institution.
- **MDACC Mehta cluster:** 3 distinct cohorts (1089, 1090, 1091) for different Mehta RS subsets. Worth BMTD review for patient-level overlap during verification.
- **One agent flagged a mislabeled PDF:** Lim CX 2019 (study 218) — the file actually contains a different paper (Enrich 2018 CCR5 study). Flagged in extraction_notes. Doesn't affect the database since 218 was excluded as conference_abstract anyway.

## Cumulative database — 5-block snapshot

- **130 studies extracted** from 260 papers attempted (50% extraction rate)
- **99 cohort clusters identified**
- **270 arms, 1,861 outcomes**
- **7 RCTs** with 49% extraction rate sustained across blocks 1–5
- **Corpus progress: 260 of 409 papers attempted (64%)**

## v1.3 candidates (updated)

1. Add `arms.extraction_notes` column — confirmed missing during a subagent note in block 5.
2. Add `arms.systemic_steroid_pct_source` enum.
3. Deprecate `second_line_gvhd_therapy_exposure_pct`.
4. Cohort-merger review (GETH cluster, Princess Margaret, MDACC Mehta cluster, Pavlov 1007 vs 1099).
5. **NEW: enforce outcome_category controlled vocabulary at JSON-output time.** Block 5's 15 IFD→IFI typos suggest the EXTRACTION_SPEC.md could include a strict "categories you may use" reference card at the top.

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (99 cohorts / 130 studies / 270 arms / 1,861 outcomes / 68 subgroup / 123 rob)
- `excluded_papers_block_5.json` (scratch) — 25 papers with reasons

## Block 6 readiness

Ready when you are. Block 6 = study_ids 261–310, alphabetical Mo–Pa range.
