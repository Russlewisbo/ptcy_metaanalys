# Appendix S12: Cohort Overlap Map

*Generated: 2026-08-11 from `02_extraction/studies.csv` (n = 251) and `02_extraction/cohorts.csv` (n = 181)*

## Purpose

Multiple publications frequently report on the same patient population (registry
analyses, staged reports, outcome-specific companion papers). Each study is assigned
a `cohort_id`; the `primary_for_cohort` flag designates which publication represents
that cohort in pooled analyses, so that patients are not counted more than once.
This appendix documents the cohort structure and audits whether the mechanism worked.

## S12.1 Cohort structure

The 251 studies map to 186 cohort groups. 161 cohorts contain a single study; the
remaining 25 multi-study cohorts account for 90 studies (36% of the corpus).

|Cohort |Label                                         |Source                    | Studies| Unique patients| n flagged Y|
|:------|:---------------------------------------------|:-------------------------|-------:|---------------:|-----------:|
|1024   |EBMT_ALWP                                     |EBMT                      |      31|             479|           0|
|1001   |CIBMTR_HaploCy_SibCy_SibCNI                   |CIBMTR                    |       6|            2765|           0|
|1009   |ABMTRR_older_haplo_AMLMDS                     |national_registry         |       4|              44|           1|
|1003   |Salas_Barcelona                               |single_center             |       3|             330|           0|
|1008   |CIBMTR_MUD_MMUD_Shaffer                       |CIBMTR                    |       3|           10025|           1|
|1013   |PrincessMargaret_Toronto_Michelis             |single_center             |       3|             159|           1|
|1023   |Barkhordar_Tehran_single_center               |single_center             |       3|             248|           1|
|1047   |PALG_Polish_registry                          |multicenter_collaboration |       3|             145|           0|
|1002   |BMT_CTN_1703                                  |multicenter_collaboration |       2|             431|           1|
|1004   |Moffitt_Khimani_Ranspach                      |single_center             |       2|             583|           1|
|1007   |Pavlov_StPetersburg_RCT                       |single_center             |       2|             211|           1|
|1016   |DRST_German_registry                          |national_registry         |       2|            7537|           1|
|1020   |GETH_TC_Spanish_multicenter                   |multicenter_collaboration |       2|             229|           1|
|1022   |Mayo_Rochester_Baranwal                       |single_center             |       2|             500|           1|
|1036   |SanRaffaele_Milan_MAP_PTCy                    |single_center             |       2|             473|           1|
|1038   |Chorao_Portuguese_single_center               |single_center             |       2|             366|           1|
|1042   |PMH_CIBMTR_MUD_acute_leukemia_FtoM            |multicenter_collaboration |       2|             861|           1|
|1064   |JDCHCT_TRUMP2_UCBT_vs_PTCyHaplo               |national_registry         |       2|            7499|           2|
|1068   |Shanghai_General_older_myeloid_lowATGPTCy     |single_center             |       2|             127|           1|
|1070   |JSTCT_TRUMP_ALL_PTCyHaplo_UCB                 |JSHCT                     |       2|            1999|           2|
|1086   |Hamburg_Massoud_single_center                 |single_center             |       2|             599|           1|
|1092   |CIBMTR_ALL_Wieduwilt_dataset                  |CIBMTR                    |       2|            1286|           2|
|1127   |SantPau_Barcelona_Redondo_HLAmatched          |single_center             |       2|             226|           1|
|1138   |Ankara_3center_MMUD_PTCy_vs_MRD               |multicenter_collaboration |       2|              90|           2|
|1153   |PekingU_Soochow_Nanfang_MD_CRD_haplo_ATG_PTCy |multicenter_collaboration |       2|             239|           1|

Member-level detail (one row per study, with `primary_for_cohort` and
`overlap_with_study_ids`) is in `Table_S12a_cohort_overlap_map.csv`.

## S12.2 Audit of the `primary_for_cohort` flag

Schema v1.0 §5 requires `primary_for_cohort = Y` to be unique per cohort. It is not.
14 cohorts deviate: 10 have no `Y` publication at all, and 4 have two.

|Cohort                          |Label                                  | Studies|  Y| partial|  N| missing|
|:-------------------------------|:--------------------------------------|-------:|--:|-------:|--:|-------:|
|1024                            |EBMT_ALWP                              |      31|  0|      30|  1|       0|
|1001                            |CIBMTR_HaploCy_SibCy_SibCNI            |       6|  0|       5|  1|       0|
|1003                            |Salas_Barcelona                        |       3|  0|       3|  0|       0|
|1047                            |PALG_Polish_registry                   |       3|  0|       3|  0|       0|
|1064                            |JDCHCT_TRUMP2_UCBT_vs_PTCyHaplo        |       2|  2|       0|  0|       0|
|1070                            |JSTCT_TRUMP_ALL_PTCyHaplo_UCB          |       2|  2|       0|  0|       0|
|1092                            |CIBMTR_ALL_Wieduwilt_dataset           |       2|  2|       0|  0|       0|
|1138                            |Ankara_3center_MMUD_PTCy_vs_MRD        |       2|  2|       0|  0|       0|
|1018                            |Aydin_single_center                    |       1|  0|       1|  0|       0|
|1033                            |Miami_Sylvester_Camargo                |       1|  0|       1|  0|       0|
|1119                            |PrincessMargaret_Toronto_older_alloHCT |       1|  0|       1|  0|       0|
|Chorao_Portuguese_single_center |NA                                     |       1|  0|       1|  0|       0|
|NEW_Balletto_2024               |NA                                     |       1|  0|       0|  0|       1|
|NEW_Bansal_2021                 |NA                                     |       1|  0|       0|  0|       1|

Two studies have a missing flag entirely (Balletto E 2024, study 46; Bansal R 2021,
study 47). Both also carry provisional cohort IDs that were never resolved.

### Dangling cohort references

5 studies reference a `cohort_id` that has no row in `cohorts.csv`:

| Study|First author | Year|cohort_id                       |primary_for_cohort |Overlap status      |
|-----:|:------------|----:|:-------------------------------|:------------------|:-------------------|
|    46|Balletto E   | 2024|NEW_Balletto_2024               |NA                 |none                |
|    47|Bansal R     | 2021|NEW_Bansal_2021                 |NA                 |none                |
|    75|Bordat J     | 2026|1006                            |Y                  |overlap_superset_of |
|   101|Chorao       | 2026|Chorao_Portuguese_single_center |partial            |partial_overlap     |
|   360|Sijs-Szabo A | 2023|NEW_SijsSzabo_2023              |Y                  |none                |

Three retain provisional `NEW_*` labels from extraction, one retains a descriptive
placeholder, and cohort `1006` is numeric but absent from `cohorts.csv`. Note also
that `cohort_id` is stored as text in `studies.csv` and as a number in `cohorts.csv`,
which is what allowed the provisional labels to survive validation.

## S12.3 Consequence: same-cohort double counting in fitted models

Analytic datasets are built with `filter(primary_for_cohort %in% c("Y", "partial"))`
(`refit_block9.R`, `export_to_csv.R`). Because `partial` is retained and the filter is
not outcome-aware, several studies drawn from one patient population can enter the
same model as if they were independent.

This occurs in 9 of 29 analytic datasets:

|Dataset                |Cohort |Label                           | Studies contributing|
|:----------------------|:------|:-------------------------------|--------------------:|
|data_c1_os.csv         |1024   |EBMT_ALWP                       |                    5|
|data_c1_rrm.csv        |1024   |EBMT_ALWP                       |                    4|
|data_c1_irm.csv        |1024   |EBMT_ALWP                       |                    3|
|data_c1_irm.csv        |1002   |BMT_CTN_1703                    |                    2|
|data_c1_os.csv         |1003   |Salas_Barcelona                 |                    2|
|data_c1_rrm.csv        |1003   |Salas_Barcelona                 |                    2|
|data_c1_rrm.csv        |1023   |Barkhordar_Tehran_single_center |                    2|
|data_c2_agvhd.csv      |1047   |PALG_Polish_registry            |                    2|
|data_c2_cmv.csv        |1047   |PALG_Polish_registry            |                    2|
|data_c2_os.csv         |1047   |PALG_Polish_registry            |                    2|
|data_c2_sens_agvhd.csv |1047   |PALG_Polish_registry            |                    2|
|data_c2_sens_cmv.csv   |1047   |PALG_Polish_registry            |                    2|
|data_c2_sens_os.csv    |1047   |PALG_Polish_registry            |                    2|

The primary C1 overall-survival model (k = 40) draws five of its studies from the
single EBMT ALWP cohort (1024). Because the random intercept is indexed by
`study_id`, these correlated observations are treated as independent studies, which
overstates the precision of the pooled estimate. This is unresolved.

## S12.4 Scope of remaining overlap adjudication

116 studies carry `cohort_overlap_status = partial_overlap`, spread across 71 cohorts.
However 54 of these are the sole study in their cohort, so there is no second
publication in the corpus to adjudicate against — the flag records suspected overlap
with literature outside the corpus. The substantive workload is the remaining 62
studies, which sit in 17 multi-study cohorts.

Full listing in `Table_S12b_partial_overlap_studies.csv`, sorted by cohort size.

## Files

| File | Content |
|---|---|
| `Table_S12a_cohort_overlap_map.csv` | 90 studies in 25 multi-study cohorts |
| `Table_S12b_partial_overlap_studies.csv` | 116 `partial_overlap` studies by cohort |
| `Table_S12c_EBMT_ALWP_nesting.csv` | Donor strata / arm sizes for the 5 EBMT ALWP OS publications |
| `03_models/cohort_overrides.csv` | Reviewable override registry (cohort x outcome -> study) |
| `build_analytic_outcome_aware.R` | Outcome-aware deduplication module |
| `03_models/dedup_sensitivity/` | Three C1 OS refits + comparison table |


## S12.5 Is cohort 1024 one patient population?

The five EBMT ALWP publications contributing to the C1 overall-survival model were
compared on donor stratum, disease, and enrollment window. All five are 100% AML.

|Study          |Role       |Arm                                |    n|Donor |Enrollment |
|:--------------|:----------|:----------------------------------|----:|:-----|:----------|
|Baron F 2024   |comparator |dCBT (double-unit umbilical cor... |  209|UCB   |2013-2021  |
|Baron F 2024   |PTCy       |UD 9/10 (PTCy)                     |  270|MMUD  |2013-2021  |
|Dholaria 2021  |comparator |CBT (single or double cord bloo... |  902|UCB   |2010-2019  |
|Dholaria 2021  |PTCy       |MMUD with PTCy (9/10 single-all... |  280|MMUD  |2010-2019  |
|Nagler A 2022  |comparator |CSA/MTX                            | 1202|MSD   |2010-2019  |
|Nagler A 2022  |PTCy       |PTCy                               |  118|MSD   |2010-2019  |
|Nagler A 2024  |comparator |ATG/CSA or TAC/MTX                 | 5648|MUD   |2010-2020  |
|Nagler A 2024  |PTCy       |PTCy/CSA or TAC/MMF                |  402|MUD   |2010-2020  |
|Ruggeri A 2022 |comparator |dUCBT                              |  165|UCB   |2013-2018  |
|Ruggeri A 2022 |PTCy       |Haplo-PTCY                         |  544|haplo |2013-2018  |

The cohort record itself describes 1024 as a registry umbrella: *"Different papers
cover non-overlapping or partially overlapping donor strata (MMUD, MSD, MUD, UCB,
haplo)"*. The data bear that out only partially:

- **PTCy arms are largely distinguishable.** Nagler 2022 is MSD, Ruggeri 2022 is
  haploidentical, Nagler 2024 is a mixed-donor extraction, and Baron 2024 and
  Dholaria 2021 are both 9/10 MMUD.
- **Baron 2024 and Dholaria 2021 are near-duplicates on the PTCy side** (MMUD, AML,
  n = 270 vs 280, overlapping years). These almost certainly share patients.
- **Comparator arms overlap across papers.** Three of the five use umbilical-cord
  comparators drawn from the same registry and era (209, 902, and 165 patients).
  Cord-blood controls are therefore likely reused across publications.
- **Nagler 2024 (n = 6050) is a mixed-donor extraction spanning MSD, MUD, and MMUD**,
  so it plausibly contains patients also reported in the stratum-specific papers.

`total_unique_patients = 479` for this cohort is simply Baron 2024's sample size and
should not be relied on.

Conclusion: cohort 1024 is neither one patient pool nor five independent studies.
Blanket one-publication-per-cohort deduplication would discard a 6050-patient
analysis; retaining all five double counts cord-blood controls and the MMUD pair.

## S12.6 Sensitivity of the C1 overall-survival estimate to deduplication

M1 was refitted under three deduplication rules (identical priors, 4 chains x 4000
iterations, adapt_delta 0.95; all max R-hat <= 1.01):

- **A** as published: all 5 EBMT ALWP and both Salas publications retained
- **B** strict one publication per cohort (cohort-designated primary, else largest N)
- **C** donor-strata-aware: drop Baron 2024 (duplicate MMUD stratum) and Nagler 2024
  (mixed extraction nesting within the others); retain MSD, haplo, and one MMUD paper

|Set                             |  k|OR [95% CrI]     | CrI width|   tau| P(OR<1)|
|:-------------------------------|--:|:----------------|---------:|-----:|-------:|
|A: as-is (all 5 EBMT + 2 Salas) | 40|0.79 [0.73-0.85] |     0.127| 0.606|  1.0000|
|B: strict one-per-cohort        | 35|0.85 [0.78-0.94] |     0.162| 0.656|  0.9995|
|C: donor-strata-aware           | 37|0.81 [0.74-0.89] |     0.143| 0.638|  1.0000|

The direction and significance of the survival benefit are unchanged (P(OR<1) = 100%
in all three). The point estimate is not: it attenuates from 0.79 to 0.85 under strict
deduplication, and the credible interval widens by 13-28%. The published 0.79 is the
most optimistic of the three defensible analyses.

Notably, the strict-deduplication estimate (0.85) is close to the steroid-adjusted M2
estimate reported in the manuscript (0.86), so part of what was interpreted as
GVHD-mediated confounding may instead be duplicate-patient weighting.

Artifacts: `03_models/dedup_sensitivity/` (three brmsfit objects, both alternative
datasets, and `c1_os_dedup_comparison.csv`).

## S12.7 Outcome-aware dataset builder

`build_analytic_outcome_aware.R` adds a resolution step so that a cohort contributes
at most one publication per outcome. Selections come from a reviewable registry,
`03_models/cohort_overrides.csv` (columns: cohort_id, outcome_key, study_id, status,
basis), where `outcome_key = "*"` is the cohort default and `status` is
confirmed / proposed / unresolved. Rows marked unresolved are never applied.

The `primary_publication_overrides` field could not be used directly: of 38 cohorts
where it is populated, 30 contain only the placeholder `NR` and just one uses the
machine-readable `outcome:study_id` format (cohort 1001, 3 entries). The remaining
entries are prose. `parse_inline_overrides()` extracts the machine-readable entries
and reports the 5 prose-only cohorts that still require hand-encoding.

Applied to the 29 existing datasets with `strategy = "override"`, the module
deduplicates 8 of the 9 affected datasets and declines to resolve one:

|Dataset                |Outcome key | k before| k after| Cohorts deduplicated| Unresolved|
|:----------------------|:-----------|--------:|-------:|--------------------:|----------:|
|data_c1_irm.csv        |irm         |       16|      13|                    2|          0|
|data_c1_os.csv         |os          |       40|      35|                    2|          0|
|data_c1_rrm.csv        |rrm         |       38|      34|                    2|          1|
|data_c2_agvhd.csv      |agvhd       |        9|       8|                    1|          0|
|data_c2_cmv.csv        |cmv         |       13|      12|                    1|          0|
|data_c2_os.csv         |os          |       10|       9|                    1|          0|
|data_c2_sens_agvhd.csv |sens_agvhd  |       14|      13|                    1|          0|
|data_c2_sens_cmv.csv   |sens_cmv    |       22|      21|                    1|          0|
|data_c2_sens_os.csv    |sens_os     |       21|      20|                    1|          0|

The unresolved case is cohort 1023 in `data_c1_rrm.csv`: the designated primary
(study 49) is absent from that dataset, which instead contains studies 50 and 51,
two subset papers of identical size (n = 118). The module retains both and warns
rather than choosing arbitrarily.

### Additional defects found while building this

1. `data_c1_irm.csv` contains Abedin 2025 (study 12), which is flagged
   `primary_for_cohort = "N"`. The documented filter keeps only `Y` and `partial`,
   so this dataset appears to have been built with `require_primary_for_cohort = FALSE`.
2. `data_c1_rrm.csv` uses Barkhordar studies 50 and 51 but not the designated
   primary (49).
3. Cohort 1003 has at least three publications (9, 335, 338) and no study flagged `Y`.

## S12.8 Attempted donor-stratum split of cohort 1024

Section S12.5 showed that cohort 1024 behaves as a registry umbrella rather than a
single patient population, and recommended splitting it into donor-stratum sub-cohorts
so that a strata-aware analysis (Set C) could be justified. That split was attempted on
2026-08-11 and **could not be completed**. The evidence is in
`03_models/cohort_1024_subcohorts_PROPOSED.csv`.

Assigning each of the 31 publications a donor stratum from its arm-level data gives:

| Donor stratum | Publications | Cleanly assignable |
|---|---|---|
| haplo | 9 | yes |
| MUD | 6 | yes |
| MMUD | 3 | yes |
| MSD | 2 | yes |
| haplo+MUD | 3 | no |
| MMUD+UCB | 2 | no |
| haplo+MSD | 2 | no |
| haplo+MMUD, haplo+MMUD+MUD, haplo+MMUD+MSD+MUD, haplo+UCB | 1 each | no |

**20 of 31 publications sit in a single donor stratum; 11 span two or more.** A
multi-stratum publication cannot be placed in a disjoint sub-cohort: a haplo+MUD paper
shares patients with both the haplo and the MUD sub-cohort by construction. Enrollment
windows also overlap almost completely across strata (2005-2022). Splitting would
therefore produce sub-cohorts that are not mutually exclusive, replacing one visible
double-counting problem with a less visible one.

The failure is decisive for the outcome it was meant to fix. Of the five publications
contributing to the C1 overall-survival model, only two are cleanly assignable:

| Study | Publication | Donor strata | Sub-cohort |
|---|---|---|---|
| 287 | Nagler 2022 | MSD | `1024_MSD` |
| 281 | Nagler 2024 | MUD | `1024_MUD` |
| 118 | Dholaria 2021 | MMUD + UCB | unassignable |
| 52 | Baron 2024 | MMUD + UCB | unassignable |
| 325 | Ruggeri 2022 | haplo + UCB | unassignable |

The three unassignable publications are precisely the three that created the problem in
the first place: each carries an umbilical-cord comparator arm drawn from the same
registry and era, so their control patients are shared regardless of how their PTCy arms
are labelled. A donor-stratum split addresses the PTCy side and leaves the comparator
side untouched.

**Consequence: Set C is not enabled, and Set B remains the adopted analysis.** Set C as
fitted earlier (k = 37, OR 0.81 [0.75-0.89]) retains two publications with overlapping
cord-blood control arms and should be treated as an exploratory sensitivity analysis,
not as a defensible primary analysis.

Resolving this properly requires information the extraction database does not contain -
patient-level or at least centre-and-date-level detail sufficient to establish whether
the cord-blood control arms overlap, which in practice means contacting the EBMT ALWP.
Until then, one publication per cohort per outcome (Set B) is the conservative choice.

Note also that `02_extraction/*.csv` is exported from the Excel workbook by
`export_to_csv.R`; the proposed mapping is deliberately kept as a separate file rather
than written into `cohorts.csv`, which would be overwritten on the next export and would
desynchronise the CSVs from the workbook.

## Outstanding

1. Adjudicate cohort 1024: split the EBMT ALWP umbrella into donor-stratum cohorts,
   or accept the strata-aware selection (Set C) and document cord-blood control reuse.
2. Decide which of Set A / B / C is the primary C1 OS analysis. The published estimate
   (0.79) corresponds to Set A, which double counts.
3. Resolve cohort 1023 in RRM (studies 50 vs 51, identical n) - the only case the
   outcome-aware builder refuses to decide.
4. Rebuild `data_c1_irm.csv` with `require_primary_for_cohort = TRUE`; it currently
   contains a study flagged `N`.
5. Hand-encode the 5 prose-only `primary_publication_overrides` cohorts into the registry.
6. Resolve the 5 dangling cohort references and the 2 missing `primary_for_cohort` values.
7. Decide a primary publication for the 10 cohorts with no `Y`, and resolve the 4 with two `Y`.
8. Once selections are fixed, refit the remaining 8 affected models (RRM, IRM, and the
   C2 OS / aGVHD / CMV family) and update Table 2, GRADE, and the manuscript text.

