# GRADE Certainty-of-Evidence Assessment
### PTCy vs ATG-Based Prophylaxis (Comparison 2) — Four Primary Outcomes + BSI Supplement
*Prepared: 2026-05-27*

---

## Framework

All evidence derives from observational studies (retrospective cohort and registry
analyses); no randomised controlled trial contributed numeric data to any Comparison 2
outcome. GRADE starting certainty is **LOW**. Standard downgrade and upgrade criteria
apply per the Comparison 1 assessment (see C1 GRADE document for full framework
description). Where Comparison 1 results inform the assessment — for example, the CMV
direction reversal — this is noted explicitly.

The Comparison 2 corpus is smaller than Comparison 1 across all outcomes (k = 5–12 vs
k = 15–35), and several outcomes (NRM k = 5, aGVHD k = 6) are at the lower boundary of
what GRADE conventionally considers assessable. Ratings for these outcomes should be
interpreted with this limitation in mind.

---

## 1. Overall Survival (OS)

**k = 10 paired studies · N = 10,624**
**M1: OR 0.69 [0.61–0.78], P(OR < 1) = 100% · τ = 0.56 [0.35–0.96]**
**M2 (steroid-adjusted): OR 0.78 [0.68–0.90], P(OR < 1) = 99.9%**
**Frequentist: OR 0.53 [0.29–0.96], I² = 90%, τ̂ = 0.85**

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective/registry; start LOW | — |
| **Risk of bias** | Serious: selection bias is plausible — PTCy arms are enriched for haploidentical donors (potentially younger, fitter recipients). M2 partial attenuation (0.69→0.78, 35%) confirms residual confounding but does not abolish the signal. No RCT contributes. | 0 (effect survives adjustment; direction of residual confounding uncertain) |
| **Inconsistency** | Very serious: frequentist I² = 90%, driven by two small studies with extreme ORs (Dybko 2024, OR 0.07; Nykolyszyn 2020, OR 0.17). The Bayesian model regularises this to τ = 0.56 via the half-normal prior, which is defensible but means the heterogeneity assessment depends on the analytic framework. A single study (Penack 2024, n = 8,764) carries 72% of inverse-variance weight, raising concerns about evidence concentration. | **−1** |
| **Indirectness** | Not serious: direct populations, standard OS endpoint | 0 |
| **Imprecision** | Not serious: CrI 0.61–0.78 entirely below null; N = 10,624 | 0 |
| **Publication bias** | Not strongly suspected: large registry studies dominate | 0 |
| **Upgrade: cross-comparison coherence** | Direction consistent with C1 (OR 0.77 [0.71–0.83]); mediation pattern also consistent (partial attenuation 29% C1, 35% C2). Concordance across two independent comparisons with different comparator regimens strengthens the inference. | +1 |

**Starting certainty:** LOW
**Net adjustment:** −1 + 1 = 0
**⊕⊕◯◯ CERTAINTY: LOW**

> *Interpretation: We have low certainty that PTCy reduces overall mortality compared to ATG-based prophylaxis (OR 0.69 [0.61–0.78]). The signal is directionally consistent with Comparison 1 and survives steroid adjustment (M2 OR 0.78). However, the corpus is dominated by a single large registry study (Penack 2024), and two small studies with extreme effect sizes inflate frequentist heterogeneity to I² = 90%. The Bayesian estimate, which regularises these outliers, is considered more appropriate but masks genuine cross-study variability.*

---

## 2. Non-Relapse Mortality (NRM)

**k = 5 paired studies · N = 1,186**
**M1: OR 0.65 [0.43–0.97], P(OR < 1) = 98.2% · τ = 0.38 [0.02–0.69]**
**M2 (steroid-adjusted, MI): OR 0.76 [0.48–1.16], P(OR < 1) = 90%**
**Frequentist: OR 0.61 [0.39–0.95], I² = 0%, τ̂ = 0**

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective/registry; start LOW | — |
| **Risk of bias** | Serious: M2 attenuation (0.65→0.76, 38%) with CrI crossing the null suggests substantial GVHD-mediated confounding, consistent with the complete mediation observed in C1 (M1 OR 0.86 → M2 OR 1.02). Whether the residual C2 benefit (M2 OR 0.76) reflects a genuine direct effect or simply the wider uncertainty at k = 5 cannot be determined. | **−1** |
| **Inconsistency** | Not serious: frequentist I² = 0%; Bayesian τ prior-dominated at k = 5 but consistent direction across all five studies | 0 |
| **Indirectness** | Not serious | 0 |
| **Imprecision** | Serious: k = 5 with modest total N (1,186); M1 CrI just excludes the null (0.43–0.97) but M2 CrI crosses it (0.48–1.16). Precision is insufficient to distinguish partial from complete mediation. | **−1** |
| **Publication bias** | Not assessable at k = 5 | 0 |

**Starting certainty:** LOW
**Net adjustment:** −2 (risk of bias, imprecision)
**⊕◯◯◯ CERTAINTY: VERY LOW**

> *Interpretation: We have very low certainty about the NRM effect of PTCy vs ATG. The M1 estimate (OR 0.65) is nominally significant, but steroid adjustment attenuates it substantially (M2 OR 0.76, CrI crossing null), reproducing the mediation pattern observed in C1. At k = 5 and N = 1,186, the corpus is too small to determine whether PTCy has a genuine direct NRM advantage over ATG beyond its GVHD-mediated effect. Clinical interpretation should mirror the C1 conclusion: the apparent NRM benefit is likely conditional on GVHD prevention.*

---

## 3. Acute GVHD Grade II–IV (aGVHD)

**k = 6 paired studies · N = 784 · all D+100**
**M1: OR 0.59 [0.42–0.84], P(OR < 1) = 99.8% · τ = 0.27 [0.01–0.65]**
**Frequentist: OR 0.44 [0.22–0.88], I² = 67%, τ̂ = 0.70**

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective/registry; start LOW | — |
| **Risk of bias** | Serious: centre-dependent GVHD grading; possible under-diagnosis in PTCy arms (expectation bias). However, this bias would attenuate the apparent benefit, making the estimate conservative. | 0 (direction of residual bias opposes the effect) |
| **Inconsistency** | Moderate: frequentist I² = 67%, but Bayesian τ = 0.27 with wide CrI [0.01–0.65], reflecting poor information about heterogeneity at k = 6. The discrepancy between frequentist (τ̂ = 0.70) and Bayesian (τ = 0.27) reflects prior influence, not data certainty. | **−1** |
| **Indirectness** | Not serious: all studies report D+100 aGVHD II–IV, a standard endpoint | 0 |
| **Imprecision** | Not serious: CrI 0.42–0.84 entirely below null; P(OR < 1) = 99.8% | 0 |
| **Publication bias** | Not assessable at k = 6 | 0 |
| **Upgrade: confounders oppose** | Partially met: if GVHD under-diagnosis in PTCy arms exists, the true effect would be larger than estimated. Cross-comparison coherence with C1 (OR 0.63 [0.54–0.74], k = 24) also supports the signal. | +1 |

**Starting certainty:** LOW
**Net adjustment:** −1 + 1 = 0
**⊕⊕◯◯ CERTAINTY: LOW**

> *Interpretation: We have low certainty that PTCy reduces aGVHD grade II–IV compared to ATG (OR 0.59 [0.42–0.84]). The point estimate is concordant with Comparison 1 (C1 OR 0.63), and the CrI is entirely below the null despite the small corpus. The main limitation is poor heterogeneity estimation at k = 6 — frequentist and Bayesian estimates of τ diverge substantially, and neither can be considered reliable. The direction of plausible bias (GVHD under-diagnosis in PTCy arms) would make the true effect larger, not smaller.*

---

## 4. CMV Any-Reactivation

**k = 12 paired studies · N = 1,267**
**M1: OR 0.77 [0.60–0.99], P(OR < 1) = 98% · τ = 0.53 [0.30–0.93]**
**M2 (steroid-adjusted): OR 0.82 [0.64–1.05], P(OR < 1) = 94%**
**Sensitivity (expanded arms, k = 14): OR 0.91 [0.75–1.12], P(OR < 1) = 82%**
**Frequentist: OR 0.67 [0.41–1.09], I² = 67%, τ̂ = 0.68**

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective; start LOW | — |
| **Risk of bias** | Serious: CMV monitoring intensity varies across centres and may differ between PTCy and ATG arms. More intensive surveillance in ATG arms (where T-cell depletion is recognised to increase CMV risk) could inflate ascertainment in the comparator, biasing toward apparent PTCy protection. Donor-type imbalances are common (many PTCy arms are haploidentical while ATG arms are MUD or MRD). | 0 (direction of bias uncertain; noted in text) |
| **Inconsistency** | Serious: I² = 67%, τ = 0.53; heterogeneous timepoint mix (D+100, 1-year, end-of-follow-up); geographic and prophylaxis-era variation | **−1** |
| **Indirectness** | Not serious: CMV any-reactivation is a standard endpoint | 0 |
| **Imprecision** | Serious: CrI 0.60–0.99 just excludes the null in M1, but crosses it in M2 (0.64–1.05) and in the expanded-arm sensitivity (0.75–1.12). The signal is fragile and dependent on analytic decisions (arm classification, covariate adjustment). | **−1** |
| **Publication bias** | Not strongly suspected | 0 |
| **Upgrade: mechanistic coherence** | The direction reversal from C1 (OR 1.41 → C2 OR 0.77) is coherent with the T-cell depletion depth hypothesis: PTCy depletes T cells more than CNI-based regimens but less than ATG, and CMV risk tracks this hierarchy. This cross-comparison coherence is a strong mechanistic signal that would not arise from confounding alone. However, the fragility of the C2 point estimate (sensitivity OR 0.91) tempers the upgrade. | +1 (partial) |

**Starting certainty:** LOW
**Net adjustment:** −2 + 1 = −1
**⊕◯◯◯ CERTAINTY: VERY LOW**

> *Interpretation: We have very low certainty about the magnitude and direction of PTCy's effect on CMV reactivation compared to ATG. The M1 estimate (OR 0.77) suggests probable protection, but this finding is fragile: steroid adjustment moves the CrI across the null (M2 OR 0.82 [0.64–1.05]), and including PTCy + ATG combination arms attenuates the signal further (OR 0.91 [0.75–1.12]). The most defensible inference is not the specific C2 point estimate but the direction reversal itself: the contrast between C1 (PTCy harmful for CMV vs CNI+MTX/MMF) and C2 (PTCy protective or neutral vs ATG) is mechanistically coherent and supports the conclusion that CMV risk is ordered by depth of T-cell depletion rather than by any intrinsic property of PTCy. This comparative finding has higher certainty than either C2 estimate in isolation.*

---

## 5. Bloodstream Infection (BSI, any pathogen) — Descriptive Supplement

**k = 3 paired studies · N = 613**
**Mantel-Haenszel fixed-effect: OR 2.03 [1.33–3.09], p = 0.001 · I² = 69%**

A formal GRADE assessment is not performed for BSI in Comparison 2, as the corpus of
three studies is below the conventional minimum for structured certainty rating.
The following limitations are noted for context:

- **Definitional heterogeneity:** Two studies (Meyer 2025, Berro 2021) used any positive
  blood culture; one (Bordat 2026) restricted to severe infections requiring ICU
  admission or resulting in death. These are not equivalent constructs.
- **Timepoint mismatch:** D+100 (2 studies) vs 1-year (1 study).
- **Donor-type confound:** The dominant study (Meyer 2025, 72% of weight) had 54%
  haploidentical donors in the PTCy arm vs 100% MUD in the ATG arm.
- **Direction consistent with C1** (C1 OR 2.39 [1.85–3.10], k = 6), but the C1 corpus
  also carried a VERY LOW certainty rating.

If a rating were forced, it would be **⊕◯◯◯ VERY LOW** at best, driven by very serious
risk of bias (definitional and population heterogeneity), very serious imprecision
(k = 3), and inability to assess publication bias.

---

## Summary Table

| Outcome | k | N | OR [95% CrI] | Posterior P | Certainty | Key limitation |
|---|---|---|---|---|---|---|
| **Overall survival** | 10 | 10,624 | 0.69 [0.61–0.78] | P(<1) = 100% | ⊕⊕◯◯ **LOW** | I² = 90% (freq); evidence concentrated in one registry |
| **Non-relapse mortality** | 5 | 1,186 | 0.65 [0.43–0.97] | P(<1) = 98% | ⊕◯◯◯ **VERY LOW** | k = 5; M2 mediation; CrI fragile |
| **aGVHD grade II–IV** | 6 | 784 | 0.59 [0.42–0.84] | P(<1) = 100% | ⊕⊕◯◯ **LOW** | k = 6; τ poorly estimated |
| **CMV reactivation** | 12 | 1,267 | 0.77 [0.60–0.99] | P(<1) = 98% | ⊕◯◯◯ **VERY LOW** | CrI fragile to adjustment/sensitivity; direction reversal from C1 is the key finding |
| **BSI any pathogen** | 3 | 613 | 2.03 [1.33–3.09]† | p = 0.001 | (⊕◯◯◯)‡ | k = 3; definitional heterogeneity; donor confound |

†Mantel-Haenszel fixed-effect; not Bayesian.
‡Informal rating; formal GRADE not performed at k = 3.

*⊕ = present; ◯ = absent. Certainty levels: HIGH (⊕⊕⊕⊕), MODERATE (⊕⊕⊕◯), LOW (⊕⊕◯◯), VERY LOW (⊕◯◯◯).*

---

## GRADE Narrative Summary — Comparison 2

Certainty of evidence in Comparison 2 is LOW for OS and aGVHD, and VERY LOW for NRM,
CMV, and BSI — generally one tier lower than the corresponding Comparison 1 ratings,
reflecting the smaller corpora and greater analytic fragility.

Three observations are methodologically notable:

1. **Cross-comparison coherence strengthens OS and aGVHD inferences.** Both outcomes show
   directionally consistent, mechanistically expected effects across two independent
   comparisons with different control regimens (C1: CNI+MTX/MMF; C2: ATG). The mediation
   pattern for OS (partial attenuation) and NRM (substantial attenuation) also replicates.
   While GRADE does not formally recognise cross-comparison consistency as an upgrade
   criterion, it substantially reduces the probability that the observed signals are
   artefacts of a single comparator-specific confounding structure.

2. **The CMV direction reversal is more informative than either point estimate alone.**
   The C2 CMV signal (OR 0.77) is individually fragile. However, the reversal from C1
   (OR 1.41) to C2 (OR 0.77) is robust to the specific C2 point estimate: any value
   below ~1.0 in C2 confirms a qualitative shift in direction. This cross-comparison
   contrast provides moderate-certainty evidence that CMV risk is ordered by depth of
   T-cell depletion, even though the individual C2 estimate has very low certainty.

3. **BSI and IFI remain data-poor.** Neither outcome has sufficient Comparison 2 data
   for meaningful inference. Dedicated prospective studies of infection outcomes in
   PTCy vs ATG cohorts remain a priority evidence gap.

---

*All Bayesian estimates from brms 2.23.0 (rstan backend). Mantel-Haenszel estimate from
metafor 5.0-1. GRADE applied per the GRADE Handbook (Schünemann et al.) and the GRADE
working group guidance for meta-analyses of observational studies.*
