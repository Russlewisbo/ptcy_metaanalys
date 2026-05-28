# Results — Comparison 2: PTCy vs ATG-Based GVHD Prophylaxis
### PTCy vs ATG (Comparison 2)
*Draft for manuscript — 2026-05-27*

---

## 3.4  PTCy versus ATG-Based Prophylaxis

### 3.4.1  Study Selection and Analytic Sample

Of 101 arms labelled Comparison 2–eligible in the extraction database, 82 arms (42 PTCy-only, 40 ATG-only) from 40 paired studies were retained for the primary analysis. Twelve arms were excluded from primary models: seven using PTCy + ATG in combination, two with mixed ATG classification, and three using neither agent. Seven additional arms from unpaired single-side studies were similarly excluded. All excluded arms were retained for sensitivity analysis (§3.4.7). BSI (k = 3) and IFI (k = 4) had insufficient paired studies for Bayesian random-effects modelling; BSI was pooled descriptively via Mantel-Haenszel (§3.4.6).

All models shared the prior specification, binomial family, and MCMC configuration used for Comparison 1 (4 chains × 3,000 post-warmup draws; §2.x). All converged without divergent transitions; maximum R̂ ≤ 1.005 across all parameters.

### 3.4.2  Overall Survival

Ten paired studies (k = 10, N = 10,624) contributed overall survival data, with 2-year follow-up predominating (k = 7), supplemented by 1-year (k = 2) and end-of-follow-up (k = 1) under the Strategy C priority ordering. All contributing studies were observational. The frequentist random-effects estimate (REML) was OR 0.53 (95% CI 0.29–0.96; I² = 90%, τ̂ = 0.85, Q-p < 0.001). The high I² was driven by two small studies with extreme effect sizes (Dybko 2024, OR 0.07, n = 60; Nykolyszyn 2020, OR 0.17, n = 62), while Penack 2024 (n = 8,764) carried 72% of inverse-variance weight.

**Direct-effect model (M1).** The Bayesian random-effects model estimated a PTCy OR of 0.69 (95% CrI 0.61–0.78), with P(OR < 1) = 100% and between-study heterogeneity τ = 0.56 [0.35, 0.96]. The posterior is entirely below the null, indicating a consistent OS advantage for PTCy over ATG-based regimens. The Bayesian estimate is more conservative (closer to the null) than the frequentist point estimate, reflecting regularisation of the outlier-driven heterogeneity via the half-normal τ prior. Both methods agree on direction and statistical significance.

**GVHD-mediation model (M2).** Adjusting for arm-level systemic steroid exposure attenuated the PTCy OR from 0.69 to 0.78 (95% CrI 0.68–0.90), a 35% reduction in the log-OR. P(OR < 1) remained at 99.9% after adjustment. The steroid covariate was positively associated with mortality (β = 0.037 per percentage-point, 95% CrI 0.019–0.055; OR per 10 percentage-point increase: 1.44), indicating that part of the OS advantage reflects lower GVHD-driven steroid exposure. A substantial residual benefit persisted, however, suggesting that GVHD mediation does not fully account for the survival advantage — a pattern paralleling the partial attenuation observed in Comparison 1 (C1 M1 OR 0.77 → M2 OR 0.83, 29% attenuation).

*[See Table X, Figure X for OS posteriors alongside other Comparison 2 outcomes.]*

---

### 3.4.3  Non-Relapse Mortality

Five paired studies (k = 5, N = 1,186) contributed NRM data. The frequentist estimate was OR 0.61 (95% CI 0.39–0.95; I² = 0%, τ̂ = 0). The near-zero frequentist heterogeneity contrasts with the Bayesian τ estimate (below), reflecting the limited ability of five studies to inform the heterogeneity parameter.

**Direct-effect model (M1).** OR 0.65 (95% CrI 0.43–0.97), P(OR < 1) = 98.2%, τ = 0.38 [0.02, 0.69]. The posterior favours PTCy, with the upper bound of the CrI just excluding the null. The point estimate suggests a larger NRM reduction than observed in Comparison 1 (C1 M1 OR 0.86 [0.70, 1.08]), though the smaller corpus limits the precision of this comparison.

**GVHD-mediation model (M2).** Steroid adjustment attenuated the OR to 0.76 (95% CrI 0.48–1.16), P(OR < 1) = 90%, a 38% reduction in the log-OR. The CrI now crosses the null, consistent with substantial GVHD-mediated confounding of the NRM signal. This mirrors the complete mediation observed in Comparison 1 (C1 M1 OR 0.86 → M2 OR 1.02), though the attenuation here is partial rather than total, possibly reflecting the greater statistical uncertainty at k = 5 rather than a genuine difference in the mediation structure.

*[See Table X.]*

---

### 3.4.4  Acute GVHD Grade II–IV

Six paired studies (k = 6, N = 784) reported aGVHD grade II–IV at D+100. The frequentist estimate was OR 0.44 (95% CI 0.22–0.88; I² = 67%, τ̂ = 0.70).

**Direct-effect model (M1).** OR 0.59 (95% CrI 0.42–0.84), P(OR < 1) = 99.8%, τ = 0.27 [0.01, 0.65]. PTCy was associated with lower aGVHD risk compared to ATG, with the Bayesian point estimate regularised toward the null relative to the frequentist one — a consequence of the τ prior dampening the influence of small, extreme studies. Between-study heterogeneity was low by Bayesian estimation. The magnitude of the aGVHD effect is comparable to Comparison 1 (C1 OR 0.63 [0.54, 0.74], k = 24), though estimated less precisely.

No M2 model was fitted for aGVHD, as it serves as the upstream mediator in the causal framework rather than a downstream outcome of steroid exposure.

*[See Table X.]*

---

### 3.4.5  CMV Any-Reactivation

Twelve paired studies (k = 12, N = 1,267) contributed CMV any-reactivation data under Strategy C timepoint selection (D+100, k = 3; 1-year, k = 3; end-of-follow-up, k = 6). All studies were observational. The frequentist estimate was OR 0.67 (95% CI 0.41–1.09; I² = 67%, τ̂ = 0.68, Q-p < 0.001).

**Direct-effect model (M1).** OR 0.77 (95% CrI 0.60–0.99), P(OR < 1) = 98%, τ = 0.53 [0.30, 0.93]. PTCy was associated with lower CMV reactivation than ATG. This represents a reversal of direction compared to Comparison 1, where PTCy was associated with higher CMV risk relative to CNI+MTX/MMF (C1 OR 1.41 [1.20, 1.65]). The cross-comparison contrast is discussed in §3.4.8 and §4.x.

**GVHD-mediation model (M2).** Steroid adjustment modestly attenuated the OR to 0.82 (95% CrI 0.64–1.05), P(OR < 1) = 94%, a 22% log-OR reduction. The steroid coefficient was small and the CrI included zero (β = 0.011 [−0.002, 0.024] per percentage-point), suggesting steroid exposure is a less important confounder in the PTCy–CMV relationship in this comparison than for survival outcomes. After adjustment, the CrI crossed the null, and so a steroid-independent CMV advantage for PTCy over ATG cannot be confirmed with high confidence at the current corpus size.

*[See Table X.]*

---

### 3.4.6  Bloodstream Infections (Descriptive Supplement)

Only three paired studies reported BSI event counts in Comparison 2, precluding Bayesian random-effects modelling. A Mantel-Haenszel fixed-effect analysis yielded OR 2.03 (95% CI 1.33–3.09, p = 0.001), nominally suggesting higher BSI risk with PTCy — the same direction as Comparison 1 (C1 OR 2.39 [1.85, 3.10], k = 6). However, heterogeneity was substantial (I² = 69%, Tarone's p = 0.036) and was attributable to three identifiable sources.

First, outcome definitions differed: Meyer 2025 and Berro 2021 used any positive blood culture, while Bordat 2026 restricted to severe infections requiring intensive care or resulting in death. The two standard-definition studies showed a PTCy excess (OR 3.27 and 1.35, respectively), while the restrictive-definition study did not (OR 0.91). Second, timepoints differed: Meyer and Berro reported at D+100, Bordat at 1 year. Third, a donor-type imbalance was present in the dominant study: Meyer 2025 (carrying 72% of the pooled weight) had 54% haploidentical donors in the PTCy arm versus 100% matched unrelated donors in the ATG arm, a confound that may inflate the apparent PTCy BSI excess independently of GVHD prophylaxis. The two studies with matched donor types (Berro: MRD/MRD; Bordat: MRD/MRD) showed attenuated or absent effects.

Given the definitional heterogeneity, timepoint mismatch, and donor-type confounding, this result should be regarded as hypothesis-generating rather than confirmatory.

---

### 3.4.7  Sensitivity Analysis: Expanded Arm Inclusion

To assess robustness to arm classification, we reclassified the 12 excluded arms: PTCy + ATG combination arms (n = 7) were assigned to the PTCy side; mixed-ATG arms (n = 2) were classified by whether PTCy was co-administered; and three arms using neither PTCy nor ATG were excluded as uninformative for this comparison. The reclassification rendered six previously unpaired studies eligible.

| Outcome | Primary OR [95% CrI] | Sensitivity OR [95% CrI] | k (primary → sens.) | Interpretation |
|---|---|---|---|---|
| OS | 0.69 [0.61, 0.78] | 0.74 [0.66, 0.83] | 10 → 11 | Robust; slight attenuation |
| aGVHD II–IV | 0.59 [0.42, 0.84] | 0.59 [0.45, 0.78] | 6 → 8 | Robust; CrI narrows |
| CMV | 0.77 [0.60, 0.99] | 0.91 [0.75, 1.12] | 12 → 14 | Attenuated; CrI crosses null |
| NRM | 0.65 [0.43, 0.97] | — | 5 → 5 | Unchanged (no new data) |

OS and aGVHD were robust to arm reclassification. CMV was the most sensitive outcome: the OR shifted from 0.77 to 0.91 and P(OR < 1) decreased from 98% to 82%. This is expected, as PTCy + ATG combination arms — now classified on the PTCy side — likely carry higher CMV reactivation risk than pure PTCy arms, diluting the apparent advantage over ATG.

---

### 3.4.8  Cross-Comparison Synthesis

Table X juxtaposes the primary (M1) posteriors across Comparisons 1 and 2.

| Outcome | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG | Direction |
|---|---|---|---|
| Overall survival | 0.77 [0.71, 0.83] (k = 35) | 0.69 [0.61, 0.78] (k = 10) | PTCy favoured in both |
| Non-relapse mortality | 0.86 [0.70, 1.08] (k = 15) | 0.65 [0.43, 0.97] (k = 5) | PTCy favoured in both |
| aGVHD grade II–IV | 0.63 [0.54, 0.74] (k = 24) | 0.59 [0.42, 0.84] (k = 6) | PTCy favoured in both |
| CMV any-reactivation | 1.41 [1.20, 1.65] (k = 18) | 0.77 [0.60, 0.99] (k = 12) | **Reversal** |
| BSI any pathogen | 2.39 [1.85, 3.10] (k = 6) | 2.03 [1.33, 3.09]† (k = 3) | PTCy disfavoured in both |

†Mantel-Haenszel fixed-effect estimate; see §3.4.6 for caveats regarding definitional heterogeneity.

PTCy was associated with consistent survival and GVHD advantages regardless of comparator. The steroid-mediation pattern was also consistent: OS benefit partially attenuated (35% C2, 29% C1), while NRM benefit was substantially or completely mediated in both comparisons.

The notable exception is CMV reactivation, which reversed direction across comparisons. PTCy was associated with increased CMV risk relative to CNI+MTX/MMF (C1) but decreased risk relative to ATG (C2). The BSI signal was consistent in direction but should be interpreted with caution given the sparse and heterogeneous Comparison 2 corpus. Mechanistic implications of the CMV reversal are discussed in §4.x.

*[See Figure X for the combined Comparison 1 vs Comparison 2 forest plot.]*
