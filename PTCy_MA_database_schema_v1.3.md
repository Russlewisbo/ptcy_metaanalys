# PTCy Meta-Analysis Extraction Database — Schema v1.3

**Project:** Bayesian meta-analysis of infection risk associated with post-transplant cyclophosphamide (PTCy)
**Schema author:** R. Lewis (UniPD) with Claude
**Schema version:** 1.3
**Date:** 2026-05-29
**Supersedes:** `PTCy_MA_database_schema_v1.2.md` (retained for audit trail)

---

## 0. Changes from v1.2

| Change | Where | Rationale |
|---|---|---|
| Add `relapse_related_mortality` to `outcome_category` vocabulary | `outcomes` | Decompose OS into NRM + RRM components. Standard HCT meta-analysis decomposition. Reported separately from NRM in nearly all HCT papers. |
| Add `RRM_any_cause_relapse` to `outcome_subtype` vocabulary | `outcomes` | Primary subtype for the RRM category. |
| Promote `BK_hemorrhagic_cystitis` from opportunistic to primary extraction target | `outcomes` | Already in v1.2 vocab under `other_infection`. Targeted backfill pass 2026-05-29 systematizes coverage across all 251 studies. |
| Document v1.3 backfill pass | `outcomes` | 251-study re-pass adds RRM + BK rows only; existing arms, studies, cohorts, RoB rows untouched. |

Six-table relational schema unchanged. Universal missingness codes: `NR`, `NA`, `UNCL`, `PEND`.

## 1. Validation rules

Same as v1.2. No new rules.

## 2. New extraction targets in v1.3

### Relapse-related mortality (RRM)

- **outcome_category:** `relapse_related_mortality`
- **outcome_subtype:** `RRM_any_cause_relapse` (primary)
- **Primary timepoint:** D+365_1yr; sensitivity D+730_2yr, end_of_followup
- **Definition:** Death attributed to disease relapse or progression (competing risk vs NRM). Look in paper for: "relapse-related mortality", "RRM", "death from relapse", "death from progression", "deaths attributable to disease progression", "competing-risk relapse mortality".
- **Reporting form:** typically a cumulative incidence percentage at a fixed timepoint with Gray's competing-risk method. Many papers tabulate "NRM" and "Relapse/RRM" together as competing events.
- **Identity check:** If a paper reports both NRM CI% and OS%, then RRM CI% ≈ (1 − OS%) − NRM CI%. Use this only as a sanity check, not as primary extraction.

### BK virus / hemorrhagic cystitis

- **outcome_category:** `other_infection` (unchanged from v1.2)
- **outcome_subtype:** `BK_hemorrhagic_cystitis` (unchanged from v1.2)
- **Primary timepoint:** D+100; sensitivity D+180, D+365_1yr
- **Definition:** Look for: "BK viremia", "BK reactivation", "BK virus", "BKV", "hemorrhagic cystitis" (HC). Many papers report HC clinically rather than BKV virologically. Both are acceptable; record which definition was used in `definition_text`.
- **Reporting form:** cumulative incidence percentage; sometimes also count of cystitis grade ≥ 2 (CTCAE).
- **Clinical relevance:** BK / HC is a frequently-reported adverse event in PTCy-treated patients (cyclophosphamide is a known precipitant of HC even before allo-HCT) and is one of the directional questions the meta-analysis aims to address.

## 3. Tables

Six normalized tables (`cohorts`, `studies`, `arms`, `outcomes`, `outcomes_subgroup`, `rob`) — column structure unchanged from v1.1 / v1.2. See v1.1 schema for full field-by-field specifications.

## 4. Mediation analysis plan (v1.3 additions)

Add to the original three-model pattern:

- **RRM as outcome:** Direct M1 model per comparison. Optional M2 with steroid-percentage mediator (parallels NRM analysis). Together with NRM and OS, this decomposes the mortality picture: did PTCy improve OS by reducing NRM, by reducing RRM, or both?
- **BK as outcome:** Direct M1 model per comparison. Sparse-outcome behavior expected — strong prior on log-OR may help.

## 5. v1.3 backfill workflow (2026-05-29)

Targeted re-extraction pass on the 251 in-workbook studies:
- Each subagent reads one PDF and emits a small JSON containing ONLY new outcome rows (RRM + BK) attached to existing arm_ids.
- No new cohorts, studies, arms, or rob rows are emitted.
- Consolidator appends rows to `outcomes` sheet; outcome_id continues from the last used (next free = 3605).
- Outcomes with no reported RRM or BK in the source paper produce zero rows for that paper (paper-level "not reported" flag in extraction_notes).

## 6. v1.3 sign-off questions

All locked at v1.2 still apply. Additional v1.3 decisions:

1. ✅ RRM extracted as new category, not algebraically derived
2. ✅ BK includes both virologic (BKV) and clinical (HC) definitions
3. ✅ Backfill pass only adds outcome rows; arms/studies/cohorts untouched
4. ✅ Workbook output: `PTCy_MA_extraction_template_v1.3.xlsx` (carries forward all v1.2_post_block9 content)

*Schema v1.3 — backfill phase initiated 2026-05-29.*
