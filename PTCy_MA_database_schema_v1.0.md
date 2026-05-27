# PTCy Meta-Analysis Extraction Database — Schema v1.0

**Project:** Bayesian meta-analysis of infection risk associated with post-transplant cyclophosphamide (PTCy)
**Schema author:** R. Lewis (UniPD) with Claude
**Schema version:** 1.0 (locked once piloted)
**Date:** 2026-05-26
**Source corpus:** 409 full-text publications in `Paperpile files/`

---

## 1. Design principles

1. **Relational, not flat.** Six normalized tables + a codebook. Each table answers one question and joins via integer keys. Avoids the duplicated-study-fields problem that plagues single-sheet extraction.
2. **Cohort identity is first-class and separate from publication identity.** The CIBMTR HaploCy/SibCy/SibCNI cohort appears in ≥7 papers reporting different outcomes — the database must let us aggregate by cohort while preserving the publication of record for each outcome.
3. **Long-format outcomes.** One row per `arm × outcome_category × outcome_subtype × timepoint`. This is the shape `brms` needs (`events | trials(n) ~ 0 + arm + (0 + arm | cohort_id)`) and avoids the combinatorial column explosion of wide outcome storage.
4. **Subgroup-stratified outcomes live in a separate table.** Whole-arm rollups stay in `outcomes`; within-arm stratified outcomes (e.g., CMV reactivation by donor type) go in `outcomes_subgroup` with `moderator_variable` + `moderator_value` columns. Cleaner joins, no ambiguous NAs.
5. **Every categorical field has a controlled vocabulary** documented in the `codebook` sheet and enforced by Excel data-validation dropdowns. Free text only for `*_notes`, `definition_text`, and `description` fields.
6. **Provenance and audit are tracked per row** — extractor, verifier, dates, data source (table vs. figure vs. text vs. KM-curve estimate), data-quality flag. The BMT director verifies 100% of extractions and discrepancies are logged.
7. **Missing vs not-reported is explicit.** Never leave a required cell blank without one of the controlled missingness codes (`NR` = not reported, `NA` = not applicable, `UNCL` = unclear/ambiguous in source, `PEND` = pending author contact).

---

## 2. Entity-relationship overview

```
cohorts (1) ────< (n) studies (1) ────< (n) arms (1) ────< (n) outcomes
                                                       └──< (n) outcomes_subgroup
                  studies (1) ────< (n) rob
```

- `cohorts.cohort_id` → `studies.cohort_id`
- `studies.study_id` → `arms.study_id`, `rob.study_id`
- `arms.arm_id` → `outcomes.arm_id`, `outcomes_subgroup.arm_id`
- `outcomes.outcome_id` and `outcomes_subgroup.outcome_id` are independent PKs (do not nest subgroup under outcome)

---

## 3. Table specifications

### 3.1 `cohorts` — unique patient populations

One row per unique patient cohort. The overlap rule operates here.

| Field | Type | Required | Vocabulary / Validation | Notes |
|---|---|---|---|---|
| `cohort_id` | int | Y | unique, auto-increment | PK. Use 1001, 1002, … for clarity vs other IDs. |
| `cohort_label` | text | Y | short snake_case, ≤40 char | e.g., `CIBMTR_HaploCy_SibCy_SibCNI`, `BMT_CTN_1703`, `Salas_Barcelona`, `Moffitt_Khimani_Ranspach`. |
| `cohort_description` | text | Y | free text | One-sentence definition. |
| `registry_or_source` | enum | Y | `CIBMTR`/`EBMT`/`JSHCT`/`KSBMT`/`national_registry`/`multicenter_collaboration`/`single_center`/`other` | |
| `enrollment_start_year` | int | Y | 2000–current; `UNCL` if not stated | |
| `enrollment_end_year` | int | Y | 2000–current; `UNCL` | |
| `total_unique_patients` | int | Y | ≥0; `UNCL` allowed | Most recent reported denominator for the cohort. |
| `primary_publication_study_id` | int | Y | FK to `studies` | The chosen primary per cohort-overlap rule. May differ by outcome — if so, see `primary_publication_overrides`. |
| `primary_publication_overrides` | text | N | JSON-like or `outcome:study_id` pairs | Used when different publications are primary for different outcomes (e.g., CIBMTR cohort: Goldsmith 2021 for CMV, Papanicolaou 2023 for IFI). |
| `overlap_notes` | text | N | free text | Document how overlap was resolved. |

### 3.2 `studies` — publications

One row per peer-reviewed full-text publication that survives screening.

| Field | Type | Required | Vocabulary / Validation | Notes |
|---|---|---|---|---|
| `study_id` | int | Y | unique, auto-increment | PK. Use 1–409 to mirror Paperpile. |
| `cohort_id` | int | Y | FK to `cohorts` | |
| `first_author` | text | Y | "Lastname FM" | |
| `pub_year` | int | Y | 2010–current | |
| `journal` | text | Y | | |
| `doi` | text | Y if available; `NR` allowed | | |
| `pmid` | text | N | | |
| `paperpile_filename` | text | Y | exact filename in Paperpile files/ | Enables `system.file()` retrieval. |
| `title` | text | Y | | |
| `country` | text | Y | ISO country name or `multinational` | |
| `region` | enum | Y | `EU`/`NA`/`Asia`/`SA`/`Oceania`/`Africa`/`multinational`/`other` | Moderator #9. |
| `study_design` | enum | Y | `RCT`/`prospective_cohort`/`retrospective_cohort`/`registry`/`case_control`/`single_arm_descriptive_excluded` | Drives RoB tool choice (RCT→RoB 2; rest→ROBINS-I). |
| `single_or_multicenter` | enum | Y | `single`/`multi`/`registry` | |
| `n_centers` | int | N | ≥1; `NR` | |
| `enrollment_start_year` | int | Y | | Study-specific (may differ from cohort if cohort spans multiple papers). |
| `enrollment_end_year` | int | Y | | |
| `era_category` | enum | Y | `pre_2018`/`post_2018`/`mixed` | Moderator #8 proxy. Computed from enrollment dates: median enrollment year ≥ 2018 → post; ≤ 2017 → pre; else mixed. |
| `follow_up_median_months` | num | N | `NR` allowed | |
| `follow_up_min_months` | num | N | `NR` | |
| `follow_up_max_months` | num | N | `NR` | |
| `primary_for_cohort` | enum | Y | `Y`/`N`/`partial` | `partial` = primary for some outcomes but not others; see `cohorts.primary_publication_overrides`. |
| `cohort_overlap_status` | enum | Y | `none`/`overlap_subset_of`/`overlap_superset_of`/`partial_overlap` | |
| `overlap_with_study_ids` | text | N | comma-separated study_ids | |
| `language` | enum | Y | `English`/`translation_obtained`/`untranslated_excluded` | |
| `full_text_obtainable` | enum | Y | `Y`/`N_excluded` | |
| `author_contact_attempted` | enum | Y | `Y`/`N`/`pending` | |
| `author_response_received` | enum | Y | `Y`/`N`/`pending`/`NA` | |
| `extractor_initials` | text | Y | | |
| `verifier_initials` | text | Y | | |
| `extraction_date` | date | Y | YYYY-MM-DD | |
| `verification_date` | date | Y | YYYY-MM-DD | |
| `extraction_notes` | text | N | free text | |

### 3.3 `arms` — treatment arms within studies

One row per arm. A two-arm comparative study yields two rows; a three-arm registry analysis yields three. Single-arm studies are excluded per PICO.

**Identification**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `arm_id` | int | Y | unique, auto-increment | PK |
| `study_id` | int | Y | FK | |
| `arm_label_in_paper` | text | Y | verbatim | e.g., "PTCy/Tac/MMF", "ATG/CsA/MTX". |
| `arm_role` | enum | Y | `PTCy_arm`/`comparator_arm` | |
| `comparison_1_eligible` | enum | Y | `Y`/`N` | Comparison 1: PTCy ± CNI/MMF vs CNI + MTX/MMF (no ATG, no TCD). |
| `comparison_2_eligible` | enum | Y | `Y`/`N` | Comparison 2: PTCy ± CNI/MMF vs ATG-based. |
| `comparison_3_eligible` | enum | Y | `Y`/`N` | Comparison 3: within-PTCy regimen variants. |

**Sample and demographics**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `n_patients` | int | Y | ≥20 per PICO | |
| `pct_male` | num | N | 0–100; `NR` | |
| `age_median_years` | num | N | `NR` | |
| `age_iqr_low` | num | N | `NR` | |
| `age_iqr_high` | num | N | `NR` | |
| `age_range_min` | num | N | `NR` | |
| `age_range_max` | num | N | `NR` | |
| `age_mean_years` | num | N | `NR` | If median not reported. |
| `age_sd_years` | num | N | `NR` | |

**Disease mix (percentages; sum ≤ 100, residual = other)**

`disease_aml_pct`, `disease_all_pct`, `disease_mds_pct`, `disease_mpn_pct`, `disease_cml_pct`, `disease_lymphoma_pct`, `disease_mm_pct`, `disease_cll_pct`, `disease_saa_pct`, `disease_other_pct`. Each `num` 0–100, `NR` allowed.

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `disease_risk_high_pct` | num | N | 0–100; `NR` | DRI or equivalent. |
| `disease_risk_intermediate_pct` | num | N | | |
| `disease_risk_low_pct` | num | N | | |
| `disease_risk_classifier_used` | enum | N | `DRI`/`EBMT_risk_score`/`refined_DRI`/`investigator_defined`/`NR` | |

**Donor type (Moderator #1)**

`donor_msd_pct`, `donor_mud_pct`, `donor_mmud_pct`, `donor_haplo_pct`, `donor_ucb_pct`. Each 0–100; `NR`.

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `donor_predominant` | enum | Y | `MSD`/`MUD`/`MMUD`/`haplo`/`UCB`/`mixed` | "mixed" if no single category ≥75%. |

**Graft source (Moderator #2)**

`graft_pbsc_pct`, `graft_bm_pct`, `graft_ucb_pct` (each 0–100; `NR`).

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `graft_predominant` | enum | Y | `PBSC`/`BM`/`UCB`/`mixed` | |

**Conditioning intensity (Moderator #3)**

`conditioning_mac_pct`, `conditioning_ric_pct`, `conditioning_nma_pct`. `conditioning_classification_scheme` enum: `CIBMTR`/`EBMT`/`investigator_defined`/`NR`.

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `conditioning_predominant` | enum | Y | `MAC`/`RIC`/`NMA`/`mixed` | |
| `tbi_used_pct` | num | N | 0–100; `NR` | |

**HLA match**

`hla_10_10_pct`, `hla_9_10_pct`, `hla_8_10_or_lower_pct`, `hla_haplo_pct`. (For UCB cohorts, allele-level HLA may not apply.)

**CMV serostatus (Moderator #7)**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `cmv_recipient_pos_pct` | num | N | 0–100; `NR` | Most common reporting format. |
| `cmv_donor_pos_pct` | num | N | | |
| `cmv_DposRpos_pct` | num | N | | When D/R combinations are reported. |
| `cmv_DposRneg_pct` | num | N | | |
| `cmv_DnegRpos_pct` | num | N | | High-risk stratum. |
| `cmv_DnegRneg_pct` | num | N | | |
| `cmv_serostatus_reporting` | enum | Y | `R_only`/`D_only`/`DR_combinations`/`NR` | |

**GVHD prophylaxis — PTCy detail**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `ptcy_used` | enum | Y | `Y`/`N` | |
| `ptcy_dose_mg_kg_per_dose` | num | N if `ptcy_used`=N | numeric; typical 25/40/50; `NR` | |
| `ptcy_n_doses` | int | N if `ptcy_used`=N | typical 1 or 2; `NR` | |
| `ptcy_days_post_transplant` | text | N | e.g., "+3,+4"; "+3,+5"; "NR" | |
| `ptcy_total_dose_mg_kg` | num | N if `ptcy_used`=N | computed where possible | |
| `ptcy_dose_category` | enum | Y if `ptcy_used`=Y | `standard_50x2`/`reduced_25x2`/`reduced_40x2`/`reduced_other`/`single_dose`/`other`/`NR` | Moderator #6. |
| `cni_used` | enum | Y | `Y`/`N` | |
| `cni_agent` | enum | N | `tacrolimus`/`cyclosporine`/`sirolimus_as_substitute`/`other`/`NR`/`NA` | |
| `cni_target_trough_ng_ml_range` | text | N | e.g., "5–15" | |
| `mmf_used` | enum | Y | `Y`/`N` | |
| `mmf_total_daily_dose_mg` | num | N | | |
| `mtx_used` | enum | Y | `Y`/`N` | |
| `mtx_schedule` | text | N | e.g., "+1,+3,+6,+11" | |
| `mtx_total_dose_mg_m2` | num | N | | |
| `sirolimus_used` | enum | Y | `Y`/`N` | |
| `abatacept_used` | enum | Y | `Y`/`N` | |
| `other_immunosuppressant_used` | enum | Y | `Y`/`N` | |
| `other_immunosuppressant_description` | text | N | | |

**ATG (Moderator #10)**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `atg_used` | enum | Y | `Y`/`N` | |
| `atg_agent` | enum | N | `rabbit_thymoglobulin`/`rabbit_grafalon_ATLG`/`horse_ATGAM`/`other`/`NR`/`NA` | |
| `atg_total_dose_mg_kg` | num | N | | |
| `atg_dose_category` | enum | Y if `atg_used`=Y | `low_le_4.5_rabbit`/`standard_4.5_to_10_rabbit`/`high_gt_10_rabbit_ATLG`/`horse`/`mixed`/`NR` | Per Moderator #10 in protocol §6. |
| `atg_timing` | enum | N | `pre_transplant`/`peri_transplant`/`post_transplant`/`NR` | |

**Supportive care (Moderators #4, #5)**

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `letermovir_use` | enum | Y | `none`/`select_high_risk`/`all_patients`/`NR`/`era_proxy_only` | Moderator #4. |
| `letermovir_era_proxy` | enum | Y | `pre_2018`/`post_2018`/`mixed_spans_era` | Computed from enrollment dates if not directly reported. |
| `antifungal_prophylaxis_agent` | enum | Y | `fluconazole`/`micafungin`/`voriconazole`/`posaconazole`/`isavuconazole`/`itraconazole`/`amphotericin`/`echinocandin_other`/`none`/`mixed`/`NR` | |
| `antifungal_mold_active` | enum | Y | `Y`/`N`/`mixed`/`NR` | Moderator #5. |
| `antifungal_duration_target` | text | N | e.g., "until D+75" | |
| `antibacterial_prophylaxis_agent` | enum | N | `fluoroquinolone`/`TMP_SMX_only`/`none`/`other`/`NR` | |
| `pjp_prophylaxis_agent` | enum | N | `TMP_SMX`/`atovaquone`/`pentamidine`/`dapsone`/`other`/`NR` | |
| `cmv_monitoring_method` | enum | N | `PCR_qPCR`/`pp65_antigenemia`/`mixed`/`NR` | |
| `cmv_monitoring_frequency_per_week` | num | N | typical 1 or 2; `NR` | |
| `cmv_preemptive_threshold` | text | N | e.g., ">500 IU/mL" | |

### 3.4 `outcomes` — whole-arm outcomes (the analytic spine)

One row per `arm × outcome_category × outcome_subtype × timepoint`. This is the table that feeds `brms`.

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `outcome_id` | int | Y | auto-increment | PK |
| `arm_id` | int | Y | FK | |
| `study_id` | int | Y | FK (denormalized for query speed) | |
| `cohort_id` | int | Y | FK (denormalized) | |
| `outcome_category` | enum | Y | `BSI`/`CMV`/`IFI_mold`/`IFI_yeast`/`IFI_any`/`infection_related_mortality`/`NRM`/`other_infection` | |
| `outcome_subtype` | enum | Y | see below | Defines the case definition. |
| `timepoint` | enum | Y | `D+30`/`D+100`/`D+180`/`D+365_1yr`/`D+730_2yr`/`end_of_followup`/`other` | |
| `timepoint_days_numeric` | int | Y | 30/100/180/365/… | Enables continuous time meta-regression. |
| `is_primary_timepoint` | enum | Y | `Y`/`N` | Per protocol §6 table. |
| `is_primary_definition` | enum | Y | `Y`/`N` | Per protocol §6. |
| `denominator_n` | int | Y | should match `arms.n_patients` unless attrition | |
| `event_count` | int | Y | ≥0; `NR` if proportion given without numerator | |
| `proportion_reported_pct` | num | N | 0–100; redundant if events+n known | Used to back-calculate events when only % given. |
| `cumulative_incidence_pct` | num | N | from KM or Gray's CIF | |
| `ci_lower_pct` | num | N | | |
| `ci_upper_pct` | num | N | | |
| `ci_method` | enum | N | `Kaplan_Meier`/`Gray_CIF`/`Aalen_Johansen`/`crude_proportion`/`Wilson`/`Clopper_Pearson`/`other`/`NR` | |
| `competing_risks_handled` | enum | Y | `Y_CIF`/`N_KM_or_crude`/`NR` | |
| `hr_value` | num | N | when reported | |
| `hr_ci_lower` | num | N | | |
| `hr_ci_upper` | num | N | | |
| `hr_comparator_arm_id` | int | N | FK to `arms` | Which arm is the HR against? |
| `hr_adjusted` | enum | N | `unadjusted`/`adjusted`/`NR` | |
| `incidence_rate_value` | num | N | for Poisson sub-model | |
| `incidence_rate_unit` | enum | N | `per_1000_pt_days`/`per_100_pt_years`/`per_1000_pt_years`/`other` | |
| `person_time_total` | num | N | for Poisson model | |
| `person_time_unit` | enum | N | `patient_days`/`patient_months`/`patient_years` | |
| `median_time_to_event_days` | num | N | | |
| `ascertainment_method` | enum | Y | `active_surveillance`/`routine_screening`/`clinical_only`/`mixed`/`NR` | |
| `screening_frequency_per_week` | num | N | | |
| `definition_text` | text | Y | verbatim from paper | Critical for sensitivity analyses (EORTC/MSG vs investigator-reported, etc.). |
| `data_source` | enum | Y | `table`/`figure_text`/`figure_KM_curve`/`narrative_text`/`author_provided`/`computed_from_other_fields` | |
| `data_quality_flag` | enum | Y | `direct`/`derived`/`estimated_from_figure`/`back_calculated`/`author_provided_unpublished` | |
| `extraction_notes` | text | N | | |

**`outcome_subtype` controlled vocabulary**

| Category | Allowed subtypes |
|---|---|
| `BSI` | `any_pathogen` *(primary)*, `gram_neg`, `gram_pos`, `MDR_gram_neg`, `Sepsis-3`, `CTCAE_grade_ge_3` *(sensitivity)* |
| `CMV` | `any_reactivation` *(primary)*, `clinically_significant_csCMV`, `CMV_end_organ_disease` *(both sensitivity)* |
| `IFI_mold` | `EORTC_MSG_proven_probable` *(primary)*, `EORTC_MSG_proven_only`, `investigator_reported`, `aspergillus_only`, `mucormycosis_only` |
| `IFI_yeast` | `EORTC_MSG_proven_probable` *(primary)*, `EORTC_MSG_proven_only`, `investigator_reported`, `candidemia_only` |
| `IFI_any` | `EORTC_MSG_proven_probable_combined`, `investigator_reported_any` |
| `infection_related_mortality` | `IRM_any_cause_infectious`, `IRM_bacterial`, `IRM_viral`, `IRM_fungal` |
| `NRM` | `NRM_overall` *(primary)* |
| `other_infection` | `EBV_reactivation`, `EBV_PTLD`, `HHV6_reactivation`, `BK_hemorrhagic_cystitis`, `adenovirus`, `respiratory_viral_LRTI`, `other` |

### 3.5 `outcomes_subgroup` — within-arm stratified outcomes

Same structure as `outcomes` plus the two stratifier columns. Used only when a paper reports an outcome separately by a moderator within an arm.

Adds:

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `moderator_variable` | enum | Y | `donor_type`/`graft_source`/`conditioning_intensity`/`letermovir_era`/`antifungal_class`/`ptcy_dose`/`cmv_serostatus_DR`/`enrollment_era`/`region`/`atg_dose_category` | One of the 10 protocol moderators. |
| `moderator_value` | text | Y | from each moderator's value set | e.g., for `donor_type`: `MSD`, `MUD`, `MMUD`, `haplo`, `UCB`. |
| `parent_outcome_id` | int | N | FK to `outcomes` | If a whole-arm rollup was also extracted, link them. |

### 3.6 `rob` — risk-of-bias assessment

One row per `study × reviewer`. Three rows per study (R.L., BMT director, consensus) is the expected pattern.

| Field | Type | Required | Vocabulary | Notes |
|---|---|---|---|---|
| `rob_id` | int | Y | auto-increment | PK |
| `study_id` | int | Y | FK | |
| `reviewer` | enum | Y | `RL`/`BMTD`/`consensus`/`third_arbitrator` | |
| `rob_tool` | enum | Y | `ROBINS-I`/`RoB2` | |
| `d1_confounding` (ROBINS-I) / `d1_randomization` (RoB 2) | enum | Y | `low`/`moderate`/`serious`/`critical`/`NI`/`some_concerns`/`high` | Tool-appropriate scale. |
| `d2_selection` (ROBINS-I) / `d2_deviations` (RoB 2) | enum | Y | | |
| `d3_intervention_classification` / `d3_missing` | enum | Y | | |
| `d4_deviations` / `d4_measurement` | enum | Y | | |
| `d5_missing_data` / `d5_reporting` | enum | Y | | |
| `d6_outcome_measurement` | enum | Y for ROBINS-I | | |
| `d7_reporting` | enum | Y for ROBINS-I | | |
| `overall_judgement` | enum | Y | `low`/`moderate`/`serious`/`critical`/`some_concerns`/`high` | |
| `justification_text` | text | Y | free text per domain rated worse than low | |
| `assessment_date` | date | Y | | |

### 3.7 `codebook` — controlled vocabularies + missingness codes

Reference sheet. Three columns: `variable_name`, `allowed_value`, `definition`. Populated upfront. Excel data-validation rules on the other sheets pull from named ranges on this sheet.

**Universal missingness codes (allowed in any text or numeric field unless required)**

| Code | Meaning | When to use |
|---|---|---|
| `NR` | Not reported | Paper does not state; could exist but was not published. |
| `NA` | Not applicable | Field is structurally inapplicable (e.g., `atg_dose_category` when `atg_used=N`). |
| `UNCL` | Unclear / ambiguous | Paper states something but the value is ambiguous, contradictory, or below extractor confidence. |
| `PEND` | Pending author contact | Will be filled in once author replies. |

---

## 4. Mapping to `brms` analytic datasets

For each primary comparison × outcome × timepoint, the analytic dataset built in R via joins is:

```r
analytic <-
  outcomes |>
  filter(outcome_category == "BSI",
         outcome_subtype == "any_pathogen",
         timepoint == "D+30") |>
  inner_join(arms, by = "arm_id") |>
  inner_join(studies, by = "study_id") |>
  inner_join(cohorts, by = "cohort_id") |>
  filter(comparison_1_eligible == "Y",
         primary_for_cohort %in% c("Y", "partial"))

mod <- brm(
  event_count | trials(denominator_n) ~ 0 + arm_role + (0 + arm_role | cohort_id),
  family = binomial("logit"),
  prior = c(prior(normal(0, 1.5), class = b),
            prior(normal(0, 0.5), class = sd, lb = 0)),
  data = analytic, cores = 4, iter = 4000
)
```

For meta-regression, add `+ donor_predominant + conditioning_predominant + letermovir_era_proxy + ...` to the fixed-effects formula. For sensitivity analyses, swap the `filter()` clauses.

For the Poisson sub-model (Khimani/Meyer-style rate papers), pull from `outcomes` where `incidence_rate_value` is non-NR:

```r
brm(event_count ~ 0 + arm_role + offset(log(person_time_total)) + (0 + arm_role | cohort_id),
    family = poisson, ...)
```

---

## 5. Workflow

1. **Extraction sequence per paper:** `studies` row first → `arms` rows → `outcomes` rows → `outcomes_subgroup` rows (if any) → `rob` rows. `cohorts` rows are added as new cohorts are encountered.
2. **Cohort assignment:** on encountering a paper that may overlap, search `cohorts.cohort_label` for matches before creating a new one. Document overlap in `cohort_overlap_status` and `overlap_with_study_ids`.
3. **Dual review:** R.L. extracts; BMT director verifies 100% against source PDF. Discrepancies logged in `extraction_notes` with resolution.
4. **Validation passes (run via R script after each batch):**
   - `event_count ≤ denominator_n` for every `outcomes` row
   - Disease percentages sum to ≤100 (residual = other) per arm
   - Donor / graft / conditioning percentages each sum to ≤100 per arm
   - Every `comparison_X_eligible=Y` arm has a comparator arm in the same study with matching `comparison_X_eligible=Y`
   - `primary_for_cohort=Y` is unique per `cohort × outcome` combination
   - Every `outcome_subtype` is allowed for its `outcome_category` per §3.4 table
5. **Export to CSV** at the end of each batch via the accompanying R script (`export_to_csv.R`) into `02_extraction/`.

---

## 6. Open questions for sign-off before locking schema v1.0

1. Confirm `primary_for_cohort` can be `partial` (different primaries for different outcomes) — this matches the CIBMTR cohort situation but adds query complexity. Acceptable?
2. Confirm we should **not** capture conference-abstract data even in a hidden sheet (per locked protocol — abstract-only studies are excluded entirely after the full-text pivot).
3. Confirm `outcomes_subgroup` rows are extracted **opportunistically** (when the paper happens to report them) rather than systematically — i.e., we don't go back to authors for stratified data.
4. Confirm we hand-curate `cohort_label` upfront for the known overlapping cohorts (CIBMTR HaploCy/SibCy/SibCNI, BMT CTN 1703, Salas/Barcelona, Moffitt Khimani/Ranspach, EBMT ALWP, Hamburg Massoud, Freiburg Meyer, Bordat MMUD) before extraction starts so they get stable IDs.

---

*Schema v1.0 — to be locked after 10-paper pilot.*
