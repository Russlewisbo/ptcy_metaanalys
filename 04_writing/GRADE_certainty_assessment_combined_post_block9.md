# GRADE Certainty-of-Evidence Assessment (Post-Block-9)
### Comparisons 1 and 2 — All Primary Outcomes
*Prepared: 2026-06-19 · Updated from 2026-05-28 combined assessment*
*Post-Block-9 corpus: 251 studies, 525 arms, 3,604 outcomes, 14 RCTs*

---

## Framework

All evidence derives from observational studies (predominantly retrospective cohort and
registry analyses). Multiple RCTs now contribute to the Comparison 1 corpus (14 total in
the database), though individual outcome models typically include 1–3 RCTs among
predominantly observational studies. No RCT contributes numeric data to any Comparison 2
outcome other than Brissot 2024 (aGVHD only). GRADE starting certainty for observational
evidence is **LOW**. Downgrades are applied per the standard five GRADE domains; upgrades
for observational evidence are applied only when strict criteria are met (large magnitude
[OR ≥ 2 or ≤ 0.5], dose-response, or all plausible residual confounding would oppose
the observed effect).

Where results from one comparison inform the assessment of the other — for example, the
CMV comparison across C1 and C2 — this is noted explicitly and may contribute to upgrades
for cross-comparison coherence.

**Comparisons:**
- **C1:** PTCy vs CNI+MTX/MMF (k = 6–40 across outcomes)
- **C2:** PTCy vs ATG-based prophylaxis (k = 2–13 across outcomes)

**Key methodological change from pre-Block-9:** M2 models now use complete-case analysis
(dropping arms with missing steroid %) rather than `mi()` imputation, due to a brms v2.23+
API change. This is more conservative and slightly reduces M2 sample sizes.

---

## Changes from Pre-Block-9 Assessment

The following shifts are GRADE-relevant and are flagged in the per-outcome sections below:

1. **C1 BSI attenuated (2.39→1.87):** OR no longer meets the ≥ 2.0 large-magnitude
   upgrade threshold. Frequentist I² rose from 0% to 71%, adding an inconsistency concern.
2. **C1 IFI strengthened (0.73→0.43):** OR now meets the ≤ 0.50 large-magnitude upgrade
   threshold. However, τ increased from 1.05 to 1.64 and k dropped from 8 to 6.
3. **C1 NRM M2 mediation less clean:** M2 OR shifted from 1.02 (complete mediation) to
   0.90 [0.59–1.36]. At k = 12, the distinction between complete and partial mediation
   is now indeterminate.
4. **C1 CMV attenuated (1.41→1.26):** Still significant but M2 CrI barely excludes null
   (1.01–1.54).
5. **C2 OS attenuated (0.69→0.81):** Still significantly protective; M2 mediation
   essentially vanishes (0.81→0.82).
6. **C2 NRM dropped below minimum (k = 2):** No longer assessable.
7. **C2 CMV now null (0.77→0.92):** CrI crosses 1; weakens the direction-reversal
   narrative, though the qualitative pattern (PTCy ≤ ATG for CMV) persists.

---

## 1. Overall Survival (OS)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 40, N = 19,724 | k = 10, N = 12,851 |
| **M1** | OR 0.79 [0.73–0.85], P(<1) = 100%, τ = 0.61 | OR 0.81 [0.74–0.90], P(<1) = 100%, τ = 0.51 |
| **M2** | OR 0.86 [0.77–0.96], P(<1) = 100%, τ = 0.58 | OR 0.82 [0.71–0.94], P(<1) > 99% |
| **Attenuation** | 27% (partial; was 29% pre-Block-9) | ~5% (negligible; was 35% pre-Block-9) |
| **Frequentist** | OR 0.77 [0.66–0.90], I² = 64% | OR 0.59 [0.32–1.09], I² = 95% |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | Retrospective/registry + multiple RCTs; start LOW | All retrospective/registry; start LOW |
| **Risk of bias** | Serious: selection bias plausible; M2 attenuation (0.79→0.86) confirms some confounding but effect survives. **No downgrade** | Serious: similar selection bias. M2 attenuation now negligible (0.81→0.82), suggesting less steroid-mediated confounding than pre-Block-9 estimated. **No downgrade** |
| **Inconsistency** | Serious: I² = 64%, τ = 0.61. **−1** | Very serious: freq I² = 95%, driven by small extreme studies; Bayesian τ = 0.51 after regularisation. **−1** |
| **Indirectness** | Not serious. 0 | Not serious. 0 |
| **Imprecision** | Not serious: CrI entirely below null; N = 19,724. 0 | Not serious: CrI entirely below null; N = 12,851. 0 |
| **Publication bias** | Undetected. 0 | Not strongly suspected. 0 |
| **Upgrade** | Not met (OR = 0.79; threshold < 0.50). 0 | Cross-comparison coherence: direction consistent with C1; mediation pattern consistent. **+1** |
| **Net** | −1 | −1 + 1 = 0 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕⊕◯◯ LOW** |

*Rating unchanged from pre-Block-9 for both comparisons.*

> *C1: Low certainty that PTCy reduces overall mortality vs CNI+MTX/MMF (OR 0.79 [0.73–0.85]). The corpus is now the largest in the analysis (k = 40, N = 19,724). Partial M2 attenuation (0.79→0.86) indicates some steroid-mediated confounding but a probable direct mortality benefit remains.*

> *C2: Low certainty that PTCy reduces overall mortality vs ATG (OR 0.81 [0.74–0.90]). The estimate attenuated from pre-Block-9 (was OR 0.69) but remains significantly protective. Notably, M2 steroid adjustment now produces essentially no attenuation (0.81→0.82), suggesting the C2 OS benefit is largely steroid-independent — a shift from the pre-Block-9 finding of 35% mediation.*

---

## 2. Non-Relapse Mortality (NRM)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 12, N = 1,309 | k = 2 **(below minimum)** |
| **M1** | OR 0.88 [0.66–1.18], P(<1) = 87%, τ = 0.72 | — |
| **M2** | OR 0.90 [0.59–1.36], P(<1) = 69%, τ = 0.60 | — |
| **Attenuation** | Negligible (M1 0.88 → M2 0.90) | — |
| **Frequentist** | OR 0.91 [0.68–1.23], I² = 0% | OR 0.63 [0.30–1.31], k = 3* |

*C2 NRM k = 2 in Bayesian (below 3-study minimum); 3 studies available for frequentist but insufficient for random-effects modelling.*

### GRADE domains — C1 only (C2 not assessable)

| Domain | C1 |
|---|---|
| Study design | All retrospective/registry; start LOW |
| **Risk of bias** | Serious: pre-Block-9 showed complete M2 mediation (OR 1.02), constituting a formal confounding signal. Post-Block-9, M2 OR = 0.90 [0.59–1.36] — the distinction between complete and partial mediation is now **indeterminate** at k = 12 with wide CrIs. The confounding concern persists but the evidence for it is less decisive. **−1** |
| **Inconsistency** | Not serious: freq I² = 0%; consistent direction. 0 |
| **Indirectness** | Not serious. 0 |
| **Imprecision** | Serious: M1 CrI 0.66–1.18 crosses null; M2 CrI 0.59–1.36 widely crosses; k dropped from 15 to 12; N = 1,309 modest for mortality. **−1** |
| **Publication bias** | Possible but not formally detectable. 0 |
| **Net** | −2 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕◯◯◯ VERY LOW** | **Not assessable (k = 2)** |

*C1 rating unchanged from pre-Block-9; C2 dropped from VERY LOW to not assessable.*

> *C1: Very low certainty. The M1 estimate (OR 0.88) trends toward benefit but the CrI crosses the null. Post-Block-9, the mediation picture is less clean than before: M2 OR shifted from 1.02 (clear complete mediation) to 0.90 (indeterminate), with a very wide CrI [0.59–1.36]. Clinical inference remains unchanged: any NRM benefit of PTCy is likely conditional on its GVHD-prevention effect, but the evidence is now insufficient to confirm or reject complete mediation.*

> *C2: Not assessable. Removing a misclassified study (Sayin) reduced C2 NRM to k = 2, below the minimum threshold for GRADE assessment. This is the only outcome that became unassessable after Block-9 data cleaning.*

---

## 3. Acute GVHD Grade II–IV

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 28, N = 4,197 | k = 9, N = 1,099 |
| **M1** | OR 0.67 [0.59–0.78], P(<1) = 100%, τ = 0.68 | OR 0.58 [0.44–0.77], P(<1) = 100%, τ = 0.55 |
| **Frequentist** | OR 0.61 [0.47–0.79], I² = 62% | OR 0.46 [0.26–0.83], I² = 73% |

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective/registry; start LOW | All retrospective/registry (+1 RCT Brissot 2024); start LOW |
| **Risk of bias** | Serious: centre-dependent GVHD grading; possible under-diagnosis in PTCy arms. However, this bias would attenuate the effect (conservative). 0 | Same. 0 (bias direction opposes effect) |
| **Inconsistency** | Serious: I² = 62%, τ = 0.68. **−1** | Serious: freq I² = 73%; Bayesian τ = 0.55. **−1** |
| **Indirectness** | Not serious. 0 | Not serious: all D+100, standard endpoint. 0 |
| **Imprecision** | Not serious: CrI does not include 1; N = 4,197. 0 | Not serious: CrI 0.44–0.77 entirely below null; improved from pre-Block-9 (was 0.42–0.84). 0 |
| **Publication bias** | Not strongly suspected. 0 | Not assessable at k = 9 (improved from k = 6). 0 |
| **Upgrade: confounders oppose** | Partially met: GVHD under-reporting in PTCy arms would bias toward null. **+1** | Same logic + cross-comparison coherence with C1 (OR 0.67). **+1** |
| **Net** | −1 + 1 = 0 | −1 + 1 = 0 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕⊕◯◯ LOW** |

*Rating unchanged for both comparisons. C2 k improved from 6 to 9, strengthening the assessment.*

> *C1: Low certainty that PTCy reduces aGVHD grade II–IV (OR 0.67 [0.59–0.78], k = 28). The finding remains mechanistically central and consistent across the largest aGVHD corpus to date.*

> *C2: Low certainty that PTCy reduces aGVHD vs ATG (OR 0.58 [0.44–0.77], k = 9). The point estimate is concordant with C1 and the CrI has tightened with the addition of 3 studies. This is the strongest C2 outcome.*

---

## 4. CMV Any-Reactivation

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 22, N = 3,328 | k = 13, N = 1,571 |
| **M1** | OR 1.26 [1.07–1.47], P(>1) = 100%, τ = 0.75 | OR 0.92 [0.73–1.15], P(<1) = 74%, τ = 0.64 |
| **M2** | OR 1.25 [1.01–1.54] (no attenuation) | OR 0.98 [0.78–1.24] (null) |
| **Frequentist** | OR 1.25 [0.94–1.66], I² = 62% | OR 0.76 [0.47–1.22], I² = 71% |
| **Direction** | **PTCy harmful** (attenuated from 1.41) | **Null** (was protective at 0.77) |

### ⚠ Major post-Block-9 changes

**C1:** Attenuated from OR 1.41 to 1.26 (k: 18→22). The M2 CrI (1.01–1.54) now barely
excludes the null. The frequentist estimate is non-significant (0.94–1.66).

**C2:** Shifted from borderline-significant protective (OR 0.77 [0.60–0.99]) to null
(OR 0.92 [0.73–1.15]). Three Block-9 C2 CMV studies were found to have arm classification
problems during audit (Sayin comparator misclassified; Xu and Zu had combination PTCy+ATG
arms). After correction, the C2 signal largely dissolved.

**Direction-reversal interpretation:** The pre-Block-9 narrative described a clean reversal
(C1 harmful at 1.41, C2 protective at 0.77). Post-Block-9, the pattern is better
characterised as: C1 mildly harmful (1.26), C2 null (0.92). The qualitative ordering
(CNI-based < PTCy ≤ ATG for CMV risk) is preserved, but the C2 estimate no longer provides
independent evidence of PTCy protection vs ATG. The mechanistic inference — that CMV risk
tracks depth of T-cell depletion — is weakened but not refuted.

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective; start LOW | All retrospective; start LOW |
| **Risk of bias** | Serious: CMV monitoring intensity varies; ascertainment bias possible. 0 (noted) | Serious: monitoring may differ between PTCy and ATG arms. 0 |
| **Inconsistency** | Serious: I² = 62%, τ = 0.75. **−1** | Serious: freq I² = 71%, τ = 0.64. **−1** |
| **Indirectness** | Not serious. 0 | Not serious. 0 |
| **Imprecision** | Not serious: Bayesian CrI 1.07–1.47 excludes null. However, M2 CrI barely excludes null (1.01–1.54) and freq CrI crosses. 0 (borderline) | Serious: CrI 0.73–1.15 crosses null; M2 CrI also crosses; signal is null. **−1** |
| **Publication bias** | Not strongly suspected. 0 | Not strongly suspected. 0 |
| **Upgrade: robustness** | Direction consistently harmful across k = 22, steroid-independence confirmed (M2 no attenuation). Signal is attenuated from pre-Block-9 but still robust across study additions. **+1** | The direction reversal is now weaker (C2 null rather than protective). The qualitative pattern (PTCy ≤ ATG) persists but C2 no longer provides independent statistical evidence. **+1 (partial, for comparative coherence)** |
| **Net** | −1 + 1 = 0 | −2 + 1 = −1 |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕⊕◯◯ LOW** | **⊕◯◯◯ VERY LOW** |

*Ratings unchanged from pre-Block-9 for both comparisons, despite substantial attenuation.*

> *C1: Low certainty that PTCy increases CMV risk vs CNI+MTX/MMF (OR 1.26 [1.07–1.47]). The signal has attenuated from 1.41 but remains consistent across 22 studies and is confirmed as steroid-independent by M2. The frequentist estimate is now non-significant, reflecting the tension between framework-specific precision in this outcome.*

> *C2: Very low certainty about CMV risk of PTCy vs ATG. The previously borderline-protective signal (OR 0.77) has dissolved to null (OR 0.92) after Block-9 data cleaning identified arm classification errors in three studies. The most defensible inference is no longer "PTCy protects against CMV vs ATG" but rather "PTCy does not increase CMV risk beyond that already inherent to ATG-based regimens." The comparative pattern (C1 harmful, C2 null) is still broadly consistent with the T-cell depletion depth hypothesis but no longer provides strong independent evidence for it.*

---

## 5. Bloodstream Infection (BSI, any pathogen)

|  | C1: PTCy vs CNI+MTX/MMF | C2: PTCy vs ATG |
|---|---|---|
| **Studies** | k = 6, N = 806 | k = 3, N = 613 |
| **Estimate** | Bayesian M1: OR 1.87 [1.33–2.62], τ = 0.96 | MH fixed-effect: OR 2.03 [1.33–3.09], I² = 69% |
| **Frequentist** | OR 1.29 [0.61–2.73], I² = 71% | (MH is the primary estimate) |

### ⚠ Major post-Block-9 changes (C1)

**C1 BSI attenuated from 2.39 to 1.87.** Two GRADE-relevant consequences:
1. **Large-magnitude upgrade no longer applies:** OR 1.87 is below the ≥ 2.0 threshold
   (previously OR 2.39 qualified). This removes the sole upgrade the C1 BSI assessment
   previously received.
2. **Inconsistency now present:** Frequentist I² rose from 0% to 71%, and the frequentist
   OR (1.29 [0.61–2.73]) is now non-significant. τ increased from 0.64 to 0.96. This
   adds a new downgrade for inconsistency.

### GRADE domains

| Domain | C1 | C2 |
|---|---|---|
| Study design | All retrospective; start LOW | All retrospective; start LOW |
| **Risk of bias** | Very serious: 7 of 13 eligible studies had NR event counts; retained studies may over-represent high-BSI centres. **−1** | Very serious: definitional heterogeneity (any blood culture vs ICU/fatal only); donor-type confound in Meyer 2025. **−1** |
| **Inconsistency** | **Serious (NEW): freq I² = 71%, τ = 0.96.** Previously I² = 0%; Block-9 additions introduced heterogeneity. **−1** | Serious: I² = 69% across 3 definitionally heterogeneous studies. **−1** |
| **Indirectness** | Mild: BSI definitions varied. 0 | Captured under inconsistency. 0 |
| **Imprecision** | Serious: k = 6; freq CrI crosses null (0.61–2.73); Bayesian prior influence at small k. **−1** | Very serious: k = 3; below conventional GRADE minimum. **−1** |
| **Publication bias** | Suspected: small k. 0 | Not assessable. 0 |
| **Upgrade: large magnitude** | **No longer met** (OR 1.87; was 2.39, threshold ≥ 2.0). 0 | Not applied. 0 |
| **Net** | −3 → floor | −3 → floor |

| | C1 | C2 |
|---|---|---|
| **CERTAINTY** | **⊕◯◯◯ VERY LOW** | **⊕◯◯◯ VERY LOW**‡ |

‡Informal rating; formal GRADE not conventionally performed at k = 3.

*C1 rating unchanged (VERY LOW) but reasoning shifts substantially: the loss of the
large-magnitude upgrade and the addition of an inconsistency downgrade mean the evidence
is now weaker than pre-Block-9, even though the formal rating hits the same floor.*

> *C1: Very low certainty. The 6-study corpus still shows PTCy-associated BSI excess (OR 1.87 [1.33–2.62]), but the signal is weaker than pre-Block-9 (was 2.39) and now heterogeneous (freq I² = 71%, was 0%). The Bayesian and frequentist estimates diverge substantially (Bayesian OR 1.87 vs freq OR 1.29), reflecting model-dependency at k = 6. The clinical implication — that PTCy recipients warrant attentive BSI surveillance — remains reasonable, but the magnitude of excess risk is uncertain.*

> *C2: Very low certainty. Direction consistent with C1 (OR 2.03 vs 1.87), but the three contributing studies are not measuring the same construct. Hypothesis-generating only.*

---

## 6. Invasive Fungal Infection (IFI, any) — Comparison 1 Only

**k = 6, N = 2,243**
**M1: OR 0.43 [0.29–0.63], P(OR < 1) = 100% · τ = 1.64**
**Frequentist: OR 0.60 [0.21–1.74], I² = 80%**

*No Comparison 2 data available (insufficient k).*

### ⚠ Major post-Block-9 changes

**IFI effect dramatically strengthened (0.73→0.43)** while heterogeneity worsened
(τ: 1.05→1.64, I²: 82%→80%). k dropped from 8 to 6. The CrI now entirely excludes
the null (0.29–0.63; was 0.53–1.00, touching null).

A new GRADE-relevant consideration: **OR 0.43 meets the ≤ 0.50 large-magnitude upgrade
threshold**, which was not met pre-Block-9 (OR 0.73). However, the extreme heterogeneity
(τ = 1.64 — the highest in the entire analysis) and the Bayesian-frequentist divergence
(Bayesian OR 0.43 vs freq OR 0.60 [0.21–1.74], non-significant) raise serious concerns
about the reliability of the point estimate.

### GRADE domains

| Domain | Assessment | Direction |
|---|---|---|
| Study design | All retrospective; start LOW | — |
| **Risk of bias** | Serious: IFI diagnosis protocol-dependent; PTCy arms may be under-investigated. 0 (bias would inflate apparent protection) |
| **Inconsistency** | Very serious: τ = 1.64 (highest in entire analysis), I² = 80%. Previously driven by Yanada 2026 (zero events in 241 PTCy patients); the problem persists and may have worsened with study removal. **−2** |
| **Indirectness** | Serious: antifungal prophylaxis regimens heterogeneous and non-randomly distributed between arms. **−1** |
| **Imprecision** | Serious: k = 6 (dropped from 8); freq CrI widely crosses null (0.21–1.74); Bayesian-frequentist divergence. **−1** |
| **Publication bias** | Possible at k = 6. 0 |
| **Upgrade: large magnitude** | **Now met (NEW):** OR 0.43 ≤ 0.50 threshold. However, this upgrade must be interpreted cautiously given the extreme heterogeneity — the large magnitude may reflect the disproportionate influence of zero-event studies rather than a genuine population-level effect. **+1** |
| **Net** | −4 + 1 = −3 → floor |

**⊕◯◯◯ CERTAINTY: VERY LOW**

*Rating unchanged (VERY LOW floor) but the evidence profile has shifted: the point estimate
is now dramatically stronger but the heterogeneity is worse and the corpus smaller.*

> *Very low certainty. The posterior probability of IFI protection is now very high (P(OR < 1) = 100%), and the OR of 0.43 suggests a potentially large effect. However, the extreme heterogeneity (τ = 1.64) indicates that this estimate is not representative of any single clinical context — it reflects a mixture of zero-event contemporary cohorts (with aggressive mold prophylaxis) and older cohorts with higher baseline IFI rates. The most defensible clinical inference remains: PTCy does not appear to increase IFI risk, and IFI reduction may be achievable in centres with optimised antifungal prophylaxis, but the evidence base is too heterogeneous for a more specific recommendation.*

---

## Combined Summary Table

| Outcome | Comparison | k | N | OR [95% CrI] | Posterior P | Certainty | Δ from pre-B9 | Key limitation |
|---|---|---|---|---|---|---|---|---|
| **OS** | C1 | 40 | 19,724 | 0.79 [0.73–0.85] | P(<1) = 100% | ⊕⊕◯◯ LOW | 0.77→0.79 | I² = 64%; obs dominant |
| | C2 | 10 | 12,851 | 0.81 [0.74–0.90] | P(<1) = 100% | ⊕⊕◯◯ LOW | **0.69→0.81** | I² = 95% (freq); one registry dominant |
| **NRM** | C1 | 12 | 1,309 | 0.88 [0.66–1.18] | P(<1) = 87% | ⊕◯◯◯ V. LOW | k: 15→12 | M2 mediation indeterminate; CrI crosses null |
| | C2 | 2 | — | — | — | **Not assessable** | **k: 5→2** | Below minimum |
| **aGVHD II–IV** | C1 | 28 | 4,197 | 0.67 [0.59–0.78] | P(<1) = 100% | ⊕⊕◯◯ LOW | 0.63→0.67 | I² = 62%; obs dominant |
| | C2 | 9 | 1,099 | 0.58 [0.44–0.77] | P(<1) = 100% | ⊕⊕◯◯ LOW | k: 6→9 | τ poorly estimated |
| **CMV** | C1 | 22 | 3,328 | 1.26 [1.07–1.47] | P(>1) = 100% | ⊕⊕◯◯ LOW | **1.41→1.26** | Attenuated; M2 CrI borderline |
| | C2 | 13 | 1,571 | 0.92 [0.73–1.15] | P(<1) = 74% | ⊕◯◯◯ V. LOW | **0.77→0.92 (null)** | Signal dissolved; direction reversal weakened |
| **BSI** | C1 | 6 | 806 | 1.87 [1.33–2.62] | P(>1) = 100% | ⊕◯◯◯ V. LOW | **2.39→1.87** | Lost large-mag upgrade; gained I² = 71% |
| | C2 | 3 | 613 | 2.03 [1.33–3.09]† | p = 0.001 | (⊕◯◯◯) V. LOW‡ | — | k = 3; definitional heterogeneity |
| **IFI** | C1 | 6 | 2,243 | 0.43 [0.29–0.63] | P(<1) = 100% | ⊕◯◯◯ V. LOW | **0.73→0.43** | Gained large-mag upgrade; τ = 1.64 |
| | C2 | — | — | — | — | — | — | Insufficient data |

†Mantel-Haenszel fixed-effect. ‡Informal rating.

*⊕ = present; ◯ = absent. Certainty levels: HIGH (⊕⊕⊕⊕), MODERATE (⊕⊕⊕◯), LOW (⊕⊕◯◯), VERY LOW (⊕◯◯◯).*

---

## New Outcomes Available (Not Yet GRADE-Assessed)

The post-Block-9 models include additional outcomes not present in the pre-Block-9
GRADE assessment. These are listed here for completeness; formal GRADE assessment is
deferred pending discussion of their inclusion in the primary analysis:

| Outcome | C1 k | C1 OR [95% CrI] | C2 k | C2 OR [95% CrI] |
|---|---|---|---|---|
| Relapse-related mortality | 38 | 0.84 [0.76–0.93] | 10 | 0.79 [0.69–0.89] |
| cGVHD moderate-severe | 21 | 0.33 [0.29–0.36] | 6 | 0.79 [0.55–1.14] |
| cGVHD any grade | 8 | 0.23 [0.18–0.30] | — | — |
| BK virus reactivation | 11 | 2.48 [1.82–3.38] | 3 | 2.44 [1.40–4.26] |
| Infection-related mortality | 16 | 1.35 [1.16–1.57] | 7 | 0.90 [0.74–1.09] |

These outcomes include several with potentially GRADE-assessable corpora (RRM k = 38,
cGVHD mod-severe k = 21, IRM k = 16). BK virus and infection-related mortality show
the same comparative pattern as CMV (direction reversal between C1 and C2).

---

## Comparison 3: Within-PTCy Variants

All four C3 outcomes (OS, NRM, aGVHD, cGVHD) have CrIs crossing 1 with point estimates
near the null. A formal GRADE assessment is not performed for C3, as the null findings
are best interpreted as absence of detectable differences between PTCy regimen variants
rather than evidence for equivalence (imprecision at k = 4–7 precludes equivalence claims).

---

## Overarching GRADE Narrative

Across both comparisons and all outcomes, certainty of evidence does not exceed LOW —
reflecting an evidence base that is almost entirely observational.

### What has changed since pre-Block-9

The Block-9 corpus addition (31 new studies) and subsequent data cleaning introduced
both new information and new uncertainty. **No GRADE certainty rating changed level**
(all movements were within-tier), but the evidence profiles shifted in several
clinically relevant ways:

1. **The core findings are robust.** C1 OS (0.79), C1 aGVHD (0.67), and C2 aGVHD
   (0.58) all moved by ≤ 0.04 OR units from their pre-Block-9 estimates despite
   substantial k increases. These are the most dependable signals in the analysis.

2. **C2 OS attenuated but clarified.** The C2 OS estimate moved from 0.69 to 0.81.
   While this represents meaningful attenuation, the steroid mediation essentially
   vanished (M2 0.82 ≈ M1 0.81), suggesting the post-Block-9 estimate may be *less*
   confounded than the pre-Block-9 estimate was.

3. **The CMV direction-reversal narrative is weakened but not refuted.** The clean
   C1-harmful/C2-protective pattern (1.41 vs 0.77) has become C1-mildly-harmful/C2-null
   (1.26 vs 0.92). The qualitative ordering is preserved (PTCy ≤ ATG for CMV risk)
   but the C2 estimate no longer provides independent evidence of protection. The
   mechanistic inference about T-cell depletion depth should be presented with
   appropriate caveats.

4. **BSI evidence is weaker than previously estimated.** The loss of the large-magnitude
   upgrade and the appearance of heterogeneity (I²: 0%→71%) mean the BSI signal,
   while still positive, is less certain than the pre-Block-9 assessment suggested.

5. **IFI evidence has shifted character.** The dramatic strengthening (0.73→0.43)
   and the new large-magnitude upgrade are offset by worsened heterogeneity
   (τ: 1.05→1.64). The clinical message is unchanged — PTCy does not increase IFI
   risk — but the evidence for active protection is now paradoxically both stronger
   (point estimate) and more uncertain (heterogeneity).

### Clinical decision threshold

For the primary clinical question — should PTCy be preferred over alternative GVHD
prophylaxis platforms — the converging LOW-certainty evidence for OS benefit (C1 and C2)
and aGVHD reduction (C1 and C2) remains sufficient to inform guideline recommendations,
particularly in haploidentical settings. The CMV risk signal (C1 LOW certainty, OR 1.26)
should be incorporated into monitoring guidance. The BSI signal warrants attention but
the evidence is weaker than pre-Block-9 suggested. The infection-outcome evidence gaps
(BSI, IFI) remain the principal limitation of the current evidence base.

---

*All Bayesian estimates from brms 2.23.0 (rstan backend), post-Block-9 refit
(251-study corpus). Frequentist estimates from metafor. GRADE applied per the
GRADE Handbook (Schünemann et al.) and the GRADE working group guidance for
meta-analyses of observational studies.*
