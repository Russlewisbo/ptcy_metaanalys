# Results — Survival Outcomes: Overall Survival and Non-Relapse Mortality
### PTCy vs CNI+MTX/MMF (Comparison 1)
*Draft for manuscript — 2026-05-27*

---

## 3.1  Survival Outcomes

### 3.1.1  Overall Survival

Thirty-five paired studies (k = 35, N = 17,661; PTCy 4,659 / control 13,002) reported
overall survival and met Comparison 1 eligibility. The dataset was dominated by 2-year
follow-up endpoints (k = 22 studies), with 1-year (k = 9) and end-of-followup (k = 4)
supplementing as fallback timepoints under Strategy C priority ordering. One randomised
controlled trial contributed (Curtis 2025, ALLG BM12-CAST, 1-year OS); the remaining
34 studies were retrospective cohorts (k = 26) or registry analyses (k = 8).

The frequentist random-effects estimate (REML) yielded OR 0.75 (95% CI 0.63–0.89),
with substantial between-study heterogeneity (I² = 68%, τ̂ = 0.38, Q-test p < 0.001),
consistent with a probable mortality benefit.

**Direct-effect model (M1).** The Bayesian random-effects model estimated a PTCy OR
of 0.77 (95% CrI 0.71–0.83), with posterior probability P(OR < 1) = 100%. The
posterior is entirely below the null and occupies a range broadly consistent with a
moderate but not dramatic mortality reduction: P(OR < 0.67) < 0.1%, indicating the
evidence does not support a large reduction in mortality risk beyond the OR range observed.
Between-study heterogeneity was moderate-to-substantial (τ = 0.59 [0.46, 0.78]),
reflecting genuine variation in OS across the diverse included cohorts. This is the
most precisely estimated outcome in the meta-analysis, owing to the largest analytic
sample (N = 17,661) and highest k (35 studies).

**GVHD-mediation model (M2).** Adjusting for arm-level systemic steroid exposure
attenuated the PTCy OR from 0.77 to 0.83 (95% CrI 0.75–0.92), a 29% reduction in the
log-OR. P(OR < 1) remained at 100% after adjustment. The steroid covariate itself was
positively and credibly associated with mortality risk (β = 0.012 [0.003, 0.022] per
percentage-point increase in steroid exposure; OR per 10 percentage-point increase:
1.13 [1.02, 1.25]; P[β > 0] = 99.3%), confirming that higher cumulative steroid
burden is associated with greater all-cause mortality — consistent with both GVHD
toxicity and immunosuppression-related mortality pathways.

Critically, 71% of the OS log-OR survives steroid adjustment. This partial attenuation
pattern distinguishes OS from non-relapse mortality (see §3.1.2), where the same
adjustment abolishes the apparent benefit entirely. The residual steroid-independent OS
benefit is consistent with an additional direct contribution of PTCy — most plausibly
via enhanced graft-versus-tumour immune reconstitution in the setting of reduced
alloreactivity, though relapse data would be required to confirm this mechanism.
Between-study heterogeneity was modestly reduced in M2 (τ = 0.54 [0.41, 0.72] vs 0.59
in M1), suggesting steroid exposure explains a small proportion of the cross-study
variance in OS; the majority remains attributable to other factors including transplant
conditioning intensity, disease risk distribution, and era effects.

*[See Table 2, Figure 3 for OS M1 and M2 posterior summaries alongside all other outcomes.]*

---

### 3.1.2  Non-Relapse Mortality

Fifteen paired studies (k = 15, N = 2,081; PTCy 1,219 / control 862) reported
non-relapse mortality for Comparison 1. Two-year endpoints predominated (k = 7),
followed by 1-year (k = 6) and end-of-followup (k = 2). All contributing studies were
observational; no randomised controlled trial had numeric Comparison 1 NRM data.

The frequentist random-effects estimate was OR 0.78 (95% CI 0.56–1.09; I² = 39%,
τ̂ = 0.38, Q-test p = 0.071) — a probable benefit that fell short of conventional
statistical significance. In contrast to OS, heterogeneity was more modest, consistent
with NRM being a more homogeneous endpoint across the observational corpus than
all-cause mortality.

**Direct-effect model (M1).** The Bayesian model yielded a PTCy OR of 0.86 (95% CrI
0.70–1.08), with P(OR < 1) = 90.3%. The posterior is largely below null — a probable
NRM benefit — but the 95% CrI crosses 1.0, reflecting genuine uncertainty. P(OR < 0.67)
is 1.0%, indicating that a substantial absolute NRM reduction is not well supported.
Between-study heterogeneity was moderate (τ = 0.56 [0.35, 0.89]).

**GVHD-mediation model (M2) — the centrepiece finding.** Adjusting for arm-level
steroid exposure produced a near-complete attenuation of the NRM benefit: M2 OR 1.02
(95% CrI 0.79–1.33), P(OR < 1) = 43%. The posterior probability of NRM benefit
collapses from 90% in M1 to the prior expectation of chance (43%) in M2. This
represents complete mediation: once the steroid burden differential between arms is
accounted for, there is no detectable residual PTCy effect on non-relapse mortality.

The steroid covariate was credibly associated with NRM in both directions (β = 0.022
[0.005, 0.036]; OR per 10 percentage-point increase: 1.25 [1.05, 1.44]; P[β > 0] =
99.5%), consistent with the mechanistic expectation that higher steroid exposure —
driven by GVHD treatment requirements — increases TRM. Between-study heterogeneity
was substantially reduced in M2 compared with M1 (τ = 0.40 [0.17, 0.72] vs 0.56),
indicating that steroid exposure differences between study arms explain a meaningful
proportion of the cross-study variance in NRM — more so than for OS.

The contrast between OS and NRM in the M1→M2 comparison is the single most
interpretable finding in the mediation analysis. For OS, the benefit survives steroid
adjustment (OR 0.77→0.83, 71% of log-OR retained), implying that PTCy's survival
advantage is only partially mediated through the GVHD–steroid pathway and that
an independent mechanism contributes. For NRM, no such residual signal persists
(OR 0.86→1.02, complete attenuation), consistent with the hypothesis that PTCy reduces
non-relapse deaths exclusively by preventing GVHD and the steroid-mediated toxicity
cascade it triggers. These divergent patterns are detailed further in the Discussion
(§4.2).

*[See Table 2, Figure 3 for NRM M1 and M2 posterior summaries.]*

---

### 3.1.3  Context: aGVHD Grade II–IV as the Mechanistic Linchpin

Although reported in full in §3.2, the aGVHD finding warrants brief introduction here
because it provides the mechanistic foundation for interpreting the NRM complete
mediation. Across 24 paired studies (k = 24, N = 3,837), PTCy was associated with a
37% reduction in the odds of aGVHD grade II–IV (M1 OR 0.63 [0.54, 0.74], P[OR < 1] =
100%). This is the largest treatment effect estimated across all six primary outcomes
and is mechanistically expected given PTCy's mode of action. The NRM mediation finding
is most parsimoniously interpreted as the downstream consequence of this aGVHD
suppression: PTCy → fewer aGVHD episodes → less steroid treatment → lower TRM. The
residual OS benefit — which survives the same steroid adjustment — is therefore likely
attributable to a mechanism downstream of GVHD prevention itself, such as preserved
graft-versus-tumour activity or faster immune reconstitution in a less
immunosuppressed host.

---

## Summary of §3.1

| Outcome | k | N | Frequentist OR (95% CI) | Bayesian M1 OR (95% CrI) | P(directional) | M2 OR (95% CrI) | Attenuation |
|---|---|---|---|---|---|---|---|
| Overall survival | 35 | 17,661 | 0.75 (0.63–0.89) | **0.77 (0.71–0.83)** | P(<1) = **100%** | 0.83 (0.75–0.92) | Partial (29%) |
| Non-relapse mortality | 15 | 2,081 | 0.78 (0.56–1.09) | **0.86 (0.70–1.08)** | P(<1) = 90% | 1.02 (0.79–1.33) | **Complete** |

The OS signal is the most precisely estimated outcome in the full analysis, supported
by the largest patient population (N = 17,661) and the only contributing RCT. The NRM
signal, while uncertain on its own (90% posterior probability, CrI crossing null), is
transformed by the M2 mediation analysis into a mechanistically interpretable finding:
the NRM benefit observed in M1 is almost entirely a downstream consequence of aGVHD
reduction and its effect on steroid exposure, rather than a direct PTCy-driven
reduction in treatment-related toxicity.
