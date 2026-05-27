# PTCy meta-analysis — project status summary

**Date:** 2026-05-26
**Phase reached:** End of Phase 3, beginning of Phase 4 (data extraction)
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director

---

## Where we are

The protocol (planning chat) and checklist have been authored. The search, screening, and full-text retrieval phases are complete — **409 full-text publications now sit in `Paperpile files/`** ready for extraction. The next milestone is dual-reviewer extraction into a structured database, followed by Bayesian analysis in R.

This session designed and built the extraction database that will hold the data for the analysis. **Current schema is v1.1**, which extends v1.0 with GVHD outcomes + IS-exposure covariates so the Bayesian model can disentangle the direct PTCy → infection effect from the indirect PTCy → GVHD reduction → less IS exposure → infection effect.

**Nothing has been extracted from the PDFs yet** — what's complete is the validated empty template and the analysis plan. Extraction begins with the 10-paper pilot once the v1.1 sign-off questions are answered.

---

## What was decided this session

Five design questions were put to the user and locked:

| # | Question | Decision |
|---|---|---|
| 1 | How to store subgroup-stratified outcomes? | **Separate `outcomes_subgroup` table** (cleaner joins; no ambiguous NAs in main `outcomes` table) |
| 2 | Template format? | **Single `.xlsx` workbook** with sheet-per-table + codebook, plus R export-to-CSV script |
| 3 | Which optional fields to include in `arms`? | **All four blocks** — full GVHD prophylaxis detail, CMV serostatus distribution, supportive care, and time-to-event metrics |
| 4 | Pilot strategy? | **10 papers spanning all three comparisons** (broader pilot to catch edge cases) |
| 5 | How to handle GVHD as a confounder/mediator for infection risk? | **Three-model mediation pattern (v1.1):** direct-effect model + GVHD-as-outcome model + GVHD-adjusted infection model with arm-level GVHD-CI and IS-exposure as centered covariates. Plus extraction of aGVHD/cGVHD/SR-GVHD/second-line-IS/OS/engraftment outcomes and three IS-exposure fields in `arms`. |

Plus one correction surfaced during pilot selection: the planning chat's reference to "Holtan 2022 (BMT CTN 1703)" is an attribution error. The actual primary publication is **Bolaños-Meade et al. NEJM 2023;388:2338-2348** (Holtan is senior author). The Bolaños-Meade 2023 paper is in the Paperpile folder; the pilot selection now uses it as the index publication for that cohort.

Three minor year corrections were also caught in the planning chat's "known included papers" list (worth propagating to the protocol):

- Papanicolaou is **2024**, not 2023
- Massoud is **2022**, not 2021
- Meyer is **2025**, not 2024

---

## What was built — current state (v1.1)

All files live in `/Users/russelllewis/Desktop/PTCY_analysis/`. The v1.0 pair is retained for audit trail.

### 1. `PTCy_MA_database_schema_v1.1.md` (~28 KB) — current

The formal database design. Six normalized tables — `cohorts`, `studies`, `arms`, `outcomes`, `outcomes_subgroup`, `rob` — plus a `codebook`. Each field specified by name, type, required/optional status, controlled vocabulary, and rationale. §4 documents the **three-model mediation pattern** that answers the protocol question about PTCy-direct vs GVHD-mediated infection risk.

**220 fields total** across the six data tables (cohorts 10, studies 32, **arms 93**, outcomes 34, outcomes_subgroup 37, rob 14). The arms table grew from 90 to 93 in v1.1 to hold per-arm IS-exposure summary (`systemic_steroid_for_gvhd_exposure_pct`, `steroid_exposure_duration_days_median`, `second_line_gvhd_therapy_exposure_pct`).

All **10 protocol moderators** + the **GVHD/IS-exposure mediator covariates** have an explicit home in the schema.

The 7 new `outcome_category` values from v1.1 (`aGVHD`, `cGVHD`, `steroid_refractory_aGVHD`, `steroid_refractory_cGVHD`, `second_line_GVHD_therapy_use`, `overall_mortality`, `engraftment_failure`) plus 15 new subtypes use the existing `outcomes` row shape — no new tables were needed, just vocabulary additions.

### 2. `PTCy_MA_extraction_template_v1.1.xlsx` (~32 KB) — current

The validated extraction workbook. 8 sheets (README + codebook + 6 data tables). Header row frozen at row 4 (rows 1–3 carry field name, required/optional flag, field notes). Tab colours group the tables visually.

**280 controlled-vocabulary entries** sit on the `codebook` sheet (up from 252 in v1.0; +28 for the GVHD/mortality/engraftment additions and GVHD-status stratifiers), with dropdown validation wired up across all categorical fields on the data sheets.

Opens cleanly with zero formula errors.

### 3. `export_to_csv.R` (8 KB) — unchanged

Companion script. Three jobs:

1. **Export.** Reads the workbook, emits one tidy CSV per data sheet into `02_extraction/`.
2. **Validate.** Runs validation checks on every batch — `events ≤ n`, denominator vs `arms.n_patients`, percentage-block sums ≤ 100, comparison-eligibility comparator presence. Failures saved to `.rds` for inspection. (v1.1's additional consistency checks — `SR-GVHD ≤ aGVHD II-IV`, steroid-exposure floor — are documented in the SKILL and can be added to the script if desired before pilot lock.)
3. **Analytic-dataset builder.** Exposes `build_analytic(category, subtype, timepoint, comparison)` to produce a `brms`-ready dataset on demand. Works identically for infection and GVHD outcomes.

### 4. `PTCy_MA_pilot_paper_selection.md` (~7 KB) — unchanged

10 papers to extract first, each chosen to stress-test a different schema feature: RCT with structured outcomes (Bolaños-Meade 2023 NEJM); CIBMTR registry overlap (Goldsmith 2021, Papanicolaou 2024); Salas single-centre with idiosyncratic definitions; Khimani/Meyer Poisson-style rate reporting; Bordat staged-reporting overlap; Shaffer within-arm subgroup stratification (donor type); Ara low-dose ATG variant. All 10 confirmed present in the corpus and all 10 report GVHD outcomes — so the v1.1 amendment can be tested on the same pilot set without re-selection.

### 5. `ptcy-ma-extraction.skill` (~6 KB) — v1.1

Portable Claude skill bundle. Install via the Cowork UI (a "Save skill" button appears when you open the file). Once installed, it auto-loads any time you mention the PTCy MA project, restoring the locked-protocol context, schema invariants (including the v1.1 GVHD outcomes + IS-exposure covariates), known overlapping cohort map, **per-paper extraction sequence with all categories to extract**, **nine validation rules** (six original + three v1.1-specific), and the **three-model mediation analysis pattern**.

### 6. `PROJECT_STATUS_summary.md` (this file)

### v1.0 files retained for audit trail

- `PTCy_MA_database_schema_v1.0.md`
- `PTCy_MA_extraction_template_v1.0.xlsx`

Do not extract into the v1.0 workbook — it lacks the GVHD/mortality/engraftment vocabulary and the three IS-exposure columns.

---

## Open items before extraction starts

### Sign-off questions in schema v1.1 §6 (five total) — LOCKED 2026-05-26

1. ~~Confirm `primary_for_cohort = partial`~~ — **YES, allowed.** Outcome-specific primary publication overrides accepted (e.g., CIBMTR cohort: Goldsmith 2021 primary for CMV, Papanicolaou 2024 primary for IFI, Singh 2022 primary for non-CMV herpesvirus).
2. ~~Confirm conference-abstract data is excluded entirely~~ — **YES, excluded entirely.** No hidden sheet.
3. ~~Confirm subgroup data is extracted *opportunistically*~~ — **YES, opportunistic only.** No author contact for missing stratifications.
4. ~~Confirm pre-curating `cohort_label`s upfront~~ — **NO, add as we go.** Cohorts created on first encounter of a member paper. *Extractor responsibility: cross-check each new study against the eight known overlapping clusters to keep `cohort_label` strings consistent.*
5. ~~**v1.1:** Confirm `aGVHD grade_II_IV` at D+100 is the canonical mediator~~ — **OVERRIDDEN: extract BOTH grade_II_IV AND grade_III_IV at D+100 per paper.** User selected `grade_III_IV` as preferred mediator (severe-only signal); extracting both gives the option to compare in post-pilot analysis. Mark `is_primary_timepoint = Y` on both grade rows for arms entering Comparison 1. Where a paper reports only one grade, the other is `NR`.

These decisions are session-final; if the pilot reveals problems with any of them, log as v1.2 amendments rather than re-opening.

### Protocol amendments to log

- Year corrections for Papanicolaou (2024 not 2023), Massoud (2022 not 2021), Meyer (2025 not 2024)
- Bolaños-Meade 2023 NEJM as BMT CTN 1703 primary (replace "Holtan 2022" wherever it appears)
- ATG dose stratification (Moderator #10) — still listed as "outstanding decision" in the checklist; needs accept/modify/reject from BMT director
- **v1.1:** GVHD outcomes + IS-exposure covariates added to extraction scope; three-model mediation analysis pattern added to analysis plan

### Operational

- Sign off on Excel-based dual-reviewer workflow (no REDCap)
- Identify the third-reviewer arbitrator (if R.L. + BMT director disagree >10% of time)
- Confirm extractor + verifier roles per Phase 4 checklist

---

## Next steps (in order)

1. **Review schema v1.1 + template v1.1.** Open `PTCy_MA_database_schema_v1.1.md` and `PTCy_MA_extraction_template_v1.1.xlsx`. Answer the five §6 sign-off questions. ~45 min.
2. **(Re)install the v1.1 skill bundle** (`ptcy-ma-extraction.skill`) so future sessions auto-load the updated context. If v1.0 was installed earlier, the install will replace it. ~1 min.
3. **Curate cohort_ids upfront** for the eight known overlapping cohorts (CIBMTR HaploCy/SibCy/SibCNI, BMT CTN 1703, Salas/Barcelona, Moffitt Khimani/Ranspach, EBMT ALWP, Hamburg Massoud, Freiburg Meyer, Bordat MMUD). Add rows to the `cohorts` sheet before any extraction begins. ~1 hr.
4. **Pilot 10 papers** per `PTCy_MA_pilot_paper_selection.md`, extracting **both infection and GVHD outcomes** plus the three IS-exposure fields where reported. This is the principal test of the v1.1 amendment — were the GVHD/IS-exposure fields extractable from real papers, or do we need v1.2 revisions? Time-target: 1.5–3 hrs per paper (slight uplift from v1.0 estimate to account for added fields). Total budget: ~25 hrs split between R.L. and BMT director.
5. **After pilot:** run `export_to_csv.R`, inspect validation output. Decide whether schema v1.1 can be locked or whether v1.2 amendments are needed.
6. **Lock schema, extract remaining 399 papers.** Phase 4 of the checklist (Weeks 10–16 in the existing schedule; may shift slightly with v1.1's expanded scope).
7. **Phase 5 — Bayesian analysis.** Frequentist sanity-check first via `metafor::rma()`, then for each comparison × infection outcome run the **three-model mediation pattern**: (a) direct-effect infection model, (b) GVHD-as-outcome model, (c) GVHD-adjusted infection model with arm-level GVHD-CI and IS-exposure as covariates. Posterior contrast `direct − adjusted` quantifies the meta-regression-attributable mediation. Plus meta-regression on protocol moderators, sensitivity analyses, `RoBMA` publication-bias assessment, GRADE.

---

## Decisions log (this session)

| Date | Decision | Rationale |
|---|---|---|
| 2026-05-26 | Six-table relational schema (vs flat single sheet or REDCap) | Long-format `outcomes` table feeds `brms` directly; cohort identity must be separable from publication identity for the overlap rule |
| 2026-05-26 | All four optional-field blocks included in `arms` (GVHD detail, CMV serostatus, supportive care, time-to-event) | Granular moderator resolution needed for Comparison 3 and Moderator #10; cost is template size, not extraction time |
| 2026-05-26 | 10-paper pilot, not 3-paper pilot | More edge-case coverage; protects against mid-corpus re-extraction |
| 2026-05-26 | Bolaños-Meade 2023 NEJM is the BMT CTN 1703 primary publication, not "Holtan 2022" | Verified via NEJM citation; file confirmed in Paperpile folder |

---

## Schema v1.1 amendment (later same day)

User flagged that GVHD outcomes (incidence + grade) and IS-treatment exposure must be in the database because they are causal mediators between PTCy and infection risk. v1.0 captured GVHD *prophylaxis* but not GVHD *outcomes*. Amendment locked.

### v1.1 changes

**New outcome_category values** (7): `aGVHD`, `cGVHD`, `steroid_refractory_aGVHD`, `steroid_refractory_cGVHD`, `second_line_GVHD_therapy_use`, `overall_mortality`, `engraftment_failure`.

**New outcome_subtype values** (15): aGVHD `grade_II_IV` (primary) / `grade_III_IV` / `grade_IV_only` / `any_grade`; cGVHD `moderate_severe_NIH` (primary) / `extensive_Seattle` / `any_NIH` / `limited_Seattle`; SR-GVHD `SR_any`; second-line therapy `any_second_line` / `ruxolitinib` / `ECP` / `MMF_addition` / `belumosudil` / `ibrutinib`; mortality `OS_event`; engraftment `primary_graft_failure` / `secondary_graft_failure`.

**New arms fields** (3): `systemic_steroid_for_gvhd_exposure_pct`, `steroid_exposure_duration_days_median`, `second_line_gvhd_therapy_exposure_pct`. `peak_steroid_dose_mg_kg_median` was proposed but rejected as too rarely reported.

**New moderator_variable values** (3): `agvhd_status`, `cgvhd_status`, `steroid_exposure_status` — enables within-arm subgroup extraction when papers stratify infections by GVHD status.

**New §4 in schema** documents the **three-model mediation pattern**:

1. Direct-effect infection model (v1.0 design)
2. GVHD-as-outcome model (descriptive — does PTCy reduce GVHD?)
3. GVHD-adjusted infection model (mediation — is the infection signal attenuated when arm-level GVHD-CI is held constant?)

Posterior contrast `direct − adjusted` quantifies the meta-regression-attributable mediation.

### v1.1 file deltas

| File | Before | After |
|---|---|---|
| Schema | `PTCy_MA_database_schema_v1.0.md` (23 KB) | `PTCy_MA_database_schema_v1.1.md` (28 KB). v1.0 retained for audit. |
| Template | `PTCy_MA_extraction_template_v1.0.xlsx` (90 arms fields, 252 vocab entries, 78 dropdowns) | `PTCy_MA_extraction_template_v1.1.xlsx` (93 arms fields, 280 vocab entries, more dropdowns). v1.0 retained for audit. |
| Skill | `ptcy-ma-extraction.skill` v1.0 (4.9 KB) | `ptcy-ma-extraction.skill` v1.1 (5.8 KB). Adds GVHD timepoints to locked invariants; rewrites analysis section as 3-model mediation pattern. |
| `export_to_csv.R` | unchanged — outcome_category and outcome_subtype are free-text in R, no code change needed |
| Pilot selection | unchanged — same 10 papers, all of which report GVHD as well as infections |

### Additional v1.1 sign-off question

5. Confirm `aGVHD grade_II_IV` at D+100 is the canonical mediator for GVHD-adjusted infection models. Alternative would be the more severe `grade_III_IV` (cleaner signal, fewer events) or `cGVHD moderate_severe_NIH` at 1 yr (better aligned with late-infection timepoints).

### Updated next steps

The order in §"Next steps" above is unchanged except:

- Step 1 now refers to v1.1 schema and v1.1 template.
- Step 3 (cohort_id curation) is unaffected.
- Step 4 (pilot 10 papers) should add GVHD outcomes to the extraction worklist for each paper — this is the principal test of the v1.1 amendment.
- Step 7 (Bayesian analysis) now runs the three-model mediation pattern per `comparison × infection_outcome × timepoint`, plus standalone GVHD-outcome models.
