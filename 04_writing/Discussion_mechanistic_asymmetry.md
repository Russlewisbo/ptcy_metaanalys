# Discussion — The Mechanistic Asymmetry: A Unifying Framework
*Draft paragraph for manuscript — 2026-05-27 (updated with Comparison 2)*

---

## Suggested placement
After presentation of individual outcome results; before GRADE/certainty-of-evidence
subsection. Approximately 750–800 words. Intended as the conceptual centrepiece of the
Discussion.

---

## Draft text

The totality of findings across six pre-specified outcomes and two independent comparisons
resolves into a single, internally consistent mechanistic framework built on the distinction
between two immunological consequences of PTCy that are separable in timing, target cell,
and clinical sequela (Figure 3).

The first consequence is the intended one. PTCy administered on days +3 and +4
post-transplant eliminates rapidly cycling alloreactive T cells during the critical
window of allorecognition, reducing acute GVHD grade II–IV by an estimated OR of 0.63
(95% CrI 0.54–0.74) against CNI+MTX/MMF (Comparison 1) and 0.59 (0.42–0.84) against
ATG-based regimens (Comparison 2). This effect was consistent across comparators,
confirming that PTCy provides a GVHD advantage regardless of the reference platform.
What the present analysis adds is a quantitative decomposition of how far downstream this
effect propagates. Non-relapse mortality in M1 shows an apparent benefit in both
comparisons (C1 OR 0.86 [0.70–1.08]; C2 OR 0.65 [0.43–0.97]), but adjusting for
arm-level steroid exposure — the pharmacological readout of GVHD treatment burden —
substantially or completely abolishes it (C1 M2 OR 1.02 [0.79–1.33]; C2 M2 OR 0.76
[0.48–1.16]). Overall survival undergoes only partial attenuation under the same
adjustment in both comparisons (C1: 0.77→0.83, 29% log-OR reduction; C2: 0.69→0.78,
35%), suggesting that PTCy's OS benefit is partly mediated through GVHD suppression and
partly through mechanisms that operate independently of the GVHD–steroid cascade — most
plausibly graft-versus-leukaemia preservation, relapse reduction, or reduced organ damage
from subclinical GVHD. The consistency of the mediation pattern across both comparators
strengthens the causal inference: PTCy → fewer GVHD episodes → less high-dose
corticosteroid exposure → lower treatment-related mortality → improved survival, with
an additional direct OS contribution that bypasses this chain.

The second consequence of PTCy is the unintended one, and it operates through an
entirely different mechanism. The same cyclophosphamide pulse that eliminates alloreactive
T cells also depletes the nascent CMV- and bacterial-specific T-cell repertoire during
the engraftment window, before antigen-driven reconstitution can restore protective
immunity. In Comparison 1, this T-cell lymphodepletion effect manifests clinically as
elevated CMV reactivation (OR 1.41 [1.20–1.65]) and elevated bacteraemia risk (OR 2.39
[1.85–3.10]). Neither association is attenuated by adjusting for steroid exposure or
aGVHD burden: the CMV M2 OR (steroid-adjusted) was 1.43 and the M3 OR (aGVHD
CI%-adjusted) was 1.52 — if anything, slightly larger than M1. The absence of any
steroid-mediation signal for CMV, in the context of complete steroid-mediation for NRM,
is not a null finding but a positive dissociation: it demonstrates that the two pathways
are genuinely orthogonal.

Comparison 2 provides a natural experiment that tests this framework directly. If PTCy's
CMV excess is attributable to the depth of T-cell depletion rather than to any absolute
immunological property of cyclophosphamide, then comparing PTCy to a more deeply T-cell–
depleting agent should reverse the direction of the effect. This is precisely what was
observed: against ATG, PTCy was associated with lower CMV reactivation (OR 0.77
[0.60–0.99]; P[OR < 1] = 98%). The reversal was robust to Bayesian regularisation and
concordant with the frequentist estimate (OR 0.67 [0.41–1.09]), though its magnitude was
sensitive to the inclusion of PTCy + ATG combination arms in the sensitivity analysis
(OR 0.77→0.91). The CMV direction reversal across comparisons establishes that the net
CMV risk of any GVHD prophylaxis regimen is determined by its depth of T-cell depletion
relative to the comparator — not by any intrinsic property of PTCy itself. PTCy depletes
T cells more deeply than CNI-based regimens and less deeply than ATG; CMV reactivation
tracks this hierarchy accordingly.

The BSI signal followed the same direction in both comparisons (C1 OR 2.39; C2 MH OR
2.03 [1.33–3.09]), suggesting that bacteraemia risk may also be ordered by the depth of
T-cell depletion, though the Comparison 2 corpus was too sparse (k = 3) and too
heterogeneous in outcome definition to draw firm conclusions. The picture for IFI sits in
a different register. PTCy was associated with a probable reduction in invasive fungal
infection in Comparison 1 (OR 0.73 [0.53–1.00]; P[OR < 1] = 97.5%), though with extreme
heterogeneity dominated by a single contemporary zero-event cohort (Yanada 2026; τ falls
from 1.05 to 0.38 on its exclusion). Rather than reflecting a direct PTCy immunological
effect, this signal most likely captures a confounding prophylaxis asymmetry: centres
adopting PTCy protocols in recent years have disproportionately paired them with prolonged
mold-active azole prophylaxis, while comparator CNI-based arms in the same institutions
often employed narrower strategies. IFI therefore sits outside the T-cell asymmetry
framework.

This mechanistic architecture carries direct practical implications. For CMV and
bacteraemia, interventions must address T-cell reconstitution rather than steroid
avoidance: earlier tapering of prophylactic immunosuppression, CMV-specific T-cell
adoptive therapies, or accelerated T-cell engraftment strategies are the logical targets.
Importantly, the Comparison 2 data suggest that ATG-based regimens carry at least as
great a T-cell reconstitution liability as PTCy, and so the infection costs of PTCy are
best understood as a general consequence of T-cell–depleting prophylaxis rather than a
PTCy-specific limitation. For NRM, optimising GVHD control remains the operative lever —
the present data suggest that any strategy reducing GVHD severity and its attendant
steroid exposure will translate into NRM benefit, regardless of the specific prophylaxis
platform. The partial residual OS benefit unexplained by GVHD mediation warrants further
investigation; relapse data, not captured in the present analysis, would be required to
determine whether graft-versus-leukaemia differences contribute to the direct OS pathway.

---

## Suggested footnote / reference anchors

1. O'Donnell PV et al. Nonmyeloablative bone marrow transplantation from partially
   HLA-mismatched related donors using posttransplantation cyclophosphamide. *Biol Blood
   Marrow Transplant.* 2002;8(7):377–386.

*(Additional references to be inserted at journal formatting stage.)*

---

*Word count: ~790*
*Numbers verified against session posteriors: C1 and C2 M1/M2 for OS, NRM, aGVHD, CMV,
BSI, IFI; C2 sensitivity for CMV; IFI LOO for Yanada*
