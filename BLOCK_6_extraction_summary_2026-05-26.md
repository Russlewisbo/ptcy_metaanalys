# PTCy MA — Block 6 extraction summary (papers 261–310)

**Date:** 2026-05-26
**Extractor:** RL via parallel subagent workflow (50 launched, 15 hit session limit and were retried after reset)
**Workbook updated:** `PTCy_MA_extraction_template_v1.2.xlsx`

---

## Headline result

50 papers attempted. **33 extracted** (66%), **17 excluded** (34%). All 9 validation rules pass after 14 fixes.

| Sheet | Cumulative (pilot + b1-b6) | Block 6 added |
|---|---|---|
| `cohorts` | 121 (99 + 22) | 22 new clusters |
| `studies` | 163 (130 + 33) | 33 |
| `arms` | 339 (270 + 69) | 69 |
| `outcomes` | 2,249 (1,861 + 388) | 388 |
| `outcomes_subgroup` | 75 (68 + 7) | 7 |
| `rob` | 155 (123 + 32) | 32 |

## Comparison eligibility — cumulative

| Comparison | Block 6 added | Cumulative | Δ |
|---|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | +50 arms | **223 arms** | +29% |
| 2 (PTCy vs ATG-based) | +10 arms | **81 arms** | +14% |
| 3 (within-PTCy variants) | +6 arms | **25 arms** | +32% |

Comparison 1 had the **single biggest block contribution** (+50 arms) — block 6 was Nagler-heavy with multiple EBMT ALWP registry papers covering PTCy vs conventional/ATG.

## Exclusion breakdown (block 6, 17 papers)

| Reason | N |
|---|---|
| Conference abstract | 13 |
| Narrative review | 2 (Nagler 2021 editorial; Nagler & Ruggeri 2019) |
| Duplicate (Mukherjee 266=267) | 1 |
| No PTCy arm (Park 2021 SAA) | 1 |

**Block 6 exclusion rate dropped to 34%** (vs 50% in block 5) — the M–P alphabetical slice contained more journal papers, fewer abstracts.

## Notable new RCTs / large studies added

This block added many **registry studies but no new RCTs** (still 7 total). Notable additions:

- **Nagler EBMT ALWP cluster** — 8 extracted papers (276, 277, 278, 279, 280, 281, 282, 287) all routed to existing cohort 1024 (EBMT ALWP). Most are different patient subsets (ALL, AML, MUD, MSD, donor age) sharing the same EBMT registry. **Cohort-overlap rule worked end-to-end** — no new cohorts created for these.
- **Penack EBMT TCWP cluster** — 2 new cohorts (1121 EBMT_TCWP 10/10 MUD; 1122 EBMT_TCWP MRD), distinguishing the new Transplant Complications WP from ALWP/CMWP/LWP.
- **Multiple JSTCT (Japanese) registry studies** — Moriguchi, Jo (study 290), Nakaya, Nishikubo all use the Japanese Society for Transplantation and Cellular Therapy registry. 4 separate cohorts (1064, 1070, 1103, 1108, 1109, 1113) — some likely have patient-level overlap; flagged for BMTD review.

## Outcome category coverage — cumulative

```
aGVHD                          554  (+111 this block — Nagler cluster heavy)
NRM                            305  (+66)
overall_mortality              341  (+65)
cGVHD                          337  (+65)
engraftment_failure            194  (+29)
CMV                            165  (+6)
other_infection                123  (+22)
infection_related_mortality     68
BSI                             66
IFI_mold                        27
IFI_any                         24
IFI_yeast                       11
second_line_GVHD_therapy_use    16
steroid_refractory_aGVHD        16
```

CMV and BSI growth slowed in block 6 — the Nagler EBMT papers focus on GVHD/relapse/survival rather than infections.

## Validation status

After 14 fixes, all 9 rules pass.

**Fixes applied:**

1. **Study 263 (Moriguchi 2024):** Arm 277 (ATG-administered MUD) `c2 → Y` (ATG comparator).
2. **Study 272 (Mussetti 2022 haplo vs MUD lymphoma):** Arm 287 (MUD) `arm_role → comparator_arm` for within-PTCy donor variant comp3.
3. **Study 279 (Nagler 2023 de novo vs sAML):** Both PTCy arms; no non-PTCy comparator in study. Set both `c1 → N` (registry-internal stratification, not a head-to-head comp1).
4. **Study 282 (Nagler 2024 4-arm donor-age × type):** Set `c1=N, c2=N` for all 4 arms (no clean comp1/comp2); `c3=Y` for all (within-PTCy donor variant). Arm 308 (yMMUD) → `comparator_arm` as reference.
5. **Study 289 (Nakaya 2024):** Arm 311 `c2 → N` (no ATG comparator).
6. **Outcomes 1891, 1892:** cGVHD subtype `any_grade` → `any_NIH` (correct vocab).

## v1.2 back-calc — sustained

`systemic_steroid_for_gvhd_exposure_pct` populated in **254/339 arms (75%)** — stable.

## Notable findings

- **EBMT working group disambiguation working well.** Block 6 added EBMT TCWP (1098 + 1121 + 1122) cleanly distinct from ALWP (1024), CMWP (1035, 1037, 1116), LWP (1046, 1107).
- **Multiple JSTCT registry sub-cohorts.** Japanese registry papers now sprawl across cohorts 1064, 1070, 1103, 1108, 1109, 1113. BMTD should review for patient-level overlap.
- **Mulroney 2021 (study 268)** correctly routed to cohort 1001 (CIBMTR HaploCy/SibCy/SibCNI) per the skill bundle. The pilot's CIBMTR cohort cluster continues to grow consistently.
- **Park S.-S. 2021 (study 303)** — interesting finding: the paper is about severe aplastic anemia (SAA, which IS in scope) but uses ATG-based GVHD prophylaxis only; no PTCy arms. Correctly excluded.
- **Nath 2024 (study 291)** — MSKCC RIC vs NMA lymphoma — extracted as study row only (no arms/outcomes) per subagent's careful read: only 11% (31/279) patients received PTCy and outcomes are not stratified by PTCy use.
- **Two API overload errors** during retries (studies 301 Otoukesh and 305 Paviglianiti) — both succeeded on a single retry; no data lost.

## Cumulative database — 6-block snapshot

- **163 studies extracted** from 310 papers attempted (53% extraction rate, sustained)
- **121 cohort clusters identified**
- **339 arms, 2,249 outcomes**
- **7 RCTs** still: BMT CTN 1703, 1203, 1101, 1301; HOVON-96; ALLG BM12-CAST; Moiseev 2016
- **Corpus progress: 310 of 409 papers attempted (76%)**

## v1.3 candidates updated

Same five as before. New observation: **JSTCT/Japanese registry cohort-merger** review needed (6 separate JSTCT cohorts in block 6 alone, possible patient-level overlap).

## Files

- `PTCy_MA_extraction_template_v1.2.xlsx` — full workbook (121 cohorts / 163 studies / 339 arms / 2,249 outcomes / 75 subgroup / 155 rob)
- `excluded_papers_block_6.json` (scratch) — 17 papers with reasons

## Block 7 readiness

Ready when you are. Block 7 = study_ids 311–360, alphabetical Pa–Re range. Two blocks remaining to finish the corpus (~99 papers left of 409).
