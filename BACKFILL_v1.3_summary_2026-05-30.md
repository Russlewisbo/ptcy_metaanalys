# v1.3 RRM + BK targeted backfill — summary

**Date:** 2026-05-30
**Scope:** Targeted re-extraction of two outcomes (relapse-related mortality, BK virus / hemorrhagic cystitis) from all 229 arm-bearing studies in the post-Block-9 corpus.
**Workbook:** `PTCy_MA_extraction_template_v1.3_fixed.xlsx` (the canonical v1.3 file; the original `_v1.3.xlsx` had a drawing-XML issue that prevented openpyxl from re-opening it, so the consolidator wrote a fresh-built file as `_fixed.xlsx`).

---

## Headline

- **229 papers re-scanned** (231 of 251 in workbook minus 22 arms-less PRISMA-tracked studies)
- **297 new outcome rows added** to v1.3 workbook
- **70 papers (31%) had RRM data** — 162 RRM rows added
- **56 papers (24%) had BK / HC data** — 135 BK rows added (plus the 66 BK rows already in workbook from blocks 1–9, total 201 BK rows)
- **126 papers (55%) had neither RRM nor BK reported** — PRISMA-tracked as "neither reported"
- **0 arm_id validation issues, 0 event_count > denominator violations**

## Database deltas

| Sheet | Pre v1.3 | Post v1.3 | Δ |
|---|---:|---:|---:|
| `outcomes` | 3,604 | **3,901** | **+297** |
| `cohorts` | 181 | 181 | — |
| `studies` | 251 | 251 | — |
| `arms` | 525 | 525 | — |
| `outcomes_subgroup` | 126 | 126 | — |
| `rob` | 241 | 241 | — |

By design, only `outcomes` grew; arms/studies/cohorts/rob untouched.

### New outcome rows by category

| Outcome category | Pre v1.3 | Post v1.3 | Δ |
|---|---:|---:|---:|
| `relapse_related_mortality` (NEW in v1.3) | 0 | 162 | **+162** |
| `other_infection` (subset `BK_hemorrhagic_cystitis`) | ~66 | 201 | +135 |

Coverage among the 229 backfilled studies:
- RRM reported: 70 papers (31%)
- BK / HC reported: 56 papers (24%)
- Both: ~20 papers
- Neither: 126 papers (55%)

---

## Workflow

1. **v1.3 schema bump** (2026-05-30): added `relapse_related_mortality` as new `outcome_category` with subtype `RRM_any_cause_relapse`. Documented `BK_hemorrhagic_cystitis` (already in v1.2 vocab) as primary extraction target. Schema doc: `PTCy_MA_database_schema_v1.3.md`.
2. **Targeted-extraction spec**: smaller than blocks 1–9 (only 2 outcome categories, reuse existing arm_ids — no new arms/studies/cohorts/rob). Spec doc preserved in `outputs/BACKFILL_SPEC_v13_rrm_bk.md`.
3. **Pilot (10 papers)** validated the pattern: 7/10 RRM, 4/10 BK, 0 arm_id issues, 1 paper correctly emitted empty (Goldsmith CIBMTR).
4. **Blocks A–E (219 papers)** spawned as parallel subagents in 5 batches: 44 + 44 + 44 + 44 + 43 papers. Each subagent read one PDF and emitted a small JSON with new outcome rows attached to existing arm_ids only.
5. **Consolidation**: 229 JSONs merged into the v1.3 workbook. Pandas read-then-rewrite was required because openpyxl couldn't re-open the v1.2_post_block9-derived xlsx due to a missing drawing reference.

## Validation

- **0 arm_id validation issues** — every backfill row points to an existing integer `arm_id` in the workbook
- **0 event_count > denominator_n violations** in the new rows
- The 5 R2 violations carried over from Block 9 (Garcia-Cadenas 2021 graft failure, Lazana 2026 pooled CMV/engraftment/other_infection) remain documented in `extraction_notes` and are NOT in the new RRM/BK rows

## Files produced

- `PTCy_MA_database_schema_v1.3.md` — schema with RRM category and BK promotion
- `PTCy_MA_extraction_template_v1.3_fixed.xlsx` — **CURRENT working workbook** (251 studies / 525 arms / 3,901 outcomes / 14 RCTs / 162 RRM rows / 201 BK rows)
- `PTCy_MA_extraction_template_v1.3.xlsx` — older copy with drawing-XML issue; use the `_fixed` version
- `PTCy_MA_extraction_template_v1.2_post_block9.xlsx` — frozen post-Block-9 baseline (preserved)
- `PTCy_MA_extraction_template_v1.2.xlsx` — frozen 220-study baseline (preserved)
- `BACKFILL_v1.3_summary_2026-05-30.md` — this file

Backfill JSONs (`backfill_v13_paper_<N>.json` × 229) preserved in Claude scratch outputs.

---

## What this means for the Bayesian models

### New RRM model (Comparison 1 / 2 / 3)

This is a **brand-new outcome cell**, parallel structure to the existing NRM model. Most HCT papers report NRM and RRM as competing-risk pair (Gray's CIF), so the same M1 / M2_steroid formulas apply.

**Expected k for the RRM model** based on the 70 papers with RRM data:
- C1 RRM (PTCy vs CNI+MTX/MMF): ~30–40 paired studies (similar to OS / NRM)
- C2 RRM (PTCy vs ATG): ~15 paired studies
- C3 RRM (within-PTCy variants): ~5–8 paired studies

Together with NRM, this lets the manuscript **decompose the OS effect** into:
- "PTCy reduced OS deaths by X%; of that, Y% is from reduced NRM and Z% is from reduced RRM."

### Expanded BK model

C1 BK (PTCy vs CNI+MTX/MMF) likely now has k ≈ 25–35 paired studies (vs the original sparse k=0 in v1.2). The model is fittable for the first time.

The BK direction is biologically constrained — cyclophosphamide is itself a known HC precipitant — and the brms posterior will quantify by how much. Expect OR > 1 for BK with PTCy vs CNI.

### Update to `refit_block9.R`

You can extend the existing `refit_block9.R` by appending these to the `specs` list:

```r
list(slug="c1_rrm", cat="relapse_related_mortality", sub="RRM_any_cause_relapse",
     tp="D+365_1yr", fb=c("D+730_2yr","end_of_followup"), cmp=1, m2=TRUE),
list(slug="c2_rrm", cat="relapse_related_mortality", sub="RRM_any_cause_relapse",
     tp="D+365_1yr", fb=c("D+730_2yr","end_of_followup"), cmp=2, m2=FALSE),
list(slug="c3_rrm", cat="relapse_related_mortality", sub="RRM_any_cause_relapse",
     tp="D+365_1yr", fb=c("D+730_2yr","end_of_followup"), cmp=3, m2=FALSE),
list(slug="c1_bk",  cat="other_infection", sub="BK_hemorrhagic_cystitis",
     tp="D+100",     fb=c("D+180","D+365_1yr"),           cmp=1, m2=FALSE),
list(slug="c2_bk",  cat="other_infection", sub="BK_hemorrhagic_cystitis",
     tp="D+100",     fb=c("D+180","D+365_1yr"),           cmp=2, m2=FALSE)
```

(Don't forget to first re-export the CSVs from `PTCy_MA_extraction_template_v1.3_fixed.xlsx` into `02_extraction/`, replacing the post-Block-9 ones. Run `export_to_csv.R` after updating its `XLSX <- ...` to point at the v1.3 file.)

---

## Status

- ✅ v1.3 schema written
- ✅ 229 papers backfilled
- ✅ Consolidation done (297 new outcomes in v1.3 workbook)
- ✅ Validation passed
- ⏸ **Next:** export refreshed CSVs from v1.3 workbook + run `refit_block9.R` with the 5 new spec entries above to fit the RRM and BK brms models.
