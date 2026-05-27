# PTCy meta-analysis — extraction status snapshot

**Date:** 2026-05-26
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)
**Workbook:** `PTCy_MA_extraction_template_v1.2.xlsx`
**Schema:** v1.2 (`PTCy_MA_database_schema_v1.2.md`)

---

## TL;DR

- **310 of 409 papers attempted (76%)** across pilot + 6 blocks of 50.
- **163 studies extracted** into the v1.2 database (53% extraction rate sustained).
- **147 papers excluded** with structured reasons (PRISMA-trackable).
- **99 papers remain** (blocks 7 + 8 at 50 each, plus a few tail-end singletons).
- **All 9 validation rules pass** at the current snapshot. Workbook is in a clean state.

---

## Current database contents

| Sheet | Rows | What it holds |
|---|---|---|
| `cohorts` | **121** | Unique patient-population clusters |
| `studies` | **163** | Extracted publications |
| `arms` | **339** | Treatment arms with 93 fields each |
| `outcomes` | **2,249** | Whole-arm outcome rows (binomial-normal input) |
| `outcomes_subgroup` | **75** | Within-arm stratified outcomes |
| `rob` | **155** | R. Lewis risk-of-bias rows (BMTD verification pending) |

## Per-block breakdown

| Block | Range | Extracted | Excluded | Cumulative attempted |
|---|---|---|---|---|
| Pilot | 1–10 | 8 | 2 | 10 |
| Block 1 | 11–60 | 25 | 25 | 60 |
| Block 2 | 61–110 | 28 | 22 | 110 |
| Block 3 | 111–160 | 22 | 28 | 160 |
| Block 4 | 161–210 | 22 | 28 | 210 |
| Block 5 | 211–260 | 25 | 25 | 260 |
| Block 6 | 261–310 | 33 | 17 | 310 |
| **Total** | **1–310** | **163** | **147** | **310** |

## Comparison eligibility (cumulative)

| Comparison | Definition | Arms eligible |
|---|---|---|
| 1 | PTCy ± CNI/MMF vs CNI + MTX/MMF (no ATG, no TCD) | **223** |
| 2 | PTCy vs ATG-based | **81** |
| 3 | Within-PTCy regimen variants | **25** |

## RCTs in the database (8 total)

| study_id | Reference | Cohort | Comparison |
|---|---|---|---|
| 2 | Bolaños-Meade 2023, NEJM | BMT_CTN_1703 | 1 (PTCy vs Tac+MTX) |
| 12 | Abedin 2025, Blood Advances | BMT_CTN_1703 (≥70 yr subgroup) | 1 (sensitivity) |
| 72 | Bolaños-Meade 2019, Lancet Haematology | BMT_CTN_1203 (phase 2, 4-arm) | 1 |
| 79 | Brissot 2024, Blood Cancer Journal | EBMT ALWP | 2 |
| 80 | Broers 2022, Blood Advances | HOVON-96 | 1 |
| 105 | Curtis 2025, NEJM | ALLG BM12-CAST | 1 |
| 140 | Fuchs 2021, Blood | BMT_CTN_1101 (Haplo+PTCy vs UCB) | 3 (within-PTCy via donor-source contrast) |
| 226 | Luznik 2022, JCO | BMT_CTN_1301 (CNI-free) | 1 |

Note: Moiseev 2016 (study 7) was originally classified as RCT but a subagent reclassified to `prospective_cohort` — pending BMTD verification (see "Known anomalies" below).

## Outcome category coverage (cumulative)

```
aGVHD                          554   ← well-covered
overall_mortality              341
cGVHD                          337
NRM                            305
engraftment_failure            194
CMV                            165
other_infection                123
infection_related_mortality     66
BSI                             66
IFI_any                         33
IFI_mold                        27
steroid_refractory_aGVHD        16
second_line_GVHD_therapy_use    11
IFI_yeast                       11
```

## v1.2 back-calculation policy efficacy

`systemic_steroid_for_gvhd_exposure_pct` populated in **254/339 arms (75%)**.

Pilot started at 18% direct reporting. After v1.2 back-calc from aGVHD II–IV CI%, coverage rose to 59% (block 1) → 68% (block 2) → 74–76% (blocks 3–6).

`second_line_gvhd_therapy_exposure_pct` remains low (~3–6%). Strong v1.3 deprecation candidate.

`steroid_exposure_duration_days_median` correctly empty across all arms (deprecated in v1.2).

---

## What remains (99 papers)

### Block 7 (50 papers, study_ids 311–360) — alphabetical Pa–Re range

To be selected from the corpus after filtering out blocks 1–6 already-assigned papers. Expected mix:
- Reference papers from planning chat's "known included": probably Pinto 2025 (Salas cohort), Pinto/Pinana variants, possibly more Salas papers
- EBMT registry analyses (Paviglianiti and similar)
- Single-center papers from R-S authors

### Block 8 (49 papers, study_ids 361–409) — alphabetical Re–Z range

To be selected. Notable anchors expected:
- **Multiple Salas papers** (per skill bundle — Salas Barcelona cohort 1003)
- **Singh 2020, Singh 2022, Taplitz 2020** (CIBMTR HaploCy cohort 1001)
- Tang 2023 systematic review (excluded)
- Wieduwilt and similar registry papers
- Last-letter (S, T, V, W, Y, Z) single-center papers

### Expected exclusions in blocks 7–8

Based on blocks 1–6 averages (~50% exclusion rate), expect ~50 papers extracted, ~49 excluded.

Common exclusion buckets seen so far:
- Conference abstracts (~57% of exclusions; ~85 papers total to date)
- Narrative reviews (~10%)
- Reference systematic reviews/MAs (~7%)
- Duplicates (~7%)
- Pre-PTCy era or non-eligible populations (~3% each)

---

## Known anomalies / open items for BMTD verification

These are flagged in the workbook and should be reviewed before locking:

1. **Moiseev 2016 (study 7)** — classified as `prospective_cohort`; planning chat expected RCT. Re-check.
2. **Outcome 225 (Alousi 2015 Phase II, arm 33)** — denominator 49 > arm.n_patients 37; pre-matching vs matched-subset issue. Flagged in extraction_notes.
3. **Lim CX 2019 (study 218, excluded)** — PDF file mislabeled; actually contains Enrich 2018 CCR5 study. Excluded as abstract anyway but file is wrong.
4. **Park S.-S. 2021 (study 303, excluded)** — title implies AML CR1 but actual paper is SAA with ATG-only (no PTCy). Excluded correctly.
5. **Pavlov RCT cluster** — cohorts 1007 (Moiseev 2016 MUD/BMT) and 1099 (Moiseev 2017 MRD/BMT) may be related but represent different protocols (NCT02294552 vs NCT02627573).
6. **Cohort merger candidates for BMTD review:**
   - GETH/Spanish multicenter cluster: 1019, 1020, 1049, 1050, 1051
   - Princess Margaret Desai cluster: 1042, 1043, 1044
   - MDACC Mehta cluster: 1089, 1090, 1091
   - JSTCT/Japanese registry: 1064, 1070, 1103, 1108, 1109, 1113
7. **EBMT ALWP cluster** (cohort 1024) now has 15+ member publications — works as designed under the cohort-overlap rule.

---

## To resume the project (in next session or for handoff)

### Immediate next steps

1. **Run block 7** (study_ids 311–360):
   - Refresh `cohort_overlap_map.json` (121 cohorts currently)
   - Pick papers via the standard script (alphabetical, skip pilot)
   - Spawn 50 parallel subagents with the v1.2 `EXTRACTION_SPEC.md`
   - Retry any rate-limit/session-limit casualties
   - Consolidate, validate, fix, write summary

2. **Run block 8** (study_ids 361–409, ~49 papers):
   - Same workflow as block 7

### After all 409 papers attempted

3. **BMTD second-pass verification** of all extracted papers — Phase 4 dual-reviewer step from the original protocol checklist.
4. **Lock schema** (decide v1.2 → v1.3 amendments based on full corpus):
   - Add `arms.extraction_notes` field for structured audit trail
   - Add `arms.systemic_steroid_pct_source` enum (`direct_report | back_calculated_from_aGVHD_II_IV | NR`)
   - Deprecate `second_line_gvhd_therapy_exposure_pct` (low reporting rate)
   - Resolve cohort-merger candidates (GETH, PMH Desai, MDACC Mehta, JSTCT)
5. **Run `export_to_csv.R`** to emit tidy CSVs for the Bayesian analysis.
6. **Phase 5 — Bayesian analysis** per the skill bundle's three-model mediation pattern:
   - Direct-effect infection model (binomial-normal `brms`)
   - GVHD-as-outcome model
   - GVHD-adjusted infection model with arm-level GVHD-CI as centered covariate
   - Plus standalone Poisson sub-model for rate-only papers (Khimani 2021, Meyer 2025)
   - Sensitivity analyses, RoBMA publication-bias, GRADE

### Key files needed to resume

All in `/Users/russelllewis/Desktop/PTCY_analysis/`:
- `PTCy_MA_extraction_template_v1.2.xlsx` — the database
- `PTCy_MA_database_schema_v1.2.md` — schema spec
- `ptcy-ma-extraction.skill` — installable skill bundle for context auto-load
- `PROJECT_STATUS_summary.md` — historical session log
- Block summaries `BLOCK_1_extraction_summary_2026-05-26.md` … `BLOCK_6_extraction_summary_2026-05-26.md`
- `STATUS.md` (this file) — current snapshot

In scratch outputs (preserved for audit; can be regenerated):
- `EXTRACTION_SPEC.md` — the v1.2 spec subagents follow
- `cohort_overlap_map.json` — refreshed before each block
- `extraction_paper_<N>.json` — per-paper raw JSON for audit
- `excluded_papers_block_<N>.json` — PRISMA exclusion tracking

### Workflow infrastructure that's working

- **Parallel subagent extraction (50 per batch)** — well-tested. Allow for ~10–20% session-limit casualties requiring single-batch retry.
- **Cohort-overlap rule** — empirically validated across 6 blocks. New EBMT/CIBMTR/JSTCT papers route to existing cohorts cleanly.
- **v1.2 back-calc policy** — 75% steroid % coverage sustained.
- **Validation routine** — same 9 rules every block; typically catches 5–15 R4 (comparison_X_eligible) labeling issues and 0–3 R6 (outcome_subtype) typos per block.

### Cost estimate for remaining blocks

Each block of 50 papers consumed roughly:
- ~3–4 million tokens of compute (50 subagents × 60–100K tokens each)
- ~20–30 minutes wall-clock (with parallel execution + occasional session-limit retries)
- ~5–10 fixes applied during consolidation

Two blocks remain to complete the corpus.

---

## Validation status

As of this snapshot, the workbook passes all 9 validation rules from schema v1.2 §5:

1. ✅ `event_count ≤ denominator_n` for all 2,249 outcome rows
2. ⚠ One warning carrying over from pilot: outcome 225 (Alousi 2015) denominator mismatch — documented for BMTD review
3. ✅ Disease/donor/graft/conditioning percentage blocks sum to ≤100
4. ✅ Every `comparison_X_eligible=Y` arm has a matched comparator
5. ✅ `primary_for_cohort=Y` unique per cohort × outcome (with `partial` overrides as designed)
6. ✅ `outcome_subtype` consistent with `outcome_category` per schema §3.4
7. ✅ `event_count(steroid_refractory_aGVHD) ≤ event_count(aGVHD grade_II_IV)` per arm
8. ✅ `event_count(second_line_GVHD_therapy_use) ≤ event_count(steroid_refractory_aGVHD)` sanity check
9. ✅ `systemic_steroid_for_gvhd_exposure_pct ≥ aGVHD II-IV CI%` floor (with back-calc exemption)

---

## Decision log for handoff

Locked decisions across all sessions to date:

| Decision | Source | Status |
|---|---|---|
| `primary_for_cohort = partial` allowed for outcome-specific primary publications | Session 1 sign-off Q1 | Locked |
| Conference abstracts excluded entirely (no hidden sheet) | Session 1 sign-off Q2 | Locked |
| Subgroup outcomes extracted opportunistically (no author contact) | Session 1 sign-off Q3 | Locked |
| Cohort labels added as papers are encountered (not pre-curated) | Session 1 sign-off Q4 | Locked |
| Extract BOTH aGVHD II–IV AND III–IV at D+100 as mediator candidates | Session 1 sign-off Q5 (override) | Locked |
| Drop `steroid_exposure_duration_days_median` (0% reporting) | v1.2 bump | Locked |
| Back-calculate `systemic_steroid_for_gvhd_exposure_pct` from aGVHD II–IV CI% when not directly reported | v1.2 bump | Locked |
| Alphabetical extraction order, 50 papers per block | User direction | Locked |
| 7 RCTs identified (plus possibly Moiseev 2016 = 8 pending verification) | Block tally | Locked |
