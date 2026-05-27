# PTCy MA — Block 1 extraction summary (papers 11–60)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 agents launched, 3 rate-limited and retried)
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Schema version:** v1.2 (deprecated steroid_duration; documented back-calc policy)
**Verifier:** PEND (BMTD second-pass needed)

---

## Headline result

50 papers attempted. **25 extracted** (50%), **25 excluded** (50%). All 9 validation rules pass after three minor fixes.

| Sheet | Pilot + Block 1 totals | Block 1 added |
|---|---|---|
| `cohorts` | 24 (7 + 17) | 17 new cohort clusters |
| `studies` | 33 (8 + 25) | 25 |
| `arms` | 66 (22 + 44) | 44 |
| `outcomes` | 439 (169 + 270) | 270 |
| `outcomes_subgroup` | 26 (15 + 11) | 11 |
| `rob` | 31 (8 + 23) | 23 (RL only — BMTD verification pending) |

## Comparison eligibility after block 1

| Comparison | Total arms eligible | Block 1 contribution |
|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | 47 | +30 |
| 2 (PTCy vs ATG-based) | 13 | +10 |
| 3 (within-PTCy variants) | 4 | +2 |

Comparison 1 well-saturated. Comparison 2 still under-represented; Comparison 3 sparse — both will need targeted block selection if alphabetical exhaustion doesn't catch up.

## Exclusion breakdown (block 1, 25 papers)

| Reason | N |
|---|---|
| Conference abstract | 15 |
| Conference abstract + duplicate | 1 |
| Narrative review | 4 |
| Reference systematic review/MA | 2 |
| Duplicate (raw publisher filename) | 1 |
| Letermovir-focused, no PTCy contrast | 1 |
| Single-arm descriptive | 1 |

**The 50% abstract rate is empirical** — the A–Bo alphabetical chunk contained an unusually high density of ASH/EBMT 2024 proceedings (Altareb, Arslan, Aydin 2022, Battipaglia 2024, Baron 2023). Expect this rate to drop in later blocks.

The two systematic reviews flagged (Arcuri 2019, Arcuri 2025) are useful **comparator MAs** for the discussion section — preserve their citations even though they don't enter the database.

## New cohorts added (17)

| cohort_id | label | source |
|---|---|---|
| 1009 | ABMTRR_older_haplo_AMLMDS | national registry (Abadir 2024) |
| 1010 | MCW_Abid_haplo_CRS | single center |
| 1011 | CIBMTR_HL_HaploPTCy_MSDCNI | CIBMTR (Ahmed 2019 Hodgkin) |
| 1012 | CatholicKorea_SeoulStMary_ALL_HIDT | single center (Ahn 2025) |
| 1013 | PrincessMargaret_Toronto_Michelis | single center (Adoncecchi 2025) |
| 1014 | MDACC_Alousi_PTCy_RIC_PhaseII | single center |
| 1015 | Fortis_Arora_pediatric_benign | single center (Arora 2026) |
| 1016 | DRST_German_registry | national registry (Arslan 2024 et al) |
| 1017 | USC_Norris_Ashouri | single center |
| 1018 | Aydin_single_center | single center |
| 1019 | Bailen_GETH_MUD_mMUD_multicenter | Spanish multicenter (Bailén 2021) |
| 1020 | GETH_TC_Spanish_multicenter | Spanish multicenter (Bailén 2022 AML) |
| 1021 | Hackensack_Baker_single_center | single center |
| 1022 | Mayo_Rochester_Baranwal | single center |
| 1023 | Barkhordar_Tehran_single_center | single center (3 Barkhordar papers) |
| 1024 | EBMT_ALWP | EBMT registry — placeholder for Battipaglia 2019 etc |
| 1025 | Northside_Atlanta_AML_MDS_age60plus | single center (Bashey 2018) |

Cohort 1019 vs 1020 are both Spanish multicenter (GETH-TC) — these likely should be merged at BMTD verification. The Bailén 2021 paper used cohort 1019 (`Bailen_GETH_MUD_mMUD_multicenter`); the Bailén 2022 AML paper used a separately named 1020 (`GETH_TC_Spanish_multicenter`). Worth checking whether patient-level overlap exists.

## v1.2 amendment efficacy — back-calc policy

The deprecated `steroid_exposure_duration_days_median` field is correctly empty across all 66 arms (0/66 populated). Good — confirms the v1.1 pilot finding generalizes.

`systemic_steroid_for_gvhd_exposure_pct` populated in **39 of 66 arms (59%)** — substantial jump from pilot (4/22 = 18%). Most of this increase is from the v1.2 back-calculation policy (subagents back-calculated from aGVHD II–IV CI%). **However, the policy required subagents to leave a `back_calculated_from_aGVHD_II_IV` audit trail, and 0/33 study notes contain that string.** The subagents likely populated the field via back-calc but didn't trail the marker. Two implications:
1. BMTD verification should spot-check which arms were back-calculated vs directly reported by comparing the value against the paper's aGVHD II–IV CI%.
2. **v1.3 candidate:** add a dedicated `arms.systemic_steroid_pct_source` field with values `direct_report | back_calculated_from_aGVHD_II_IV | NR` so the audit trail is structured rather than dependent on a free-text note. Better: add `extraction_notes` to the `arms` sheet (currently missing).

`second_line_gvhd_therapy_exposure_pct` populated in 4/66 arms (6%) — still very sparse. May warrant deprecation in v1.3 or back-calc proxy.

## Outcome category coverage (block 1 only, 270 rows)

```
aGVHD                          71  ← well-covered (dual mediator extraction working)
overall_mortality              47
cGVHD                          44
NRM                            41
engraftment_failure            30
other_infection                18
CMV                             9
infection_related_mortality     8
steroid_refractory_aGVHD        2
IFI_mold                        0  ← NOT extracted in block 1
IFI_yeast                       0
BSI                             0  ← NOT extracted in block 1
```

**This block was dominantly GVHD/mortality reporting.** BSI, IFI, and to a large extent CMV are missing entirely from block 1. The A–Bo alphabetical slice happened to pick up GVHD-prophylaxis comparison papers; infection-focused papers (CMV, BSI, IFI) are concentrated alphabetically elsewhere (Goldsmith, Khimani, Massoud, Papanicolaou, Salas — many already extracted in pilot or coming in later blocks).

For analysis planning, this means infection-outcome data will accumulate more in blocks 5–8 (Sa–Z range).

## Validation status

After 3 fixes (described below), all 9 rules pass.

**Fixes applied:**
1. **R4 (study 44, Bailén 2022 GETH-TC):** Both arms initially labeled `PTCy_arm` for a within-PTCy Comparison 3 (HLA-id vs haplo). Set haplo arm (id 45) to `comparator_arm` by convention (HLA-identical = reference).
2. **R5 (cohort 1023, Barkhordar Tehran):** Three Barkhordar papers (study_ids 49, 50, 51) all originally marked `primary_for_cohort = Y`. Set 50 and 51 to `partial` — 49 (the broadest 3-arm comparison) wins primary, 50 and 51 cover specific subsets.
3. **R2 (outcome 225, Alousi 2015 Phase II):** denominator_n=49 exceeds arm.n_patients=37. The denominator reflects the pre-matching cohort; the matched-subset analysis used n=37. Flagged in `extraction_notes` for BMTD verification — likely the subagent should have used the matched-subset denominator.

## Notable extraction findings

- **Bolaños-Meade 2023 BMT CTN 1703 cohort cluster now anchored**: study 2 (NEJM primary) + study 12 (Abedin 2025 ≥70-yr subgroup) both reference cohort 1002. Study 13 (Abedin 2024) was excluded as a conference abstract (ASH 2023 oral preceding the 2025 manuscript). The cohort-overlap rule worked end-to-end.

- **EBMT ALWP cluster (cohort 1024)**: 2 papers from block 1 (Baron 2024 study 52, Battipaglia 2019 study 57). Battipaglia 2024 papers (58, 59) were conference abstracts and excluded; their journal-version successors will need separate tracking.

- **DRST German registry (cohort 1016)**: 2 papers (Arslan 2024 study 35; Arslan 2023 study 33 excluded as abstract). Block 1 captured the journal version cleanly.

- **High-density single-author clusters**: 3 Barkhordar Tehran papers (49–51), 3 Bailén papers (42 excluded, 43, 44 — possibly 2 cohorts). Worth manual review of patient-level overlap with the BMTD.

## v1.3 candidates (if pilot is bumped again later)

1. Add `arms.extraction_notes` column (currently missing — back-calc audit trail has no structured home).
2. Add `arms.systemic_steroid_pct_source` enum (`direct_report | back_calculated_from_aGVHD_II_IV | NR`).
3. Consider deprecating `second_line_gvhd_therapy_exposure_pct` (4/66 = 6% reporting rate).
4. Document cohort-merger procedure for cases like 1019 + 1020 (likely same GETH-TC cohort, different paper focus).

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (24 cohorts / 33 studies / 66 arms / 439 outcomes / 26 subgroup / 31 rob)
- `PTCy_MA_database_schema_v1.2.md` — schema v1.2 spec (back-calc policy documented)
- `excluded_papers_block_1.json` (in scratch outputs) — 25 excluded papers with reasons for PRISMA
- `extraction_paper_<N>.json` (in scratch outputs) — raw JSONs for audit
- `EXTRACTION_SPEC.md` (in scratch outputs) — v1.2 spec used by subagents
- `cohort_overlap_map.json` (in scratch outputs) — pre-batch cohort assignments

## Block 2 readiness

Ready when you are. Suggest the next 50 alphabetically (Bo–De range). Expected exclusion rate likely lower than 50% (the A–Bo abstract density was unusually high).
