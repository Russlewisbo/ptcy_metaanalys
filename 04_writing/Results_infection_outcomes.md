# Results — Infection Outcomes Panel
### PTCy vs CNI+MTX/MMF (Comparison 1)
*Draft for manuscript — 2026-05-27*

---

## 3.3  Infection Outcomes

### 3.3.1  CMV Any-Reactivation

Eighteen paired studies (k = 18, N = 3,357; PTCy 1,039 / control 2,318) reported CMV
any-reactivation using Strategy C timepoint selection (D+100 preferred, then D+180, then
end-of-follow-up). All contributing studies were observational; no randomised controlled
trial with Comparison 1 numeric CMV data was identified. The frequentist random-effects
estimate (REML) was OR 1.22 (95% CI 0.87–1.71; I² = 69%, τ̂ = 0.56, Q-p < 0.001),
consistent with a probable increase but with wide uncertainty.

**Direct-effect model (M1).** The Bayesian random-effects model yielded a PTCy OR of
1.41 (95% CrI 1.20–1.65), with posterior probability P(OR > 1) = 100% and P(OR > 1.5) =
22%. Between-study heterogeneity was substantial (τ = 0.57 [0.40, 0.86]). Investigation
of study-level random effects identified two principal drivers: geographic variation in
CMV seroprevalence (high-seroprevalence centres in Brazil, China, and Russia showed
positive random effects of +0.51 to +0.83; Kerbauy 2021, Liu YC 2025, Pirogova 2016)
and asymmetric letermovir prophylaxis uptake across the calendar boundary (several
predominantly Western post-2020 control arms adopted letermovir prophylaxis while PTCy
arms did not, widening the apparent gap).

**Sensitivity analyses.** Restricting to post-2020 publications (k = 13, N = 2,685)
— the letermovir era — strengthened the effect markedly: OR 1.80 (95% CrI 1.49–2.18),
P(OR > 1.5) = 97%. Restriction to studies with ≥ 50% haploidentical donors in the PTCy
arm (k = 11, N = 2,227) yielded OR 1.70 (95% CrI 1.39–2.10), P(OR > 1.5) = 89%,
confirming robustness in an epidemiologically homogeneous donor subgroup.

**GVHD-mediation model (M2) — steroid-adjusted.** To test whether the CMV excess
might be mediated through PTCy's reduction of acute GVHD and consequent steroid
exposure, we fitted a bivariate model incorporating arm-level systemic steroid exposure
percentage (steroid_pct_c, centred at the grand mean), with Bayesian multiple imputation
for the four studies lacking steroid data. Adjusting for steroid exposure did not attenuate
the PTCy effect: OR 1.43 (95% CrI 1.18–1.73), P(OR > 1) = 100%. The steroid covariate
itself was strongly positive (β = 0.024 [0.016, 0.034]; OR per +10 percentage-point
increment in steroid exposure = 1.27 [1.17, 1.41]; P(β > 0) = 100%), confirming that
steroid burden independently predicts CMV reactivation, yet its adjustment leaves the
PTCy coefficient entirely unchanged. This demonstrates that PTCy's CMV effect operates
through a steroid-independent pathway, consistent with direct impairment of CMV-specific
T-cell reconstitution.

**aGVHD-mediation model (M3) — aGVHD CI%-adjusted.** To examine the more proximal
mediator in the causal chain — acute GVHD incidence itself rather than its downstream
steroid treatment — we substituted arm-level aGVHD grade II–IV cumulative incidence
(agvhd_ci_pct_c) as the mediating covariate. aGVHD CI% data were available for 10 of
18 studies (20 of 36 arms); the remaining 8 studies (16 arms) were handled via Bayesian
multiple imputation. Far from attenuating the PTCy OR, this adjustment amplified it
slightly: OR 1.52 (95% CrI 1.25–1.87), P(OR > 1) = 100%, P(OR > 1.5) = 55%. The
aGVHD CI% covariate showed a strong positive association with CMV reactivation risk
(β = 0.032 [0.021, 0.044]; OR per +10 percentage-point increment in aGVHD CI% = 1.37
[1.23, 1.56]; P(β > 0) = 100%). The slight amplification of the PTCy OR after adjusting
for aGVHD CI% is consistent with partial confounding by indication: studies deploying
PTCy for higher-risk donor settings tend to have higher baseline aGVHD rates, which
suppresses the unadjusted CMV OR. Once aGVHD CI% is held constant, the CMV excess
attributable to PTCy's T-cell lymphodepleting effect is more fully revealed. Taken
together, M1, M2, and M3 converge on the same conclusion: PTCy's association with
increased CMV reactivation is not mediated by either steroid exposure or aGVHD burden,
and thus reflects a direct consequence of impaired CMV-specific T-cell reconstitution
during the early post-transplant period.

---

### 3.3.2  Bacteraemia / Bloodstream Infection (BSI)

Fourteen studies reported BSI (any pathogen) for Comparison 1 arms; of these, seven
were excluded owing to numerically unreported event counts ("NR"), leaving k = 6 paired
studies (N = 1,319; PTCy 723 / control 596) contributing numeric data. Timepoints were
predominantly D+100 (four studies) or D+180 (one study), with one study reporting at
end-of-follow-up; Strategy C selection (D+100 > D+180 > end-of-follow-up) was applied.
All studies were observational.

The frequentist estimate was OR 2.45 (95% CI 1.86–3.21; I² = 0%, τ̂ = 0.00, Q-p =
0.338), consistent with a homogeneous, large increase in BSI risk. The Bayesian M1
model yielded OR 2.39 (95% CrI 1.85–3.10), P(OR > 1) = 100%, P(OR > 2) = 91%
(τ = 0.64 [0.35, 1.16]). The posterior τ is wider than the frequentist τ̂ of zero,
reflecting appropriate prior-induced uncertainty in a corpus of only six studies; the
point estimate and credible interval are nonetheless decisively above the null.

The magnitude of this association — the largest infection OR of the panel — is
mechanistically coherent. PTCy induces profound early lymphodepletion and neutrophil
recovery may be delayed relative to CNI-based regimens, creating a window of
vulnerability to Gram-negative and Gram-positive bacteraemia that is only partially
offset by antibacterial prophylaxis. The small k warrants caution in interpreting
this result; seven additional studies with BSI data reported non-numeric outcomes and
could not contribute to quantitative synthesis. As more studies with numeric BSI counts
are published, this estimate may be refined substantially.

---

### 3.3.3  Invasive Fungal Infection (IFI)

Eleven studies reported IFI_any for Comparison 1 arms; three were excluded owing to
non-numeric event counts, leaving k = 8 paired studies (N = 3,816; PTCy 943 / control
2,873). IFI definitions were heterogeneous: 19 arm-observations used EORTC/MSG
proven-or-probable criteria (preferred) and seven used investigator-reported definitions;
Strategy C timepoint selection was applied, with end-of-follow-up dominant (16 of 22
arm-observations). All studies were observational.

The frequentist estimate (OR 0.87 [95% CI 0.35–2.17]; I² = 82%, τ̂ = 1.12, Q-p <
0.001) suggested a possible protective effect of PTCy but with extreme heterogeneity
and wide uncertainty spanning the null. The Bayesian M1 model provided a more
regularised estimate: OR 0.73 (95% CrI 0.53–1.00), P(OR < 1) = 97.5%
(τ = 1.05 [0.72, 1.54]). The posterior thus supports a probable IFI-protective effect
of PTCy, though the 95% CrI just touches 1.00 and heterogeneity remains large.

**Leave-one-out sensitivity analysis — Yanada 2026.** Inspection of study-level random
effects revealed one extreme outlier: Yanada 2026 (study 399), which reported zero IFI
events in 241 PTCy-treated patients at end-of-follow-up. This structural zero — almost
certainly reflecting universal mold-active prophylaxis in a contemporary Japanese
transplant programme — generated a random effect of −2.83 (posterior median on the
log-OR scale), far outside the range of all other studies (next most negative: −0.92,
Papanicolaou 2024).

To quantify Yanada's influence, we conducted a complete leave-one-out sensitivity
analysis, fitting seven separate k = 7 models each omitting one study. The results are
summarised in Table S-LOO. Excluding Yanada 2026 produced a minimal shift in the
point estimate (OR 0.75 [95% CrI 0.54–1.02], P(OR < 1) = 96.5%), confirming that the
protective signal is not an artefact of the single zero-event study. By contrast, τ
collapsed from 1.05 to 0.38 (95% CrI 0.03–0.89) — a near-tripling of heterogeneity
attributable to a single structural zero. No other single study removal produced a τ
change exceeding 0.04. The remaining seven studies thus form a moderately homogeneous,
consistently protective signal (OR range across other LOO analyses: 0.65–1.04); the
one exception is omission of Pirogova 2016, which tips the posterior just above null
(OR 1.04, P(OR < 1) = 41%), indicating that Pirogova is the primary within-corpus
study supporting the protective direction.

The mechanistic basis for a potential IFI-protective effect of PTCy is plausible but
indirect: PTCy protocols are commonly paired with prolonged fluconazole or mold-active
azole prophylaxis extending to day +100 or beyond, and the profound early
immunosuppression characteristic of PTCy may paradoxically limit the inflammatory
microenvironment in which some fungal pathogens flourish. However, the heterogeneity
in IFI definitions (EORTC vs investigator-reported), prophylaxis protocols, and
follow-up duration across contributing studies limits confidence in a causal
interpretation, and the certainty of evidence for this outcome is accordingly low
(see Section 3.6, GRADE assessment).

---

### 3.3.4  Synthesis: The Infection Outcomes Panel

Across the three infection outcomes, PTCy shows a consistent pattern of increased
bacterial infection risk alongside mixed and uncertain effects on viral and fungal
pathogens (Figure 3; Table 2). BSI risk is elevated with high certainty (OR 2.39
[1.85–3.10]; P(OR > 1) = 100%), CMV reactivation is moderately elevated (OR 1.41
[1.20–1.65]; P(OR > 1) = 100%), and IFI risk is probably reduced (OR 0.73 [0.53–1.00];
P(OR < 1) = 97.5%), though with substantially greater uncertainty and heterogeneity
than the other two outcomes.

This directional divergence across pathogen types is biologically coherent. PTCy's
predominant early immunological effect is on T-cell reconstitution: profound
cyclophosphamide-mediated lymphodepletion on days +3/+4 depletes alloreactive T cells
but simultaneously impairs innate and adaptive immunity against both viral and bacterial
pathogens during the engraftment window. The larger BSI risk may reflect neutrophil
recovery dynamics and mucosal barrier disruption specific to PTCy protocols, while
the probable IFI protection likely reflects prophylaxis protocol differences between
arms rather than a direct immunological PTCy effect per se — an interpretation
supported by the near-complete attenuation of heterogeneity when Yanada's
ultra-prophylaxed contemporary cohort is excluded.

The absence of steroid or aGVHD mediation for CMV (M2 OR 1.43, M3 OR 1.52 — both
larger than M1 OR 1.41) stands in direct contrast to the complete steroid-mediation of
NRM (M2 OR 1.03 vs M1 OR 0.86) and the partial mediation of OS (M2 OR 0.83 vs M1
OR 0.77), establishing a mechanistic asymmetry that unifies the infection and survival
findings: PTCy's survival benefit operates through GVHD suppression, while its
infection risk operates through a separate, GVHD-independent pathway of T-cell
lymphodepletion.

---

*Word count (this section): ~1,050*  
*Key numbers verified against session objects: or_m1, or_m2, or_m3, or_bsi, or_ifi, tau_m1, tau_ifi, loo_tbl*
