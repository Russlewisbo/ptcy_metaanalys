# PTCy Meta-Analysis Extraction Database — Schema v1.2

**Project:** Bayesian meta-analysis of infection risk associated with post-transplant cyclophosphamide (PTCy)
**Schema author:** R. Lewis (UniPD) with Claude
**Schema version:** 1.2 (small refinements after 10-paper pilot; deprecates one field, documents back-calc policy, confirms dual mediator extraction)
**Date:** 2026-05-26
**Supersedes:** `PTCy_MA_database_schema_v1.1.md` (retained for audit trail)

---

## 0. Changes from v1.1

The 10-paper pilot (completed 2026-05-26) surfaced three actionable patterns. v1.2 records them.

| Change | Where | Rationale |
|---|---|---|
| Deprecate `steroid_exposure_duration_days_median` | `arms` | Reported in 0/22 pilot arms. Field remains in the workbook for backward compatibility but is now **do-not-populate**; mark `NR` always. Re-evaluate for v2 only if a standardized reporting practice emerges. |
| Document back-calculation policy for `systemic_steroid_for_gvhd_exposure_pct` | `arms` | Reported in 4/22 pilot arms. When **not** reported but `aGVHD grade_II_IV` CI% at D+100 is, populate the field with the aGVHD II–IV CI% as a documented **lower-bound proxy**; note `back_calculated_from_aGVHD_II_IV` in arm's `extraction_notes`. The Bayesian model then runs sensitivity (with vs without back-calculated arms). |
| Confirm dual mediator extraction | `outcomes` | Both `aGVHD grade_II_IV` AND `aGVHD grade_III_IV` at D+100 carry `is_primary_timepoint = Y`. Final mediator choice (II–IV vs III–IV vs both) is locked at analysis-stage based on cross-corpus reporting completeness. |

Everything else in v1.1 (six tables, validation rules, missingness codes, three-model mediation pattern) is unchanged.

---

## 1. Validation rules — same 9 from v1.1

R9 modified slightly: when `systemic_steroid_for_gvhd_exposure_pct` is back-calculated (extraction_notes contains `back_calculated_from_aGVHD_II_IV`), R9 is trivially satisfied and the row should not trigger a warning during validation.

---

## 2. Back-calculation procedure (canonical)

For each arm, in order:

1. **Look for `systemic_steroid_for_gvhd_exposure_pct` reported directly** in the paper (often in a "GVHD treatment" or "supportive care" table). If found → record as-is, mark `extraction_notes` empty for this field.

2. **If not directly reported but `aGVHD grade_II_IV` CI% at D+100 is reported**, set:
   - `systemic_steroid_for_gvhd_exposure_pct` ← `aGVHD grade_II_IV` CI% at D+100 (rounded to 1 decimal)
   - Append to `arms.extraction_notes`: `"systemic_steroid_for_gvhd_exposure_pct back_calculated_from_aGVHD_II_IV"`

3. **If neither is reported** → leave as `NR`.

Justification: every patient with aGVHD ≥ grade II receives systemic corticosteroids per standard of care (this is the canonical first-line treatment for aGVHD II–IV). The aGVHD II–IV CI% is therefore a tight lower bound for steroid exposure. The true value may be slightly higher (some grade I patients receive steroids for refractory skin disease, some chronic-GVHD patients receive steroid pulses). For meta-regression purposes, the lower-bound proxy is more conservative than NR (which forces exclusion of the arm from the adjusted model).

---

## 3. Pilot-attested findings carried forward

- The `outcomes_subgroup` table is used (Goldsmith 2021 emitted 9 rows, Salas 2022 emitted 4, Shaffer 2024 emitted 2). Pattern: stratification by donor type within registry arms, BSI pathogen subtypes within a single arm.
- `primary_for_cohort = partial` is in active use (Goldsmith vs Papanicolaou for the CIBMTR cluster).
- Conference abstracts excluded at first PDF inspection (Ara 2023, Bordat 2024 in pilot). Subagents pattern-match abstract structure (1–2 pages, no Methods/Results sections) and return `{excluded: true, reason: conference_abstract}`.

---

*Schema v1.2 — to be re-evaluated after block 1 of 50 extracted papers.*
