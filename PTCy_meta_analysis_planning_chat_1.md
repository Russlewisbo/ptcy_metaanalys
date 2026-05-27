# PTCY Meta-Analysis Planning — Complete Chat Timeline

**Date:** April 17, 2026
**Topic:** Descriptive quantitative Bayesian meta-analysis of infection risk in allogeneic BMT patients receiving PTCY vs other GVHD prophylaxis

---

## 1. Initial Question — Analysis Framework

**User:** We want to perform a descriptive quantitative meta-analysis of infection risk comparing allogeneic bone marrow transplant patients who receive PTCY vs other prophylaxis. We specifically want to compare the rates of severe bacterial, viral (CMV) and fungal infections in the cohort possibly using bayesian methods in R. Analysis will be stratified by prophylaxis (when reported). What would be the key analysis steps and R packages that we would use to perform this study?

**Assistant response — methodological roadmap:**

### 1. Protocol & scope decisions upfront

Before any coding, nail down several decisions that will shape everything:

- **Comparator architecture.** "Other prophylaxis" is highly heterogeneous (CNI+MTX, CNI+MMF, ATG-based, sirolimus-based, abatacept, etc.), and PTCY itself now spans haplo-PTCY, MUD-PTCY, MSD-PTCY, and PTCY+CNI+MMF variants. Decide early whether you're doing (a) PTCY vs pooled "other," (b) PTCY vs each specific non-PTCY regimen (pairwise), or (c) a network meta-analysis. For a *descriptive* MA, option (a) with stratified subgroup estimates is the usual pragmatic choice.
- **Outcome definitions.** Pre-specify what counts as "severe." For bacterial, typically BSI with a pathogen and/or sepsis/septic shock by Sepsis-3; for CMV, distinguish clinically significant reactivation (PET threshold) from CMV end-organ disease; for IFI, require EORTC/MSG proven + probable (exclude possible).
- **Time windows.** Day +30, +100, +180, and 1-year are the usual reporting points. Extract whatever's reported and analyze stratified by window.
- **Era stratification.** Letermovir approval (late 2017) is the single biggest confounder for CMV — pre-planning a pre/post-letermovir stratum is essential. Similarly for isavuconazole/posaconazole prophylaxis for IFI.
- Register the protocol on PROSPERO and use PRISMA 2020 reporting.

### 2. Search, screening, extraction

Search PubMed, Embase, Cochrane CENTRAL, and Web of Science. Useful R helpers: `litsearchr` for refining the search string via keyword co-occurrence, `revtools` for deduplication and topic modeling of the corpus, and `metagear` if you want R-native abstract screening (though Rayyan/Covidence are usually faster for the actual human screening step). For extraction, `synthesisr` handles RIS imports cleanly; extraction itself usually lives in a structured spreadsheet (or REDCap). Risk of bias: almost everything in this literature is retrospective observational, so **ROBINS-I** (visualize with `robvis`); RoB 2 only for the rare RCTs.

### 3. Effect-size calculation

For a *descriptive* MA of incidence proportions per arm, use `metafor::escalc()`:

- `measure = "PLO"` (logit-transformed proportion) — generally preferred; works well with Bayesian hierarchical models and handles moderate zero-event issues with continuity correction.
- `measure = "PFT"` (Freeman–Tukey double arcsine) — historically popular but back-transformation is unstable when proportions are near 0 or 1 and sample sizes vary, which is exactly our situation for severe IFI (rare) and CMV reactivation (common). **Avoid unless you have a specific reason.**

For head-to-head PTCY vs other, compute log odds ratios or log risk ratios with `escalc(measure = "OR" or "RR")`. For zero-event studies, plan to handle them in the model rather than via continuity corrections — Bayesian binomial-normal models do this natively.

### 4. Exploratory frequentist pass

Do a quick frequentist pass first with `metafor::rma()` or `meta::metaprop()` / `meta::metabin()`. This is not the final analysis — it's a sanity check for data-entry errors, a source for starting values, and a benchmark for the Bayesian results. `dmetar` adds useful diagnostics (Baujat, GOSH).

### 5. Bayesian meta-analysis — the main event

Three packages worth your time, in increasing order of flexibility:

**`bayesmeta`** — the most turnkey option for pairwise Bayesian MA. It gives analytic posteriors (no MCMC) for the normal-normal hierarchical model, handles half-normal / half-Cauchy / Jeffreys priors on τ cleanly, and produces nice forest plots with posterior shrinkage. Perfect for each of your three outcome families as a standalone analysis. For sparse outcomes (severe IFI), pair it with `bayesmeta::convolve()` tricks or move to `brms`.

**`baggr`** — Bayesian hierarchical modeling with three pooling options (full, partial, none) that it reports side-by-side. Extremely useful for this question because you can show reviewers what happens under different assumptions and because its visualizations make heterogeneity interpretable. Good for the PTCY-vs-other comparative analysis.

**`brms`** — the workhorse. For a proper binomial-normal model with the raw event counts (no logit transformation needed, zero-events handled natively):

```r
brm(events | trials(n) ~ 0 + arm + (0 + arm | study),
    family = binomial("logit"),
    prior = c(prior(normal(0, 1.5), class = b),
              prior(half_normal(0, 0.5), class = sd)),
    data = dat, cores = 4, iter = 4000)
```

This framework scales to meta-regression (add donor type, conditioning intensity, era, CMV serostatus as covariates), arm-based network MA, and hierarchical structures (studies nested in centers). `tidybayes` + `ggdist` for posterior visualization.

Two other packages to keep on the shelf: **`RoBMA`** for Bayesian model-averaged publication-bias assessment (more defensible than Egger's for proportions), and **`multinma`** if you end up doing a proper network meta-analysis across prophylaxis regimens.

### 6. Priors

For log-odds effects, weakly informative priors like `normal(0, 1.5)` on arm effects are reasonable. For τ (between-study SD on the logit scale), half-normal(0, 0.5) is a sensible weakly-informative default for infection outcomes; half-Cauchy(0, 0.5) is more conservative. Report a **prior sensitivity analysis** comparing at least 2–3 τ priors.

### 7. Heterogeneity, subgroups, meta-regression

Pre-specified sources of heterogeneity:
- Donor type (haplo vs MSD vs MUD vs MMUD)
- Conditioning intensity (MAC vs RIC vs NMA)
- Graft source (PBSC vs BM vs UCB)
- Era: pre-/post-letermovir (CMV); antifungal prophylaxis regimen (IFI)
- D/R CMV serostatus distribution (especially D−/R+)
- Region (US/EU/Asia — impacts MDRO epidemiology for bacterial outcomes)
- Follow-up duration and definition of "severe"

### 8. Reporting small-study effects and certainty

Funnel plots + Egger's for the OR/RR analyses. For single-arm proportions, funnel asymmetry is harder to interpret — `RoBMA` is the cleanest way to formally assess publication bias under a Bayesian framework. GRADE your certainty of evidence for each of the three infection categories separately.

### 9. Sensitivity analyses

Leave-one-out (`metafor::leave1out` or manual loop in `brms`), restriction to low-risk-of-bias studies, excluding pediatric/adult-only if mixed, prior sensitivity analysis.

### 10. Reporting

Quarto manuscript with `forester` or `ggforestplot` for forest plots, `tidybayes` + `ggdist` for posterior density displays, `robvis` for the RoB summary, and a PRISMA 2020 flow diagram via `PRISMA2020`. For tables, `gt` or `flextable`.

---

## 2. Refinement After Initial Literature Search Review

**User uploaded PDF:** Preliminary report of 80 included studies from Elicit search (1,000 results → 615 screened in → 80 reviewed in detail).

**Assistant response — three critical issues identified:**

### The overlapping-cohort problem is severe

The 80 included studies represent perhaps 40–50 unique patient populations reported multiple times. Several clusters:

- **CIBMTR HaploCy/SibCy/SibCNI cohort** (n = 1,160 / 1,605) appears in at least seven abstracts — Singh 2020, Singh 2021, Goldsmith 2020, Goldsmith 2021, Mulroney 2021, Papanicolaou 2023, and Taplitz 2020 — each reporting a different outcome on the same patients.
- **BMT CTN 1703** appears as Holtan 2022 (primary), Abedin 2024 (age subgroup), plus Siegel 2025 and Kean 2023 (BMT CTN 1801 mechanistic substudies on the same patients).
- **Salas/Hospital Clínic Barcelona** series contributes six entries (2022, 2022a, 2022b, 2022c, 2023, plus Charry 2021 and Pinto 2025 sharing overlap).
- **Khimani 2021 / Ranspach 2020** share the 113/470 Moffitt cohort.
- **Battipaglia 2018 / 2019** are EBMT ALWP analyses that likely overlap.
- **Bordat 2024 / 2025** appear to be the same MMUD cohort at different reporting stages.

Build a **"unique cohort ID"** column during extraction before anything else. For each unique cohort, pick one primary publication per outcome (most recent with longest follow-up usually wins). When overlap is partial and unavoidable, `metafor::rma.mv()` with a cluster-level random effect for cohort ID plus cluster-robust variance via `clubSandwich::coef_test()`. In `brms` the equivalent is nesting: `(1 | cohort_id / study_id)`.

### Most sources are abstract-only

Can't extract denominators, timing, event definitions, or CI bounds reliably from ASH abstracts alone. Recommendations:
- Re-run a proper structured search in PubMed + Embase + CENTRAL
- For every abstract-only source, attempt full-text retrieval, contact authors for missing data
- Pre-specify that abstract-only studies are included only in a sensitivity analysis, not the primary

### The comparator structure is now clearer

- **PTCy-Tac/MMF vs CNI+MTX** (the BMT CTN 1703 comparison — cleanest)
- **PTCy vs ATG ± CNI** (the MMUD/MUD literature — Moiseev, Bordat, Bailén, Battipaglia, Martínez, Tang meta-analysis)
- **PTCy vs ATG+PTCy combination** (Luo meta-analysis, Cao, Wang, Kim — mostly Chinese/Korean haplo series)
- **PTCy vs ex vivo TCD** (Montoro)
- **PTCy-haplo vs UCB** (Harada)
- **Within-PTCy dose/regimen variants** (Rimando, Pinto, Ackula, Mehta 2022a for MMF, Jamy for 1 vs 2 doses)

### Refined R tooling

Given rarity of severe IFI and zero-event patterns in smaller cohorts, drop the logit-normal approximation for the primary model and use **`brms` with a binomial likelihood on the raw event counts**:

```r
brm(events | trials(n) ~ 0 + arm + (0 + arm | cohort_id),
    family = binomial("logit"),
    prior = c(prior(normal(0, 1.5), class = b),
              prior(student_t(3, 0, 0.5), class = sd)),
    data = d_bsi_d30, cores = 4, iter = 4000)
```

For CMV: **meta-regression with letermovir era as a moderator** (pre-2018 vs post-2018 as proxy). Handle three CMV endpoints separately: any reactivation, clinically significant reactivation, and CMV disease.

For bacterial BSI: many studies report BSI episodes per 1,000 patient-days (Khimani, Meyer) rather than cumulative incidence. These require a Poisson or negative-binomial likelihood with log-exposure offset.

For fungal: stratify EORTC/MSG-defined proven+probable from "any IFI"; the Papanicolaou CIBMTR numbers use a CIBMTR-specific definition that differs from EORTC/MSG.

---

## 3. User Decisions — First Round

**User confirmed:**
- Restrict analysis to full-text publications
- Collapse Salas/Barcelona entries into a single cohort with most recent publication as primary

---

## 4. Protocol Decisions — Detailed Questions

**Assistant asked about:**

### 1. Population scope
- 1a: Hematologic malignancies only vs including SAA, sickle cell, inborn errors?
- 1b: Include 2nd allo-HCT or first only?
- 1c: Minimum per-arm sample size?

### 2. Comparator architecture
- Pre-specified pairwise comparisons
- Network meta-analysis in or out of scope?

### 3. Primary and secondary outcomes
- 3a: Severe bacterial definition?
- 3b: CMV — three separate outcomes?
- 3c: IFI — EORTC/MSG proven + probable for primary?
- 3d: Secondary outcomes list?

### 4. Timepoints
Proposed:
- BSI: D+30 (primary), D+100 (secondary)
- CMV: D+100 (primary), D+180 (secondary)
- IFI: D+180 (primary), 1 year (secondary)
- NRM: 1 year (primary), D+100 (secondary)

### 5. Cohort overlap — decision rules
### 6. Pre-specified moderators / subgroup analyses
### 7. Effect measure and modeling framework
### 8. Risk of bias and certainty of evidence
### 9. Search strategy
### 10. Logistics

---

## 5. User Decisions — Second Round

**User confirmed:**
- **1a:** Restrict to hematological malignancies, but include SAA
- **1b:** Include only first transplant
- **1c:** Minimum ≥20 per arm
- Explore 5 prespecified combinations as primary analysis, folding comparisons 3 and 4 into regimen optimization analysis
- **3a:** BSI with any pathogen as primary, other definitions for sensitivity
- **3b:** Any CMV reactivation as primary, others for sensitivity
- **3c:** Restrict IFI to EORTC/MSG 2020 proven + probable for primary; "any IFI investigator-reported" as sensitivity; separate yeast vs. mold infections
- **3d:** Include infection-related mortality, NRM at D+100 and 1 year, time-to-event metrics

---

## 6. Locked Protocol — Running Summary

### Confirmed
- **Population:** adults ≥18, hematologic malignancies + SAA, first allogeneic HCT only, minimum 20 per arm
- **Primary comparisons:** three pairwise Bayesian MAs
  1. PTCy ± CNI/MMF vs CNI + MTX/MMF (no ATG, no TCD)
  2. PTCy ± CNI/MMF vs ATG-based
  3. Within-PTCy dose/regimen variants (reduced vs standard; PTCy+ATG combinations folded here as "regimen optimization")
- **Primary outcomes:**
  - **Bacterial:** BSI with any pathogen; other definitions (Sepsis-3, grade ≥3) as sensitivity
  - **CMV:** any CMV reactivation/viremia; clinically significant CMV and CMV disease as sensitivity
  - **IFI:** EORTC/MSG 2020 proven + probable, stratified separately as **invasive mold disease** and **invasive yeast disease**; "any IFI investigator-reported" as sensitivity
- **Infection-related mortality:** included when reported separately

### Timepoints (locked)
| Outcome | Primary | Sensitivity |
|---|---|---|
| BSI (any pathogen) | D+30 | D+100 |
| CMV (any reactivation) | D+100 | D+180 |
| Invasive mold disease | D+180 | 1 year |
| Invasive yeast disease | D+180 | 1 year |
| Infection-related mortality | 1 year | D+100 |
| NRM | 1 year | D+100 |

### Cohort overlap rules (locked)
- **Rule:** "One publication per cohort per outcome, chosen as the most complete/recent; remaining entries tagged as overlapping and excluded from primary pool but retained for sensitivity."
- **CIBMTR HaploCy/SibCy/SibCNI cohort** → Goldsmith 2021 (CMV primary), Singh 2021 (non-CMV herpesvirus), Papanicolaou 2023 (IFI), Mulroney 2021 / Taplitz 2020 (CRVI). All tagged with one `cohort_id`.
- **BMT CTN 1703** → Holtan 2022 primary; Abedin 2024 in age-subgroup sensitivity only; Kean 2023 + Siegel 2025 excluded from quantitative synthesis.
- **EBMT ALWP** → accept Battipaglia 2018 (MMUD), Battipaglia 2019 (MSD), Spyridonidis 2022 (MUD), Nagler 2024, Paviglianiti 2022 as separate cohorts only where donor stratum is non-overlapping.
- **Moffitt Khimani/Ranspach** → Khimani 2021 primary.

### Effect measure and priors (locked)
- Primary effect measure: log-OR from binomial-normal model in `brms`, with RR and RD derived post-hoc from posterior arm-level probabilities
- Studies reporting only rates per patient-time: exclude from primary binomial pool, parallel Poisson secondary analysis
- Priors: β ~ N(0, 1.5); τ ~ half-N(0, 0.5) primary, with half-Cauchy(0, 0.5) and half-N(0, 1.0) as prior-sensitivity
- No informative priors from prior MAs for primary

### Risk of bias and certainty (locked)
- ROBINS-I for non-randomized, RoB 2 for RCTs
- Dual reviewer required
- GRADE certainty of evidence in scope

### Search strategy (locked)
- PubMed + Embase + Cochrane CENTRAL + Web of Science
- String refined via `litsearchr` from Elicit seed
- Date limits: 2010–present
- English only (others with translation if needed)
- Conference abstracts excluded from primary synthesis
- PROSPERO registration

### Moderators (locked)
1. Donor type (MSD / MUD / MMUD / haplo / UCB)
2. Graft source (BM / PBSC / UCB)
3. Conditioning intensity (MAC / RIC / NMA)
4. Letermovir era + use (for CMV)
5. Antimold prophylaxis regimen (for IFI)
6. PTCy dose (standard 50 mg/kg×2 vs reduced)
7. D/R CMV serostatus distribution
8. Era (pre-2018 / 2018+)
9. Region (EU / NA / Asia / other)
10. **ATG dose category** (proposed addition for Comparison #2):
    - Low-dose ATG (≤4.5 mg/kg rabbit equivalent)
    - Standard-dose ATG (>4.5 to ≤10 mg/kg)
    - High-dose ATLG/Grafalon (>10 mg/kg)
    - Horse ATG (analyzed separately or excluded)

---

## 7. Logistics Decisions

**User confirmed:**
- Second reviewer: Director of the bone marrow transplant program

### Dual reviewer workflow (proposed)
- Both reviewers screen all titles/abstracts independently, resolve conflicts by consensus (or third-reviewer arbitration if >10% disagreement)
- Both reviewers screen all full texts independently
- **Extraction:** one extracts, the other verifies against source with discrepancy resolution (pragmatic, acceptable per Cochrane if documented)
- **RoB assessment:** both reviewers independently, consensus resolution

### Secondary endpoints — proposed final list
1. Infection-related mortality — cumulative incidence by 1 year (primary timepoint); D+100 as secondary
2. NRM at D+100 and 1 year — confirmed
3. Time-to-event metrics — treated as narrative/supporting rather than pooled
4. Immune reconstitution — excluded from quantitative synthesis (narrative only)
5. Hospital LOS — excluded from quantitative synthesis

---

## 8. Tool Choice — Covidence vs. Rayyan

### Rayyan
**Pros:** Free tier available, web-based, fast interface, good keyword highlighting, decent duplicate detection, mobile app
**Cons:** Paid tiers now limit free use, no built-in extraction/RoB/PRISMA generation

### Covidence
**Pros:** End-to-end workflow (deduplication → screening → extraction → RoB → PRISMA flow), auto-generates PRISMA 2020 diagram, built-in RoB 2 and ROBINS-I templates, Cochrane's official recommended tool
**Cons:** Paid; interface slower than Rayyan; more clicks per decision

**User confirmed:** UniPD has institutional Covidence access → **Covidence selected**

---

## 9. PICO Statement for Covidence

### Population

**Include:**
- Adults aged ≥18 years at the time of transplant
- Undergoing first allogeneic hematopoietic cell transplantation (allo-HCT)
- Underlying diagnosis of hematologic malignancy (AML, ALL, MDS, MPN, CML, CLL, lymphoma, multiple myeloma, other hematologic neoplasms) OR severe aplastic anemia (SAA)
- Any donor type (matched sibling, matched unrelated, mismatched unrelated, haploidentical, umbilical cord blood)
- Any graft source (peripheral blood, bone marrow, cord blood)
- Any conditioning intensity (myeloablative, reduced-intensity, non-myeloablative)

**Exclude:**
- Pediatric populations (<18 years) or studies not reporting adult-stratified data
- Non-malignant indications other than SAA
- Second or subsequent allogeneic transplants
- Autologous transplantation
- Solid organ transplantation
- Mixed adult/pediatric cohorts where adult data cannot be extracted separately

### Intervention / Exposure

**Include:**
- Post-transplant cyclophosphamide (PTCy) given for GVHD prophylaxis
- Any PTCy dose (standard 50 mg/kg × 2 days, reduced-dose ≤40 mg/kg, or other modified schedules)
- PTCy combined with calcineurin inhibitor and/or MMF, sirolimus, methotrexate, abatacept, or other immunosuppressive agents
- PTCy as sole GVHD prophylaxis

**Exclude:**
- Cyclophosphamide administered as part of conditioning regimen only
- Cyclophosphamide used for treatment (rather than prophylaxis) of established GVHD
- Studies in which PTCy timing, dose, or intent cannot be determined

### Comparator / Context

**Include** (one or more of the following non-PTCy GVHD prophylaxis comparators):
- Calcineurin inhibitor combined with methotrexate or MMF, without ATG and without ex vivo T-cell depletion (Comparison 1)
- ATG or ATLG based regimens at any dose, combined with CNI ± MTX/MMF (Comparison 2)
- Within-PTCy comparisons of different PTCy doses or regimen modifications (Comparison 3 / regimen optimization)

**Exclude:**
- Studies comparing PTCy only to ex vivo T-cell depletion without another eligible comparator
- Studies comparing PTCy only to umbilical cord blood transplant without another eligible GVHD prophylaxis comparator
- Single-arm studies without a non-PTCy comparator group
- Studies comparing two PTCy-containing regimens where both arms use identical PTCy dose and schedule

### Outcome

**Include** (study must report at least one of the following):

*Primary outcomes:*
- Bacterial BSI with any pathogen, cumulative incidence by day +30 or day +100
- CMV reactivation or viremia, cumulative incidence by day +100 or day +180
- Invasive fungal infection, EORTC/MSG proven or probable, stratified as invasive mold disease and invasive yeast disease, by day +180 or 1 year

*Secondary outcomes:*
- Infection-related mortality (when reported separately)
- NRM at day +100 and/or 1 year
- Clinically significant CMV infection requiring preemptive therapy; CMV end-organ disease
- Any investigator-defined IFI (sensitivity)
- Severe bacterial infection by Sepsis-3 or CTCAE grade ≥3 (sensitivity)
- Time-to-event metrics where available

**Exclude:**
- Studies reporting only composite infection endpoints that cannot be disaggregated
- Studies reporting infections only as adverse event tables without denominators or timepoints
- Studies in which outcome ascertainment period is <30 days post-transplant

### Study Characteristics

**Include:**
- Randomized controlled trials
- Prospective cohort studies
- Retrospective cohort studies
- Registry-based analyses (CIBMTR, EBMT, national registries)
- Case-control studies with ≥20 patients per arm
- Full-text peer-reviewed publications
- Minimum sample size of ≥20 patients per arm
- English language (or translatable)
- Published 2010 to present

**Exclude:**
- Conference abstracts, letters, editorials, commentaries, opinion pieces
- Case reports and case series without comparator
- Narrative reviews (systematic reviews/MAs retained for reference checking only)
- Single-arm studies
- <20 per arm
- Pre-2010
- Full text not obtainable after two documented retrieval attempts
- Duplicate publications of the same cohort (apply cohort-overlap rule)

### Other

**Include:**
- Studies where outcomes can be extracted separately by GVHD prophylaxis group
- Studies reporting cohort enrollment period that allows stratification by pre- vs post-letermovir era

**Exclude:**
- Studies with unresolvable patient cohort overlap (apply cohort-overlap rule)
- Studies with critical risk of bias on ROBINS-I that cannot be mitigated
- Studies where PTCy vs non-PTCy assignment is confounded with era effects that cannot be disentangled

---

## 10. Search Strategy

### Core concept structure

Three concept blocks joined with AND:
1. **Allogeneic HCT population** (disease + procedure)
2. **PTCy intervention**
3. **Infection outcomes**

### PubMed / MEDLINE

```
(
  ("Hematopoietic Stem Cell Transplantation"[MeSH]
   OR "Bone Marrow Transplantation"[MeSH]
   OR "allogeneic hematopoietic"[tiab]
   OR "allogeneic haematopoietic"[tiab]
   OR "allogeneic stem cell transplant*"[tiab]
   OR "allogeneic bone marrow transplant*"[tiab]
   OR "allogeneic HCT"[tiab]
   OR "allogeneic HSCT"[tiab]
   OR "allo-HCT"[tiab]
   OR "allo-HSCT"[tiab]
   OR "allo-SCT"[tiab]
   OR "allo-BMT"[tiab]
   OR "haploidentical"[tiab]
   OR "HLA-matched"[tiab]
   OR "matched unrelated donor"[tiab]
   OR "mismatched unrelated donor"[tiab])
)
AND
(
  ("Cyclophosphamide"[MeSH]
   AND ("Graft vs Host Disease"[MeSH] OR "graft-versus-host"[tiab] OR "graft versus host"[tiab] OR GVHD[tiab] OR GvHD[tiab]))
  OR "post-transplant cyclophosphamide"[tiab]
  OR "post-transplantation cyclophosphamide"[tiab]
  OR "posttransplant cyclophosphamide"[tiab]
  OR "posttransplantation cyclophosphamide"[tiab]
  OR "post transplant cyclophosphamide"[tiab]
  OR PTCy[tiab]
  OR PT-Cy[tiab]
  OR PTCY[tiab]
  OR "PT Cy"[tiab]
)
AND
(
  "Infections"[MeSH]
  OR "Bacterial Infections"[MeSH]
  OR "Virus Diseases"[MeSH]
  OR "Mycoses"[MeSH]
  OR "Bacteremia"[MeSH]
  OR "Sepsis"[MeSH]
  OR "Cytomegalovirus Infections"[MeSH]
  OR "Invasive Fungal Infections"[MeSH]
  OR infection*[tiab]
  OR infectious[tiab]
  OR bacterial[tiab]
  OR bacteremia[tiab]
  OR bacteraemia[tiab]
  OR "bloodstream infection*"[tiab]
  OR BSI[tiab]
  OR sepsis[tiab]
  OR septic[tiab]
  OR viral[tiab]
  OR virus[tiab]
  OR CMV[tiab]
  OR cytomegalovirus[tiab]
  OR "Epstein-Barr"[tiab]
  OR EBV[tiab]
  OR HHV-6[tiab]
  OR "human herpesvirus"[tiab]
  OR "BK virus"[tiab]
  OR fungal[tiab]
  OR fungus[tiab]
  OR mycosis[tiab]
  OR mycoses[tiab]
  OR mold[tiab]
  OR mould[tiab]
  OR yeast[tiab]
  OR aspergillosis[tiab]
  OR aspergillus[tiab]
  OR candida*[tiab]
  OR mucormycosis[tiab]
  OR "invasive fungal"[tiab]
  OR "non-relapse mortality"[tiab]
  OR "transplant-related mortality"[tiab]
  OR "treatment-related mortality"[tiab]
  OR NRM[tiab]
  OR TRM[tiab]
)
AND
(
  "2010"[Date - Publication] : "3000"[Date - Publication]
)
```

Filters: Humans; English

### Ovid-Embase (line-by-line approach)

Each line pasted separately into Ovid, pressing Ricerca after each:

```
exp hematopoietic stem cell transplantation/
exp bone marrow transplantation/
(allogeneic hematopoietic or allogeneic haematopoietic).ti,ab.
(allogeneic stem cell transplant* or allogeneic bone marrow transplant*).ti,ab.
(allo-HCT or allo-HSCT or allo-SCT).ti,ab.
(haploidentical or HLA-matched or matched unrelated donor or mismatched unrelated donor).ti,ab.
```

Then check boxes next to all 6 lines and click OR button → creates unified population block.

```
exp cyclophosphamide/
exp graft versus host reaction/
(graft-versus-host or graft versus host or GVHD).ti,ab.
```

Check boxes on graft versus host lines, click OR. Then reference the cyclophosphamide line and the combined GVHD line: `[cyclophosphamide line#] and [combined GVHD line#]`.

```
(post-transplant cyclophosphamide or post-transplantation cyclophosphamide).ti,ab.
(posttransplant cyclophosphamide or posttransplantation cyclophosphamide).ti,ab.
(PTCy or PT-Cy or PTCY).ti,ab.
```

Check cyclophosphamide-AND-GVHD line plus three PTCy text searches, click OR → unified PTCy block.

```
exp infection/
exp bacterial infection/
exp virus infection/
exp mycosis/
exp bacteremia/
exp sepsis/
exp cytomegalovirus infection/
exp invasive fungal infection/
(infection* or infectious or bacterial or bacteremia or bacteraemia).ti,ab.
(bloodstream infection* or BSI or sepsis or septic or viral).ti,ab.
(CMV or cytomegalovirus or EBV or HHV-6 or BK virus).ti,ab.
(fungal or mycosis or mycoses or mold or mould).ti,ab.
(aspergillosis or candida* or mucormycosis or invasive fungal).ti,ab.
(non-relapse mortality or transplant-related mortality or NRM or TRM).ti,ab.
```

Check all infection lines, click OR → unified infection block.

Final combination: check boxes on the three unified block lines, click **AND** to create intersection. Apply limits via **Limiti** menu (Human, English Language, Publication Year 2010 onwards).

### Expected hit counts
- Population block: ~150,000–300,000 hits
- PTCy block: ~3,000–8,000 hits
- Infection block: ~5–10 million hits
- Intersection: ~2,000–4,000 hits
- After limits: ~1,500–2,500 hits

### Cochrane CENTRAL

```
#1 MeSH descriptor: [Hematopoietic Stem Cell Transplantation] explode all trees
#2 MeSH descriptor: [Bone Marrow Transplantation] explode all trees
#3 "allogeneic stem cell transplant*" OR "allo-HCT" OR "allo-HSCT" OR haploidentical
#4 #1 OR #2 OR #3

#5 "post-transplant cyclophosphamide" OR "post-transplantation cyclophosphamide" OR "posttransplant cyclophosphamide" OR PTCy OR "PT-Cy" OR PTCY
#6 MeSH descriptor: [Cyclophosphamide] explode all trees
#7 MeSH descriptor: [Graft vs Host Disease] explode all trees
#8 (#6 AND #7)
#9 #5 OR #8

#10 infection* OR bacterial OR bacteremia OR bacteraemia OR "bloodstream infection*" OR BSI OR sepsis OR CMV OR cytomegalovirus OR EBV OR "HHV-6" OR fungal OR "invasive fungal" OR aspergillosis OR candida* OR "non-relapse mortality" OR NRM OR TRM
#11 MeSH descriptor: [Infections] explode all trees

#12 #10 OR #11

#13 #4 AND #9 AND #12

Publication Year: 2010-2026
```

### Web of Science Core Collection

```
TS=(("allogeneic hematopoietic" OR "allogeneic haematopoietic" OR "allogeneic stem cell transplant*" OR "allogeneic bone marrow transplant*" OR "allo-HCT" OR "allo-HSCT" OR "allo-SCT" OR haploidentical OR "HLA-matched" OR "matched unrelated donor" OR "mismatched unrelated donor"))

AND

TS=(("post-transplant cyclophosphamide" OR "post-transplantation cyclophosphamide" OR "posttransplant cyclophosphamide" OR "posttransplantation cyclophosphamide" OR PTCy OR "PT-Cy" OR PTCY))

AND

TS=((infection* OR infectious OR bacterial OR bacteremia OR bacteraemia OR "bloodstream infection*" OR BSI OR sepsis OR septic OR viral OR CMV OR cytomegalovirus OR "Epstein-Barr" OR EBV OR "HHV-6" OR "BK virus" OR fungal OR mycosis OR mycoses OR mold OR mould OR aspergillosis OR candida* OR mucormycosis OR "invasive fungal" OR "non-relapse mortality" OR "transplant-related mortality" OR "treatment-related mortality" OR NRM OR TRM))

Refine by: Publication Years: 2010-2026
Refine by: Document Types: Article OR Review
Refine by: Languages: English
```

### Covidence Search Strategy summary field

```
SEARCH STRATEGY SUMMARY

Databases searched (date of last search: [INSERT DATE]):
- PubMed/MEDLINE
- Embase (Elsevier or Ovid)
- Cochrane CENTRAL
- Web of Science Core Collection

Concept blocks (combined with AND):

Block 1 — Allogeneic HCT population:
MeSH/Emtree terms for Hematopoietic Stem Cell Transplantation and Bone Marrow Transplantation; text words including "allogeneic stem cell transplant*", "allo-HCT", "allo-HSCT", "allo-SCT", "haploidentical", "HLA-matched", "matched unrelated donor", "mismatched unrelated donor".

Block 2 — PTCy intervention:
"post-transplant cyclophosphamide", "post-transplantation cyclophosphamide", "posttransplant cyclophosphamide", "posttransplantation cyclophosphamide", "PTCy", "PT-Cy", "PTCY"; plus MeSH Cyclophosphamide combined with MeSH Graft vs Host Disease.

Block 3 — Infection outcomes:
MeSH/Emtree terms for Infections, Bacterial Infections, Virus Diseases, Mycoses, Bacteremia, Sepsis, Cytomegalovirus Infections, Invasive Fungal Infections; text words for bacterial/viral/fungal infection, BSI, sepsis, CMV, EBV, HHV-6, BK virus, aspergillosis, candida, mucormycosis, mold/yeast, and mortality endpoints (non-relapse mortality, NRM, TRM).

Filters applied:
- Publication date: 2010 to present
- Language: English
- Humans
- Excluded: conference abstracts, editorials, letters, case reports (applied at screening, not search)

Supplementary searches:
- Reference list screening of included studies and relevant systematic reviews
- Forward citation tracking in Web of Science for key index publications (BMT CTN 1703, CIBMTR HaploCy/SibCy/SibCNI cohort)
- PROSPERO registered protocols search for ongoing/related reviews

Full database-specific search strings archived in the study protocol (Supplementary File 1).
```

---

## 11. Next Steps Outstanding

### Still to finalize (logistics)
- **G2:** Screening tool confirmed (Covidence via UniPD institutional access)
- **G3:** Extraction platform — recommendation: Excel with controlled vocabularies → CSV export → Quarto analysis project
- **G4:** Target journal — candidates: JAC, BMT, TCT, Haematologica, CMI
- **G5:** Timeline — ~6–8 months to submission proposed
- **G6:** PROSPERO lead registrant — confirm
- **G7:** Authorship roles

### ATG stratification decision (pending)
Moderator #10 proposal: pre-specify ATG dose stratification within Comparison #2:
- Low-dose (≤4.5 mg/kg rabbit equivalent)
- Standard-dose (>4.5 to ≤10 mg/kg)
- High-dose ATLG/Grafalon (>10 mg/kg)
- Horse ATG (analyzed separately or excluded)

### Deliverables to build once decisions locked
1. **Full PROSPERO-ready protocol** (Quarto document)
2. **Extraction template** (Excel with controlled vocabularies) mapped to primary comparisons
3. **`brms` analysis skeleton** (Quarto notebook) with model specifications for each primary pairwise comparison × each outcome, meta-regression terms, prior-sensitivity loops, posterior post-processing to derive OR/RR/RD

### Recommended actions before search execution
1. Have UniPD biomedical librarian peer-review the strategy using PRESS checklist
2. Pilot-test strategy against 10–15 known included papers (Holtan 2022, Moiseev 2016, Tang 2023, Papanicolaou 2023, Salas 2023, Massoud 2021, Meyer 2024, Shaffer 2024)
3. Document exact run date for each database (all four on the same day if possible)
4. Acknowledge Elicit semantic search as exploratory/preliminary (not primary database)

---

*End of planning chat timeline.*
