# PTCy Meta-Analysis Extraction Database — Schema v1.1

**Project:** Bayesian meta-analysis of infection risk associated with post-transplant cyclophosphamide (PTCy)
**Schema author:** R. Lewis (UniPD) with Claude
**Schema version:** 1.1 (extends v1.0 with GVHD outcomes + IS-exposure covariates)
**Date:** 2026-05-26
**Supersedes:** `PTCy_MA_database_schema_v1.0.md` (retained for audit trail)

---

## 0. Changes from v1.0

The v1.0 design captured GVHD *prophylaxis* in `arms` but not GVHD *outcomes*. Because GVHD treatment (corticosteroids, second-line immunosuppression) drives downstream infection risk, GVHD outcomes must be extracted alongside infections so the Bayesian model can disentangle:

- The **direct effect** of PTCy on infection risk (immune-reconstitution delay from cyclophosphamide).
- The **indirect effect** mediated through GVHD reduction (PTCy → fewer GVHD events → less steroid/IS exposure → fewer infections).
- The **confounding** that arises because non-PTCy arms with high GVHD rates accumulate more steroid exposure.

Amendments since v1.0:

| Amendment | Where | Rationale |
|---|---|---|
| 7 new `outcome_category` values: `aGVHD`, `cGVHD`, `steroid_refractory_aGVHD`, `steroid_refractory_cGVHD`, `second_line_GVHD_therapy_use`, `overall_mortality`, `engraftment_failure` | `outcomes` and `outcomes_subgroup` | GVHD as outcome (descriptive) AND as covariate (mediation) — locked at user request |
| New `outcome_subtype` values for each new category | `outcomes`, `outcomes_subgroup` | Standardized case definitions (MAGIC/Mount Sinai for aGVHD; NIH 2014 for cGVHD; Seattle criteria for legacy reporting) |
| 3 new fields on `arms`: `systemic_steroid_for_gvhd_exposure_pct`, `steroid_exposure_duration_days_median`, `second_line_gvhd_therapy_exposure_pct` | `arms` | Per-arm IS-exposure summary for meta-regression of infection outcomes |
| 3 new `moderator_variable` values: `agvhd_status`, `cgvhd_status`, `steroid_exposure_status` | `outcomes_subgroup` | When a paper opportunistically reports infections stratified by GVHD/steroid status within an arm |
| `peak_steroid_dose_mg_kg_median` was proposed but **not adopted** — too rarely reported per user judgement. Can re-add in v1.2 if pilot finds it routinely available |
| Mediation analysis plan added to §4 | §4 | Formalizes how arm-level GVHD-CI is used as a covariate in the infection-risk `brms` model |

Everything else from v1.0 (six tables, design principles, validation rules, missingness codes, the eight known overlapping cohorts) is unchanged. v1.0 readers can skip to §3.4, §3.5, §4 to see only what changed.

---

## 1. Design principles (unchanged from v1.0)

1. Relational, not flat — six normalized tables + codebook, joined via integer keys.
2. Cohort identity is first-class and separate from publication identity.
3. Long-format `outcomes` table feeds `brms` directly.
4. Subgroup-stratified outcomes live in `outcomes_subgroup`.
5. Controlled vocabularies enforced via Excel data-validation dropdowns.
6. Per-row provenance: extractor, verifier, dates, data source, data-quality flag.
7. Missingness is explicit: `NR` / `NA` / `UNCL` / `PEND`.

---

## 2. Entity-relationship overview (unchanged)

```
cohorts (1) ────< (n) studies (1) ────< (n) arms (1) ────< (n) outcomes
                                                       └──< (n) outcomes_subgroup
                  studies (1) ────< (n) rob
```

---

## 3. Table specifications

### 3.1 `cohorts` — unchanged from v1.0
### 3.2 `studies` — unchanged from v1.0

### 3.3 `arms` — three new fields appended

The 90 fields from v1.0 are unchanged. Three new fields added at the end of the GVHD-prophylaxis / supportive-care block:

| New field | Type | Required | Vocabulary / Validation | Notes |
|---|---|---|---|---|
| `systemic_steroid_for_gvhd_exposure_pct` | num | N | 0–100; `NR` | Proportion of arm who received systemic steroids for GVHD treatment (not prophylaxis). Often reported directly; otherwise back-calculate from aGVHD grade II+ incidence as a lower bound. |
| `steroid_exposure_duration_days_median` | num | N | `NR` | Median duration of systemic steroid exposure for GVHD treatment, in days. Rarely reported — expect mostly NR. |
| `second_line_gvhd_therapy_exposure_pct` | num | N | 0–100; `NR` | Proportion of arm who received any second-line IS for GVHD (ruxolitinib, ECP, MMF addition, belumosudil, ibrutinib, other). |

`peak_steroid_dose_mg_kg_median` was deliberately **not added** — too rarely reported per user judgement during v1.1 design.

### 3.4 `outcomes` — schema unchanged; `outcome_category` and `outcome_subtype` vocabularies extended

The 34 fields from v1.0 are unchanged. Two new categories of values are admissible in the existing `outcome_category` and `outcome_subtype` enums:

**Extended `outcome_category` vocabulary (v1.0 values in italics; v1.1 additions in bold):**

*`BSI`*, *`CMV`*, *`IFI_mold`*, *`IFI_yeast`*, *`IFI_any`*, *`infection_related_mortality`*, *`NRM`*, *`other_infection`*, **`aGVHD`**, **`cGVHD`**, **`steroid_refractory_aGVHD`**, **`steroid_refractory_cGVHD`**, **`second_line_GVHD_therapy_use`**, **`overall_mortality`**, **`engraftment_failure`**.

**Extended `outcome_subtype` allowed mapping per category:**

| Category | Allowed subtypes | Primary / sensitivity |
|---|---|---|
| `BSI` *(v1.0)* | `any_pathogen`, `gram_neg`, `gram_pos`, `MDR_gram_neg`, `Sepsis-3`, `CTCAE_grade_ge_3` | `any_pathogen` primary D+30 |
| `CMV` *(v1.0)* | `any_reactivation`, `clinically_significant_csCMV`, `CMV_end_organ_disease` | `any_reactivation` primary D+100 |
| `IFI_mold` *(v1.0)* | `EORTC_MSG_proven_probable`, `EORTC_MSG_proven_only`, `investigator_reported`, `aspergillus_only`, `mucormycosis_only` | EORTC/MSG p+p primary D+180 |
| `IFI_yeast` *(v1.0)* | `EORTC_MSG_proven_probable`, `EORTC_MSG_proven_only`, `investigator_reported`, `candidemia_only` | EORTC/MSG p+p primary D+180 |
| `IFI_any` *(v1.0)* | `EORTC_MSG_proven_probable_combined`, `investigator_reported_any` | sensitivity only |
| `infection_related_mortality` *(v1.0)* | `IRM_any_cause_infectious`, `IRM_bacterial`, `IRM_viral`, `IRM_fungal` | `IRM_any_cause_infectious` primary 1yr |
| `NRM` *(v1.0)* | `NRM_overall` | primary 1yr |
| `other_infection` *(v1.0)* | `EBV_reactivation`, `EBV_PTLD`, `HHV6_reactivation`, `BK_hemorrhagic_cystitis`, `adenovirus`, `respiratory_viral_LRTI`, `other` | descriptive |
| **`aGVHD`** *(v1.1)* | `grade_II_IV` *(primary)*, `grade_III_IV` *(severe)*, `grade_IV_only`, `any_grade` | `grade_II_IV` primary D+100; `grade_III_IV` sensitivity D+100; secondary at D+180 |
| **`cGVHD`** *(v1.1)* | `moderate_severe_NIH` *(primary)*, `extensive_Seattle`, `any_NIH`, `limited_Seattle` | `moderate_severe_NIH` primary 1 yr; sensitivity 2 yr; record classifier (`NIH_2014` vs `Seattle`) in `definition_text` |
| **`steroid_refractory_aGVHD`** *(v1.1)* | `any` | D+180; reports usually % of grade II–IV who became steroid-refractory |
| **`steroid_refractory_cGVHD`** *(v1.1)* | `any` | 1 yr |
| **`second_line_GVHD_therapy_use`** *(v1.1)* | `any_second_line` *(primary)*, `ruxolitinib`, `ECP`, `MMF_addition`, `belumosudil`, `ibrutinib`, `other` | 1 yr (proportion ever requiring; not at-timepoint prevalence) |
| **`overall_mortality`** *(v1.1)* | `OS_event` | 1 yr primary; 2 yr sensitivity |
| **`engraftment_failure`** *(v1.1)* | `primary_graft_failure`, `secondary_graft_failure` | D+30 (primary), D+100 (secondary). Note: changes the denominator for late infections. |

For GVHD outcomes, the existing `outcomes` fields cover everything we need:

- `denominator_n` = transplanted patients at risk
- `event_count` = number with the GVHD event
- `cumulative_incidence_pct` + `ci_lower_pct` + `ci_upper_pct` for KM/Gray estimates
- `ci_method` = `Gray_CIF` is the standard (competing risk = death/relapse)
- `competing_risks_handled` should be `Y_CIF` for almost all modern GVHD reporting
- `definition_text` = verbatim grading system (`MAGIC`, `Mount_Sinai`, `Glucksberg`, `IBMTR`, `NIH_2014`, `Seattle`)

### 3.5 `outcomes_subgroup` — `moderator_variable` vocabulary extended

The 37-field schema is unchanged. Three new values added to the `moderator_variable` enum so that infections stratified by GVHD/steroid status can be extracted opportunistically:

**Extended `moderator_variable` vocabulary (v1.0 italics; v1.1 additions bold):**

*donor_type*, *graft_source*, *conditioning_intensity*, *letermovir_era*, *antifungal_class*, *ptcy_dose*, *cmv_serostatus_DR*, *enrollment_era*, *region*, *atg_dose_category*, **`agvhd_status`** (e.g., values: `aGVHD_II_IV_yes` / `no`), **`cgvhd_status`** (values: `cGVHD_mod_severe_yes` / `no`), **`steroid_exposure_status`** (values: `received_systemic_steroids` / `no_systemic_steroids`).

### 3.6 `rob` — unchanged from v1.0
### 3.7 `codebook` — extended with v1.1 vocabulary additions

---

## 4. Mapping to `brms` analytic datasets — mediation analysis plan

### 4.1 Direct-effect models (v1.0 design, unchanged)

For each primary comparison × infection outcome × primary timepoint, the unadjusted Bayesian model:

```r
analytic <- build_analytic("BSI", "any_pathogen", "D+30", comparison = 1)

mod_direct <- brm(
  event_count | trials(denominator_n) ~ 0 + arm_role +
    (0 + arm_role | cohort_id),
  family = binomial("logit"),
  prior = c(prior(normal(0, 1.5), class = b),
            prior(normal(0, 0.5), class = sd, lb = 0)),
  data = analytic, cores = 4, iter = 4000
)
```

### 4.2 GVHD-outcome models (new in v1.1, descriptive)

Same `brms` shape, applied to GVHD outcomes. Lets us report "does PTCy reduce GVHD risk?" as a primary finding rather than an assumed mechanism:

```r
# aGVHD grade II-IV by D+100, Comparison 1
ag <- build_analytic("aGVHD", "grade_II_IV", "D+100", comparison = 1)
mod_agvhd <- brm(
  event_count | trials(denominator_n) ~ 0 + arm_role +
    (0 + arm_role | cohort_id),
  family = binomial("logit"),
  prior = c(prior(normal(0, 1.5), class = b),
            prior(normal(0, 0.5), class = sd, lb = 0)),
  data = ag, cores = 4, iter = 4000
)

# cGVHD moderate-severe NIH 2014 at 1 year, Comparison 1
cg <- build_analytic("cGVHD", "moderate_severe_NIH", "D+365_1yr",
                     comparison = 1)
mod_cgvhd <- brm(... data = cg, ...)
```

### 4.3 GVHD-adjusted infection models (new in v1.1, mediation/confounding)

The core question of this section. For each infection outcome × comparison, we re-fit the model adjusting for the arm-level proportion who developed grade II–IV aGVHD by D+100 (the principal mediator) and the proportion exposed to systemic steroids for GVHD:

```r
# Build a per-arm summary of GVHD and steroid exposure
arm_gvhd_summary <- tabs$outcomes |>
  filter(outcome_category == "aGVHD",
         outcome_subtype  == "grade_II_IV",
         timepoint == "D+100") |>
  mutate(agvhd_ii_iv_pct = 100 * event_count / denominator_n) |>
  select(arm_id, agvhd_ii_iv_pct)

dat_adj <- analytic |>
  left_join(arm_gvhd_summary, by = "arm_id") |>
  left_join(tabs$arms |>
              select(arm_id,
                     systemic_steroid_for_gvhd_exposure_pct,
                     second_line_gvhd_therapy_exposure_pct),
            by = "arm_id") |>
  mutate(across(c(agvhd_ii_iv_pct,
                  systemic_steroid_for_gvhd_exposure_pct,
                  second_line_gvhd_therapy_exposure_pct),
                ~ suppressWarnings(as.numeric(.x))),
         agvhd_centered = scale(agvhd_ii_iv_pct, scale = FALSE)[, 1],
         steroid_centered = scale(systemic_steroid_for_gvhd_exposure_pct,
                                  scale = FALSE)[, 1])

mod_adjusted <- brm(
  event_count | trials(denominator_n) ~ 0 + arm_role +
    agvhd_centered + steroid_centered +
    (0 + arm_role | cohort_id),
  family = binomial("logit"),
  prior = c(prior(normal(0, 1.5), class = b),
            prior(normal(0, 0.5), class = sd, lb = 0)),
  data = dat_adj, cores = 4, iter = 4000
)
```

The arm-level GVHD-CI is centered before entering as a covariate so that the `arm_role` posterior is interpretable at the corpus average GVHD rate. This is meta-regression at the aggregate level — it does not recover patient-level mediation (we'd need IPD for that) but it does answer the protocol question: "is the PTCy → infection effect attenuated when we hold per-arm GVHD rate constant?"

Report side-by-side:

- `mod_direct` posterior log-OR for PTCy vs comparator (total effect)
- `mod_adjusted` posterior log-OR for PTCy vs comparator (direct effect, holding GVHD constant)
- Posterior log-OR contrast `direct - adjusted` (the meta-regression-attributable mediation)
- `mod_agvhd` posterior log-OR for aGVHD (the upstream link)

### 4.4 GVHD-stratified sensitivity analyses

When papers report infections stratified by GVHD status within an arm (`outcomes_subgroup` rows with `moderator_variable = agvhd_status`), pool them in a separate model conditioning on GVHD status. This is the strongest within-study evidence and avoids the ecological-fallacy risk of arm-level meta-regression.

---

## 5. Workflow — unchanged from v1.0

Per-paper extraction sequence: `studies` → `arms` → `outcomes` (including new GVHD/OS/engraftment outcomes) → `outcomes_subgroup` → `rob`. Validation passes per v1.0 still apply, plus the natural sanity check that `event_count(steroid_refractory_aGVHD) ≤ event_count(aGVHD grade_II_IV)` for a given arm.

---

## 6. Open questions for sign-off — unchanged from v1.0

Plus one new v1.1-specific question:

5. Confirm `aGVHD grade_II_IV` at D+100 is the canonical mediator for the GVHD-adjusted infection models. Alternative would be the more severe `grade_III_IV` (cleaner clinical signal but fewer events) or `cGVHD moderate_severe_NIH` at 1 yr (better aligned with late-infection timepoints).

---

*Schema v1.1 — to be locked after 10-paper pilot.*
