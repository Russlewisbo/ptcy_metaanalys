# Block 9 extraction summary — audit-driven corpus expansion

**Date:** 2026-05-29
**Scope:** 55 PDFs from the Marta_selected screening list that were missing from the original Paperpile extraction (identified by the corpus audit on 2026-05-28).
**Workbook produced:** `PTCy_MA_extraction_template_v1.2_post_block9.xlsx` (alongside the original v1.2 workbook; the original is untouched)

---

## Outcome

| Bucket | N |
|---|---|
| PDFs processed | 55 |
| Extracted as primary studies (with arms + outcomes) | 30 |
| Single-arm trial retained for PRISMA but no outcomes (Raiola PHYLOS) | 1 |
| Excluded with PRISMA-trackable reason | 24 |
| Errors / missing | 0 |

### Exclusions (24)

| Reason | N |
|---|---|
| `single_arm_descriptive_excluded` | 19 |
| `narrative_review` | 3 (Lazzari 2025, Mussetti 2021 editorial, Williams 2020) |
| `systematic_review_not_primary_study` | 1 (John 2025) |
| `conference_abstract` | 1 (Desai 2025) |
| `non_eligible_population` | 1 (Parta 2020 — chronic granulomatous disease) |

The single-arm exclusions include several PDFs we hoped would boost the sparse-outcome cells (Slade 2017 BSI epidemiology, Salas 2020 EBV-PTLD, Bejanyan 2021 phase 2, Wieczorek 2023 ALWP related, Joyce 2025 Japanese, Sanz 2020 ALWP, etc.). They are real single-arm PTCy series with no comparator regimen, so under the locked v1.2 protocol they cannot enter Comparisons 1/2/3 — but they are tracked for the PRISMA flow diagram.

---

## Database deltas

| Sheet | Pre Block 9 | Post Block 9 | Δ |
|---|---:|---:|---:|
| `cohorts` | 160 | 181 | +21 |
| `studies` | 220 | 251 | +31 |
| `arms` | 457 | 525 | +68 |
| `outcomes` | 3 050 | 3 604 | +554 |
| `outcomes_subgroup` | 116 | 126 | +10 |
| `rob` | 210 | 241 | +31 |
| Excluded (PRISMA) | 190 | 214 | +24 |
| **RCTs** | **10** | **14** | **+4** |

### New RCTs (4)

| study_id | Reference | Cohort |
|---|---|---|
| 432 | Koura D 2025, Blood Advances | Phase 2 PTCy + abatacept |
| 462 | Zhang W 2023, British Journal of Haematology | Reduced-dose PTCy + low-dose ATG |
| 464 | Zu Y 2022, Bone Marrow Transplantation | Low-dose PTCy + low-dose ATG (MUD) |
| 465 | Zu Y 2023, Blood Cancer Journal | Low-dose PTCy + ATG, multicenter RCT |

Total RCTs now 14.

### Comparison eligibility (arms)

| Comparison | Old | New | Δ |
|---|---:|---:|---:|
| 1: PTCy ± CNI/MMF vs CNI + MTX/MMF | 301 | 313 | +12 |
| 2: PTCy vs ATG-based | 101 | 109 | +8 |
| 3: Within-PTCy variants | 29 | 68 | **+39** |

The big delta is Comparison 3 — the within-PTCy dose-variant subset more than doubled (29 → 68 arms). This is the comparison we previously had not modeled because k was too small; it is now in the same league as Comparison 2.

### New outcomes by category

| Outcome category | New rows added |
|---|---:|
| aGVHD | 118 |
| cGVHD | 101 |
| overall_mortality | 70 |
| other_infection | 68 |
| NRM | 67 |
| CMV | 50 |
| engraftment_failure | 45 |
| **BSI** | **15** |
| **IFI_any** | **8** |
| infection_related_mortality | 6 |
| **IFI_mold** | **4** |
| steroid_refractory_aGVHD | 2 |

Sparse-outcome expansion: BSI +15, IFI_any +8, IFI_mold +4. Will materially affect τ and the precision of the OR estimates for those models.

### Workbook totals by outcome category (post-Block 9)

```
aGVHD                                871
cGVHD                                555
overall_mortality                    523
NRM                                  478
engraftment_failure                  303
CMV                                  292
other_infection                      269
BSI                                  100
infection_related_mortality           83
IFI_any                               50
IFI_mold                              38
steroid_refractory_aGVHD              20
second_line_GVHD_therapy_use          11
IFI_yeast                             11
```

---

## Validation flags (5 R-rule violations)

All 5 are documented extraction decisions, not data-entry errors. They appear in `extraction_notes`:

| Outcome ID | Paper | Issue | Resolution |
|---|---|---|---|
| 3208 | Garcia-Cadenas (study 426) | engraftment_failure denom=117 > arm.n_patients=40 | Whole-cohort rate not stratified by donor type; agent assigned to arm 1 with explanatory note |
| 3267, 3280, 3282, 3285 | Lazana (study 433) | denom=63 > arm.n_patients=33 (A1) | Outcomes pooled across PTCy-15 and PTCy-25 dose subgroups; agent assigned to arm A1 with explanatory note |

**For Bayesian modeling:** Lazana 2026 should probably be modeled with PTCy-15 + PTCy-25 collapsed (n=63), or excluded from the dose-subgroup analysis. Garcia-Cadenas 2021 graft-failure outcome should either be dropped or modeled at the pooled-cohort level.

---

## Cohort notes

21 new cohorts (1162–1182) added. Several known clusters absorbed multiple Block 9 papers into existing cohort_ids without new cohort rows (per cohort_overlap_map):

- **EBMT_ALWP_AML (1009)**: Ruggeri 2018 (447), Sanz 2020 (450), Spyridonidis 2022 (453)
- **GETH/Spanish (1019/20/49/50/51)**: Redondo 2025 (446)
- **Pavlov cohort (Russian)**: Moiseev 2018 (438)

New stand-alone cohorts span: Esquirol 2024 (Spanish 20-year experience), Hyder 2025 (JHU intermediate-dose), Kerbauy 2025, Kim DH 2024, Koura 2025 abatacept, Lazana 2026, Makanga 2020, Mandaci Sanli 2025, Nakamae 2019 (Japan reduced-dose), Raiola 2025 PHYLOS, Venugopal 2025, Wang L 2021, Wang Y 2025, Zhang 2023, Zu 2022, Zu 2023.

---

## What this means for the existing Bayesian models

The current models in `03_models/` were fit on the 220-study baseline. With Block 9:

**Likely to shift most:**
- **C3 models** — k roughly doubled. The C3 OS/NRM/aGVHD models can now be fit with reasonable power instead of being skipped. New fits will be entirely new analyses.
- **BSI** (C1 was k=6 → +15 new BSI outcomes; many will land in C1 cells). Likely a meaningful change in OR point estimate and τ.
- **IFI_any / IFI_mold** — similar story. Sparse cells gain real information.
- **CMV** — +50 new outcomes. The C1 CMV OR (currently favoring CNI over PTCy) will tighten or shift slightly.

**Likely stable:**
- **OS / NRM (C1)** — already well-powered (k≈35/15); +6 and +5 new studies respectively. Direction unlikely to change; CrI widths slightly narrower.
- **aGVHD II–IV (C1)** — k already large; minor shift only.

**No change:**
- Comparison 2 OS/NRM models — Block 9 added a few C2 arms but the bulk of C2 is registry papers already extracted.

---

## Files produced

- `PTCy_MA_extraction_template_v1.2_post_block9.xlsx` — the consolidated workbook (251 studies / 525 arms / 3604 outcomes / 14 RCTs)
- `PTCy_MA_extraction_template_v1.2_excluded_papers.json` — updated PRISMA exclusion log (214 records)
- `BLOCK_9_extraction_summary_2026-05-29.md` — this file
- (Original `PTCy_MA_extraction_template_v1.2.xlsx` is preserved untouched)

---

## Status of next steps

- ✅ Consolidation done; workbook validated (5 documented violations, all in extraction_notes)
- ⏸ **Paused for Russ's review** — per the agreed plan, model refit is gated on Russ confirming the delta is sensible
- ⏭ Next on resume: refit affected Bayesian models (`brms::update()` on m1/m2/m3 for OS, NRM, aGVHD, CMV, BSI, IFI; fit new Comparison 3 models from scratch); regenerate `Table2_results.csv` and forest plots
