# GRADE Certainty-of-Evidence Assessment
### Comparisons 1 and 2 — All Primary Outcomes
*Prepared: 2026-05-28*

---

## Framework

All evidence derives from observational studies (predominantly retrospective cohort and
registry analyses). A single RCT contributes to the Comparison 1 OS outcome (Curtis 2025,
ALLG BM12-CAST, k = 1 of 35 studies); no RCT contributes to any Comparison 2 outcome.
GRADE starting certainty for observational evidence is **LOW**. Downgrades are applied
per the standard five GRADE domains; upgrades for observational evidence are applied only
when strict criteria are met (large magnitude [OR ≥ 2 or ≤ 0.5], dose-response, or all
plausible residual confounding would oppose the observed effect).

Where results from one comparison inform the assessment of the other — for example, the
CMV direction reversal across comparisons — this is noted explicitly and may contribute
to upgrades for cross-comparison coherence.

**Comparisons:**
- **C1:** PTCy vs CNI+MTX/MMF (k = 6–35 across outcomes)
- **C2:** PTCy vs ATG-based prophylaxis (k = 3–12 across outcomes)

---

## 1. Overall Survival (OS)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 35, N = 17,661 (PTCy 4,659 / control 13,002) | k = 10, N = 10,624 |
| **M1** | OR 0.77 [0.71–0.83], P(<1) = 100%, τ = 0.59 | OR 0.69 [0.61–0.78], P(<1) = 100%, τ = 0.56 |
| **M2** | OR 0.83 [0.75–0.92], P(<1) = 100% | OR 0.78 [0.68–0.90], P(<1) = 99.9% |
| **Attenuation** | 29% (partial) | 35% (partial) |
| **Frequentist** | OR 0.75 [0.63–0.89], I² = 68% | OR 0.53 [0.29–0.96], I² = 90% |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | 34 retrospective/registry + 1 RCT; start LOW | All retrospective/registry; start LOW |
| **Risk of bias** | Serious: selection bias plausible (PTCy in younger/haplo recipients); M2 attenuation confirms some confounding but effect survives. **No downgrade** (effect survives adjustment; large registries mitigate). | Serious: similar selection bias; M2 attenuation comparable. **No downgrade** (same reasoning). |
| **Inconsistency** | Serious: I² = 68%, τ = 0.59. **−1** | Very serious: I² = 90% (freq), driven by two small extreme studies (Dybko 2024 OR 0.07, Nykolyszyn 2020 OR 0.17); Penack 2024 carries 72% of weight. Bayesian τ = 0.56 after regularisation. **−1** |
| **Indirectness** | Not serious. 0 | Not serious. 0 |
| **Imprecision** | Not serious: CrI entirely below null; N = 17,661. 0 | Not serious: CrI entirely below null; N = 10,624. 0 |
| **Publication bias** | Undetected: large registries unlikely to suppress negative OS findings. 0 | Not strongly suspected: large registries dominate. 0 |
| **Upgrade** | Not met (OR = 0.77; threshold < 0.50). 0 | Cross-comparison coherence: direction and mediation pattern consistent with C1. **+1** |
| **Net** | −1 | −1 + 1 = 0 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕⊕◯◯ LOW** |

> *C1: Low certainty that PTCy reduces overall mortality vs CNI+MTX/MMF (OR 0.77). Large corpus and consistent direction, but substantial heterogeneity and predominantly observational evidence limit confidence. Partial M2 attenuation (0.77→0.83) indicates some steroid-mediated confounding but a probable direct mortality benefit remains.*

> *C2: Low certainty that PTCy reduces overall mortality vs ATG (OR 0.69). The signal is directionally consistent with C1 and survives steroid adjustment (M2 OR 0.78), but the corpus is dominated by a single large registry study and two small outliers inflate frequentist heterogeneity. The Bayesian estimate, which regularises these outliers, is considered more appropriate.*

---

## 2. Non-Relapse Mortality (NRM)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 15, N = 2,081 (PTCy 1,219 / control 862) | k = 5, N = 1,186 |
| **M1** | OR 0.86 [0.70–1.08], P(<1) = 90%, τ = 0.56 | OR 0.65 [0.43–0.97], P(<1) = 98%, τ = 0.38 |
| **M2** | OR 1.02 [0.79–1.33], P(<1) = 43% | OR 0.76 [0.48–1.16], P(<1) = 90% |
| **Attenuation** | Complete (100%) | Substantial (38%) |
| **Frequentist** | OR 0.78 [0.56–1.09], I² = 39% | OR 0.61 [0.39–0.95], I² = 0% |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective/registry; start LOW | All retrospective/registry; start LOW |
| **Risk of bias** | Very serious: complete M2 mediation (0.86→1.02) demonstrates the unadjusted benefit is entirely explainable by differential steroid exposure — a formal confounding signal. **−1** | Serious: M2 attenuation (0.65→0.76) with CrI crossing null. Whether residual benefit at M2 OR 0.76 is genuine or reflects wider uncertainty at k = 5 is indeterminate. **−1** |
| **Inconsistency** | Not serious: I² = 39%. 0 | Not serious: I² = 0%; consistent direction across all five studies. 0 |
| **Indirectness** | Not serious. 0 | Not serious. 0 |
| **Imprecision** | Serious: M1 CrI crosses null; M2 CrI fully crosses; N = 2,081 modest for mortality. **−1** | Serious: k = 5; M1 CrI just excludes null but M2 CrI crosses it. **−1** |
| **Publication bias** | Possible but not formally detectable. 0 | Not assessable at k = 5. 0 |
| **Net** | −2 | −2 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕◯◯◯ VERY LOW** | **⊕◯◯◯ VERY LOW** |

> *C1: Very low certainty. The M1 estimate (OR 0.86) suggests probable benefit, but complete M2 attenuation (OR 1.02) demonstrates this is mediated through reduced steroid exposure. When GVHD prophylaxis load is held constant, no residual NRM benefit is detectable. Any clinical inference should be framed as steroid-mediated and conditional on PTCy's aGVHD benefit.*

> *C2: Very low certainty. The M1 estimate (OR 0.65) is nominally significant, but steroid adjustment attenuates it substantially (M2 OR 0.76), reproducing the C1 mediation pattern. At k = 5, the corpus is too small to determine whether partial vs complete mediation is genuine. Clinical interpretation should mirror C1: the NRM benefit is likely conditional on GVHD prevention.*

---

## 3. Acute GVHD Grade II–IV

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 24, N = 3,837 (PTCy 1,705 / control 1,721) | k = 6, N = 784 |
| **M1** | OR 0.63 [0.54–0.74], P(<1) = 100%, τ = 0.66 | OR 0.59 [0.42–0.84], P(<1) = 99.8%, τ = 0.27 |
| **Frequentist** | OR 0.55 [0.40–0.76], I² = 63% | OR 0.44 [0.22–0.88], I² = 67% |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective/registry; start LOW | All retrospective/registry; start LOW |
| **Risk of bias** | Serious: centre-dependent GVHD grading; possible under-diagnosis in PTCy arms (expectation bias). However, this bias attenuates the effect (conservative estimate). 0 | Same concerns. 0 (direction of bias opposes the effect) |
| **Inconsistency** | Serious: I² = 63%, τ = 0.66 (highest τ of any C1 outcome). **−1** | Moderate: I² = 67% (freq); Bayesian τ = 0.27 but poorly estimated [0.01–0.65]. **−1** |
| **Indirectness** | Not serious. 0 | Not serious: all D+100, standard endpoint. 0 |
| **Imprecision** | Not serious: CrI does not include 1; N = 3,837. 0 | Not serious: CrI 0.42–0.84 entirely below null. 0 |
| **Publication bias** | Not strongly suspected. 0 | Not assessable at k = 6. 0 |
| **Upgrade: confounders oppose** | Partially met: GVHD under-reporting in PTCy arms would bias toward null. **+1** | Same logic, plus cross-comparison coherence with C1 (OR 0.63). **+1** |
| **Net** | −1 + 1 = 0 | −1 + 1 = 0 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕⊕◯◯ LOW** |

> *C1: Low certainty that PTCy reduces aGVHD grade II–IV (OR 0.63). This is the outcome with the strongest mechanistic prior and the most consistent signal. If GVHD under-reporting in PTCy arms exists, the true effect is larger than estimated.*

> *C2: Low certainty that PTCy reduces aGVHD vs ATG (OR 0.59). Point estimate concordant with C1 despite different comparator. The main limitation is poor heterogeneity estimation at k = 6; the direction of plausible bias (GVHD under-diagnosis) would make the true effect larger.*

---

## 4. CMV Any-Reactivation

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 18, N = 3,357 (PTCy 1,039 / control 2,318) | k = 12, N = 1,267 |
| **M1** | OR 1.41 [1.20–1.65], P(>1) = 100%, τ = 0.57 | OR 0.77 [0.60–0.99], P(<1) = 98%, τ = 0.53 |
| **M2** | OR 1.43 [1.18–1.73] (no attenuation) | OR 0.82 [0.64–1.05] (22% attenuation) |
| **M3** | OR 1.52 [1.25–1.87] (no attenuation) | — |
| **Sensitivity** | Post-2020: 1.80 [1.49–2.18]; haplo: 1.70 [1.39–2.10] | Expanded arms: 0.91 [0.75–1.12] |
| **Frequentist** | OR 1.22 [0.87–1.71], I² = 69% | OR 0.67 [0.41–1.09], I² = 67% |
| **Direction** | **PTCy harmful** | **PTCy protective** |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective; start LOW | All retrospective; start LOW |
| **Risk of bias** | Serious: CMV monitoring intensity varies; more surveillance in PTCy arms could inflate ascertainment. Ascertainment bias would overstate PTCy harm. 0 (noted in text) | Serious: monitoring may differ; more surveillance in ATG arms (known CMV risk) could bias toward PTCy protection. 0 (direction uncertain) |
| **Inconsistency** | Serious: I² = 69%; geographic seroprevalence and prophylaxis-era variation. **−1** | Serious: I² = 67%; heterogeneous timepoint mix. **−1** |
| **Indirectness** | Not serious. 0 | Not serious. 0 |
| **Imprecision** | Not serious: CrI 1.20–1.65 does not include 1. 0 | Serious: CrI just excludes null in M1 (0.60–0.99), crosses in M2 (0.64–1.05) and sensitivity (0.75–1.12). Signal is fragile. **−1** |
| **Publication bias** | Not strongly suspected. 0 | Not strongly suspected. 0 |
| **Upgrade: robustness / coherence** | Direction consistent across all 4 sensitivity models (M1 1.41, M2 1.43, M3 1.52, haplo 1.70, post-2020 1.80); steroid-independence confirmed. **+1** | The C2 direction reversal (1.41→0.77 across comparisons) is coherent with the T-cell depletion depth hypothesis. However, the fragility of the C2 point estimate (sensitivity OR 0.91) tempers the upgrade. **+1 (partial)** |
| **Net** | −1 + 1 = 0 | −2 + 1 = −1 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕◯◯◯ VERY LOW** |

> *C1: Low certainty that PTCy increases CMV risk vs CNI+MTX/MMF (OR 1.41). Consistent across 18 studies and robust to all sensitivity analyses. Mediation models confirm the risk is steroid-independent, pointing to direct T-cell reconstitution impairment.*

> *C2: Very low certainty about the magnitude of PTCy's CMV effect vs ATG (OR 0.77). The M1 estimate suggests protection, but the signal is fragile to adjustment and arm classification. The most defensible inference is the direction reversal itself: CMV risk tracks the depth of T-cell depletion (CNI < PTCy < ATG), and this comparative finding has higher certainty than either C2 estimate in isolation.*

---

## 5. Bloodstream Infection (BSI, any pathogen)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 6, N = 1,319 (PTCy 723 / control 596) | k = 3, N = 613 |
| **Estimate** | Bayesian M1: OR 2.39 [1.85–3.10], P(>1) = 100%, τ = 0.64 | MH fixed-effect: OR 2.03 [1.33–3.09], p = 0.001, I² = 69% |
| **Frequentist** | OR 2.45 [1.86–3.21], I² = 0% | (MH is the primary estimate) |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective; start LOW | All retrospective; start LOW |
| **Risk of bias** | Very serious: 7 of 13 eligible studies had NR event counts; retained studies may over-represent high-BSI centres. **−1** | Very serious: definitional heterogeneity (any blood culture vs ICU/fatal only); donor-type confound in dominant study (Meyer 2025: 54% haplo PTCy vs 100% MUD ATG). **−1** |
| **Inconsistency** | Not serious: I² = 0%. 0 | Serious: I² = 69% across only 3 studies, driven by definitional and timepoint differences. **−1** |
| **Indirectness** | Mild concern: BSI definitions varied. 0 | Serious: one study used a restrictive endpoint (ICU/fatal only) not equivalent to standard BSI. 0 (captured under inconsistency) |
| **Imprecision** | Serious: k = 6; wide τ CrI. **−1** | Very serious: k = 3; below conventional GRADE minimum. **−1** |
| **Publication bias** | Suspected: small k. 0 | Not assessable. 0 |
| **Upgrade: large magnitude** | Met: OR 2.39, P(>2) = 91%. **+1** | Not applied: estimate driven by one study with donor-type confound. 0 |
| **Net** | −2 + 1 = −1 | −3 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕◯◯◯ VERY LOW** | **⊕◯◯◯ VERY LOW**‡ |

‡Informal rating; formal GRADE not conventionally performed at k = 3.

> *C1: Very low certainty. The 6-study corpus shows a consistent, large BSI excess (OR 2.39), but 7 additional studies with NR event counts were excluded. The magnitude (OR > 2) warrants clinical attention pending larger analyses.*

> *C2: Very low certainty. Direction consistent with C1 (OR 2.03 vs 2.39), but the corpus comprises three studies that are not measuring the same construct (different definitions, timepoints, and donor-type distributions). Hypothesis-generating only.*

---

## 6. Invasive Fungal Infection (IFI, any) — Comparison 1 Only

**k = 8, N = 3,816 (PTCy 943 / control 2,873)**
**M1: OR 0.73 [0.53–1.00], P(OR < 1) = 97.5% · τ = 1.05**
**LOO excl. Yanada 2026: OR 0.75 [0.54–1.02], τ = 0.38**

*No Comparison 2 data available (k = 4, insufficient for modelling).*

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective; start LOW | — |
| **Risk of bias** | Serious: IFI diagnosis protocol-dependent; PTCy arms may be under-investigated. 0 (bias direction would inflate apparent protection) |
| **Inconsistency** | Very serious: I² = 82%, τ = 1.05; virtually all heterogeneity from one structural-zero study (Yanada 2026). **−2** |
| **Indirectness** | Serious: antifungal prophylaxis regimens heterogeneous and non-randomly distributed. **−1** |
| **Imprecision** | Serious: CrI just touches null; LOO CrI crosses null. **−1** |
| **Publication bias** | Possible at k = 8. 0 |
| **Net** | −4 → floor |

**⊕◯◯◯ CERTAINTY: VERY LOW**

> *Very low certainty. The probable protective signal (OR 0.73) most likely reflects confounding prophylaxis differences (centres using PTCy pair it with prolonged mold-active azole prophylaxis) rather than a direct PTCy immunological effect. The extreme heterogeneity is driven by a single contemporary zero-event cohort.*

---

## Combined Summary Table

| Outcome | Comparison | k | N | OR [95% CrI] | Posterior P | Certainty | Key limitation |
|---|---|---|---|---|---|---|---|
| **OS** | C1 | 35 | 17,661 | 0.77 [0.71–0.83] | P(<1) = 100% | ⊕⊕◯◯ LOW | I² = 68%; obs only |
| | C2 | 10 | 10,624 | 0.69 [0.61–0.78] | P(<1) = 100% | ⊕⊕◯◯ LOW | I² = 90% (freq); one registry dominant |
| **NRM** | C1 | 15 | 2,081 | 0.86 [0.70–1.08] | P(<1) = 90% | ⊕◯◯◯ V. LOW | Complete M2 mediation; CrI crosses null |
| | C2 | 5 | 1,186 | 0.65 [0.43–0.97] | P(<1) = 98% | ⊕◯◯◯ V. LOW | k = 5; M2 attenuation; CrI fragile |
| **aGVHD II–IV** | C1 | 24 | 3,837 | 0.63 [0.54–0.74] | P(<1) = 100% | ⊕⊕◯◯ LOW | I² = 63%; obs only |
| | C2 | 6 | 784 | 0.59 [0.42–0.84] | P(<1) = 100% | ⊕⊕◯◯ LOW | k = 6; τ poorly estimated |
| **CMV** | C1 | 18 | 3,357 | 1.41 [1.20–1.65] | P(>1) = 100% | ⊕⊕◯◯ LOW | I² = 69%; obs only |
| | C2 | 12 | 1,267 | 0.77 [0.60–0.99] | P(<1) = 98% | ⊕◯◯◯ V. LOW | CrI fragile; **direction reversal is the key finding** |
| **BSI** | C1 | 6 | 1,319 | 2.39 [1.85–3.10] | P(>1) = 100% | ⊕◯◯◯ V. LOW | k = 6; 7 studies NR excluded |
| | C2 | 3 | 613 | 2.03 [1.33–3.09]† | p = 0.001 | (⊕◯◯◯) V. LOW‡ | k = 3; definitional heterogeneity |
| **IFI** | C1 | 8 | 3,816 | 0.73 [0.53–1.00] | P(<1) = 97.5% | ⊕◯◯◯ V. LOW | τ = 1.05 (Yanada); CrI ≈ null |
| | C2 | — | — | — | — | — | Insufficient data (k = 4) |

†Mantel-Haenszel fixed-effect. ‡Informal rating.

---

## Overarching GRADE Narrative

Across both comparisons and all outcomes, certainty of evidence does not exceed LOW —
reflecting an evidence base that is almost entirely observational. No completed RCT
powered for any individual outcome exists; the single contributing trial (Curtis 2025)
is one study among 35 in the C1 OS corpus. Despite this, several cross-cutting
observations emerge.

**1. Cross-comparison coherence reduces confounding uncertainty for OS and aGVHD.**
Both outcomes show directionally consistent, mechanistically expected effects across
two comparisons with fundamentally different control regimens (C1: CNI+MTX/MMF; C2: ATG).
The mediation pattern also replicates: OS partially attenuates (29% C1, 35% C2) and
NRM substantially or completely attenuates under steroid adjustment in both comparisons.
This consistency is difficult to explain by a single comparator-specific confounding
structure and strengthens the case that PTCy has a genuine OS and aGVHD benefit,
regardless of comparator.

**2. The CMV direction reversal provides moderate-certainty mechanistic evidence.**
Neither the C1 CMV estimate (OR 1.41, LOW) nor the C2 CMV estimate (OR 0.77, VERY LOW)
individually achieves high certainty. However, the contrast between them — PTCy harmful
vs CNI+MTX/MMF but protective vs ATG — is robust to the specific C2 point estimate: any
C2 value below approximately 1.0 confirms a qualitative direction shift. This
cross-comparison pattern provides moderate-certainty evidence that CMV risk is ordered
by depth of T-cell depletion (CNI-based < PTCy < ATG), even though the component
estimates carry lower individual certainty ratings. The CMV finding is more informative
as a pair of estimates than either is alone.

**3. Infection outcomes remain the principal evidence gap.** BSI and IFI carry VERY LOW
certainty in both comparisons, limited by sparse reporting, definitional heterogeneity,
and confounding by prophylaxis practices. Dedicated prospective studies of infection
outcomes in PTCy vs ATG cohorts — with standardised endpoint definitions — remain a
priority for future evidence generation.

**4. Clinical decision threshold.** For the primary clinical question — should PTCy be
preferred over alternative GVHD prophylaxis platforms — the converging LOW-certainty
evidence for OS benefit (C1 and C2) and aGVHD reduction (C1 and C2) is likely sufficient
to inform guideline recommendations, particularly in haploidentical settings. The CMV
and BSI risk signals should be incorporated into monitoring and prophylaxis guidance but,
at current certainty levels, are insufficient grounds to recommend against PTCy use.

---

*All Bayesian estimates from brms 2.23.0 (rstan backend). Mantel-Haenszel estimate from
metafor 5.0-1. GRADE applied per the GRADE Handbook (Schünemann et al.) and the GRADE
working group guidance for meta-analyses of observational studies.*
