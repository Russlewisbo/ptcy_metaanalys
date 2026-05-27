# Pilot paper selection for extraction template v1.0

10 papers spanning all three primary comparisons, all RoB tools, and the major reporting styles you'll encounter in the corpus. Pilot these first to find template gaps before extracting the full 409.

## Selection logic

The pilot must surface every reporting pattern the schema needs to handle:

1. RCT with structured outcome reporting (RoB 2)
2. Multicenter registry with cohort-overlap implications (ROBINS-I)
3. Single-center retrospective with idiosyncratic definitions
4. Paper reporting **incidence rates per 1000 patient-days** (Poisson sub-model path)
5. Paper reporting **stratified subgroup data within an arm** (populates `outcomes_subgroup`)
6. Paper covering the ATG-dose moderator variants (low/standard/high)
7. Paper covering the within-PTCy regimen variants (Comparison #3)
8. Paper with **EORTC/MSG vs investigator-reported IFI** parallel reporting (sensitivity split)
9. Paper from a known overlapping cohort (CIBMTR HaploCy/SibCy/SibCNI)
10. Paper that uses Gray's CIF with competing risks

## Recommended pilot set

| # | Paperpile filename | Comparison(s) | Why this paper | Patterns it stress-tests |
|---|---|---|---|---|
| 1 | `Moiseev IS et al. 2016 - Graft-versus-Host Disease Prophylaxis in Unrelated Donor [MUD] Bone Marrow Transplantation - Calcineurin Inhibitors, Methotrexate, vs Post-Transplantation Cyclophosphamide, Tacrolimus, and Mycophenolate Mofetil.pdf` | C1 (PTCy vs CNI+MTX) | RCT comparator; clean Comparison 1 | RoB 2 tool, formal trial outcome definitions |
| 2 | `Bolaños-Meade et al. 2023 - Post-Transplantation Cyclophosphamide-Based Graft-versus-Host Disease Prophylaxis.pdf` | C1 (BMT CTN 1703) | **Primary publication** of BMT CTN 1703 — the index RCT for Comparison 1 (NEJM 2023;388:2338-2348). Holtan is senior author / protocol chair | RCT (RoB 2); cohort_id shared with Holtan 2023 PRO paper and Abedin 2024/2025 age-subgroup papers — first test of the cohort-overlap rule |
| 3 | `Goldsmith et al. 2021 - Posttransplant Cyclophosphamide Is Associated with Increased Cytomegalovirus Infection - A CIBMTR Analysis.pdf` | C1, C2 | CIBMTR HaploCy/SibCy/SibCNI cohort — the index publication for CMV in that cohort | Cohort overlap (>=7 papers same cohort); registry RoB; primary_publication_overrides field |
| 4 | `Papanicolaou GA et al. 2024 - Incidence and Impact of Fungal Infections in Patients Receiving Post-Transplant Cyclophosphamide After Haploidentical Hematopoietic Cell Transplantation - A CIBMTR Analysis.pdf` | C1, C2 | Same CIBMTR cohort, different outcome (IFI). Tests outcome-specific primary publication |
| 5 | `Salas MQ et al. 2022 - Bacterial Bloodstream Infections in Patients Undergoing Allogeneic Hematopoietic Cell Transplantation With Post-Transplantation Cyclophosphamide.pdf` | C1 | Single-center retrospective with idiosyncratic BSI definition; one of 6+ Salas papers on the same cohort | Free-text definition extraction; cohort overlap resolution |
| 6 | `Khimani F et al. 2021 - Increased Infections and Delayed CD4(+) T Cell Reconstitution... Compared to Conventional GVHD Prophylaxis in Allogeneic Transplantation.pdf` | C1 | Reports BSI as episodes per 1000 patient-days | Poisson sub-model: `incidence_rate_value`, `person_time_total`, units |
| 7 | `Meyer T et al. 2025 - Immunological reconstitution and infections after... PTCy, ATLG and non-ATLG based GvHD prophylaxis.pdf` | C1, C2 | Single-center with both ATLG (high-dose rabbit) and PTCy arms; rate-based reporting; mold-active prophylaxis era | Comparison 2 with `atg_dose_category = high_gt_10_rabbit_ATLG`; Poisson model; mold-active prophylaxis moderator |
| 8 | `Bordat J. et al. 2024 - Ptcy Versus High Dose of ATG in HLA-Mismatched Unrelated Stem Cell Transplantation for Hematological Malignancies.pdf` | C2 | Direct PTCy vs high-dose ATG MMUD comparison; same cohort overlap with Bordat 2026 | Cohort overlap (Bordat 2024 vs Bordat 2026 staged reporting) |
| 9 | `Shaffer et al. 2024 - Post-Transplant Cyclophosphamide–Based GVHD Prophylaxis... MUD vs MMUD.pdf` | C2 | CIBMTR MUD/MMUD analysis; tests donor-type subgroup stratification within arms | Populates `outcomes_subgroup` with `moderator_variable = donor_type` |
| 10 | `Ara T. et al. 2023 - Low-Dose ATG Has the Same Risk of CMV Reactivation Post-allo HSCT As Ptcy, but Letermovir Is Effective in Preventing CMV Reactivation.pdf` | C2 | Tests low-dose ATG category and letermovir moderator interaction | `atg_dose_category = low_le_4.5_rabbit`; letermovir use stratification |

Bonus depth (if pilot reveals gaps): add `Massoud R et al. 2022 - Comparison of immune reconstitution between antifungal prophylaxis groups...` for additional Hamburg-cohort cross-check, and one Tang 2020 Chinese registry for region=Asia coverage.

## What this pilot will tell us

After extracting these 10 papers, freeze schema v1.0 if all of the following hold:

- Every datum from each paper has a home in the schema (no orphan fields)
- Every controlled vocabulary covers what the papers actually report (no "other"-heavy fields)
- The `outcomes` vs `outcomes_subgroup` split holds up — papers don't mix rollup + subgroup in confusing ways
- Validation rules in `export_to_csv.R` pass (or surface real data issues, not template issues)
- Time-to-extract per paper stabilizes around 60–90 minutes for typical retrospective; 2–3 hours for registry papers with many subgroups

If not, amend the schema (add fields, expand vocabularies, split or merge tables), bump to v1.1, log the change in the protocol amendment table, and re-pilot the affected papers.

## BMT CTN 1703 cohort — publication map

For the `cohorts` table, the BMT CTN 1703 cohort cluster looks like:

| `study_id` | First author / year | Role in cohort | Notes for `primary_for_cohort` |
|---|---|---|---|
| (TBD) | Bolaños-Meade 2023 NEJM | **Primary publication** | `Y` for all primary outcomes (GRFS, NRM, secondary infections if reported with denominators + timepoints) |
| (TBD) | Holtan 2023 PRO/QoL | Patient-reported outcomes follow-up | `N` — out of scope for infection outcomes; retain for reference checking only |
| (TBD) | Abedin 2024 ≥70-yr post-hoc | Age subgroup analysis | `N` for primary; retained for **age-stratified sensitivity** if we add age as Moderator #11 |
| (TBD) | Abedin 2025 ≥70-yr update | Updated age subgroup | `N`; supersedes Abedin 2024 within the sensitivity stratum |

All four share one `cohort_id` (suggest `cohort_label = BMT_CTN_1703`). The planning chat's "Holtan 2022" reference was an author attribution error — Holtan is the senior author on Bolaños-Meade 2023 and first author on the 2023 PRO paper. Schema and pilot updated accordingly.

## Other "must retrieve" papers — confirmation status

- ✅ Bolaños-Meade 2023 NEJM (BMT CTN 1703 primary) — present
- ✅ Moiseev 2016 — present (multiple Moiseev papers; see filename above)
- ✅ Tang 2023 (reference MA) — present as `Tang L et al. 2023`
- ✅ Papanicolaou 2024 (CIBMTR IFI) — present (the planning chat said 2023; paper is actually 2024)
- ✅ Salas 2023 (Barcelona primary) — present as `Salas M.Q. et al. 2023 - Impact of Post-Transplant Cyclophosphamide... on Behalf of the Chronic Malignancies Working Party`
- ✅ Massoud 2022 (Hamburg) — present (planning chat said 2021; paper is actually 2022)
- ✅ Meyer 2025 (Freiburg) — present (planning chat said 2024; paper is actually 2025)
- ✅ Shaffer 2024 (CIBMTR MUD/MMUD) — present

All eight protocol anchor papers confirmed in the corpus. Two minor year corrections (Papanicolaou 2024 not 2023; Massoud 2022 not 2021; Meyer 2025 not 2024) — propagate to the protocol's "known included papers" list.
