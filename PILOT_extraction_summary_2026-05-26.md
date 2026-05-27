# PTCy MA — 10-paper pilot extraction summary

**Date:** 2026-05-26
**Extractor:** RL (R. Lewis) via parallel subagent workflow
**Workbook updated:** `PTCy_MA_extraction_template_v1.1.xlsx`
**Verifier:** PEND (BMT director second-pass needed)

---

## Headline result

8 of 10 pilot papers extracted into the v1.1 database. Two excluded as conference abstracts. All 9 validation rules pass.

| Tally | Rows added |
|---|---|
| `cohorts` | 7 |
| `studies` | 8 |
| `arms` | 22 |
| `outcomes` | 169 |
| `outcomes_subgroup` | 15 |
| `rob` | 8 (RL only — BMTD pending) |

## Per-study breakdown

| study_id | Paper | Design | Arms | Outcomes | Subgroup |
|---|---|---|---|---|---|
| 1 | Ara T. 2023 | **excluded** (conference abstract) | — | — | — |
| 2 | Bolaños-Meade 2023 NEJM | RCT | 2 | 20 | 0 |
| 3 | Bordat J. 2024 | **excluded** (conference abstract) | — | — | — |
| 4 | Goldsmith 2021 (CIBMTR CMV) | registry | 3 | 9 | 9 |
| 5 | Khimani 2021 (Moffitt) | retrospective cohort | 4 | 12 | 0 |
| 6 | Meyer 2025 (Freiburg) | retrospective cohort | 4 | 40 | 0 |
| 7 | Moiseev 2016 (Pavlov) | prospective cohort* | 2 | 24 | 0 |
| 8 | Papanicolaou 2024 (CIBMTR IFI) | registry | 3 | 30 | 0 |
| 9 | Salas 2022 (Barcelona BSI) | retrospective cohort | 2 | 24 | 4 |
| 10 | Shaffer 2024 (CIBMTR MUD/MMUD) | registry | 2 | 10 | 2 |

\* Moiseev 2016 was expected to be an RCT (per planning chat). Subagent classified it as `prospective_cohort` based on the PDF text. **Action:** BMTD to verify on second pass — if it's truly an RCT, switch `study_design = RCT` and `rob_tool = RoB2`, otherwise leave as is.

## Comparison eligibility

| Comparison | Arms eligible | Notes |
|---|---|---|
| 1 (PTCy vs CNI+MTX/MMF) | 17 | well-represented; primary signal driver |
| 2 (PTCy vs ATG-based) | 3 | sparse — both ASH-abstract papers (Ara, Bordat) were excluded; pull more from full corpus |
| 3 (within-PTCy variants) | 2 | Shaffer MUD/MMUD; will need additional within-PTCy comparisons |

## Outcome category coverage

```
aGVHD                          24  ← well-covered
CMV                            23
BSI                            22
overall_mortality              19
cGVHD                          14
infection_related_mortality    13
NRM                            11
other_infection                11
IFI_mold                        9
engraftment_failure             6
IFI_yeast                       6
IFI_any                         5
second_line_GVHD_therapy_use    4
steroid_refractory_aGVHD        2  ← sparse
steroid_refractory_cGVHD        0  ← unreported across pilot
```

## v1.1 amendment field completeness — important finding

The three IS-exposure fields added in v1.1 are mostly **not reported** in published papers:

| Field | Reported in N/22 arms |
|---|---|
| `systemic_steroid_for_gvhd_exposure_pct` | 4 (18%) |
| `steroid_exposure_duration_days_median` | 0 (0%) |
| `second_line_gvhd_therapy_exposure_pct` | 4 (18%) |

**Implication for v1.2 decision:**
- `steroid_exposure_duration_days_median` is essentially never reported. Consider dropping for v1.2.
- The other two are reported in ~1 of 5 papers. The arm-level mediation model can still run, but with reduced precision; consider whether to back-calculate `systemic_steroid_for_gvhd_exposure_pct` from `aGVHD grade II-IV CI%` as a lower-bound proxy (the schema already notes "almost all grade II+ get steroids").
- The mediator-model adjusted analysis may be best run as a sensitivity rather than a primary comparison, with arm-level GVHD-CI as the main mediator covariate (which IS well-reported).

## Cohort overlap handling — pilot validation

The cohort-overlap rule worked as designed on the CIBMTR cluster:
- Goldsmith 2021 (study 4) emitted the cohort row (cohort_id 1001), `primary_for_cohort = partial`, with overrides "IFI:8" (Papanicolaou) embedded.
- Papanicolaou 2024 (study 8) emitted no cohort row, referenced cohort 1001 in its studies row, `primary_for_cohort = partial`, `overlap_with_study_ids = "4"`.

This is the model for handling the remaining 6 known overlapping cohorts in the main corpus.

## Validation status

All 9 rules in `export_to_csv.R` / spec pass after two minor `arm_role` labeling fixes:
- Papanicolaou HaploCy arm had `comparison_2_eligible = Y` incorrectly (no ATG arm in study) — fixed to `N`.
- Shaffer arm 21 (PTCy-MUD 8/8) was both arms marked `PTCy_arm`; for Comparison 3 within-PTCy convention, one needs to be `comparator_arm` — set arm 21 → `comparator_arm` (MUD treated as reference for the MMUD comparison).

Three v1.1-specific rules (R7–R9) are satisfied with the data we have, but with limited test coverage (only 2 arms have SR-aGVHD data, only 4 have steroid exposure %).

## Recommendations before locking schema

1. **BMTD second-pass verification of all 8 studies** before opening the floodgates on the remaining 399 papers. Allow ~30 min per paper for verification.
2. **Decide on v1.2 amendments based on this pilot:**
   - Drop `steroid_exposure_duration_days_median` (0/22 reported).
   - Decide whether to back-calculate `systemic_steroid_for_gvhd_exposure_pct` from aGVHD II–IV as a documented derived field.
   - Q5 (mediator choice): keep both `grade_II_IV` and `grade_III_IV` per session decision; revisit after analytic run with both.
3. **Verify Moiseev 2016 study_design** — was it truly an RCT or prospective cohort? Affects RoB tool.
4. **Comparison 2 is under-represented in this pilot** because both ASH abstracts (Ara, Bordat) were rightly excluded. Full corpus has Bordat 2026 (the journal version of Bordat 2024) plus Massoud 2022 and others; representativeness will improve.
5. **`outcomes_subgroup` worked.** Goldsmith CIBMTR provided 9 stratified rows, Salas provided 4, Shaffer provided 2 — the table design holds up in practice.

## Files

- `PTCy_MA_extraction_template_v1.1.xlsx` — pilot data populated into rows 4+
- `extraction_paper_<N>.json` (in scratch outputs) — raw per-paper JSON; preserved for audit
- `EXTRACTION_SPEC.md` — the spec subagents followed; archive with this pilot for reproducibility
- `id_mappings.json` — provisional → global ID maps

## What's next

1. RL spot-check the workbook against 1–2 papers (suggest Bolaños-Meade NEJM as gold-standard).
2. Send to BMT director for full second-pass on the 8 extracted papers.
3. Discuss v1.2 amendment list (steroid duration field; back-calculation policy; mediator choice).
4. If pilot accepted: extract the remaining 399 papers in batches, applying the same subagent workflow but with a tighter spec reflecting any v1.2 amendments.
