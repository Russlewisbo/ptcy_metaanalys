# Appendix S9e: Frequentist Concordance Checks (metafor REML)

*Generated 2026-08-11 from the Set B (cohort-deduplicated) analytic datasets.*

Every Bayesian M1 model was refitted as a frequentist random-effects meta-analysis
(metafor, REML, Hartung-Knapp not applied) on the same analytic dataset, as a
concordance check. Study-level odds ratios were computed with `escalc(measure = "OR")`
using a 0.5 continuity correction for zero cells only.

Two caveats apply when reading this table against the main results:

1. **The models are not equivalent.** The Bayesian M1 is a binomial-logistic model on
   arm-level event counts with a study random intercept and a timepoint covariate; the
   frequentist model pools study-level log odds ratios with an additive random effect.
   The Bayesian model uses the counts directly and borrows strength across studies, so
   it will generally produce narrower intervals. Divergence is expected, not alarming.
2. **tau is not the same quantity in the two columns.** In M1 the random intercept is on
   study-level baseline risk, so `tau (Bayes)` measures variation in event rates across
   studies. `tau (REML)` measures heterogeneity of the treatment effect. They are not
   comparable and should not be presented side by side without this caveat.

|Outcome      |  k|Data        |Bayesian M1 OR [95% CrI] | tau (Bayes)|Frequentist REML OR [95% CI] | I2 (%)| tau (REML)|Concordance  |
|:------------|--:|:-----------|:------------------------|-----------:|:----------------------------|------:|----------:|:------------|
|c1_agvhd     | 28|post_block9 |0.67 [0.59-0.78]         |        0.68|0.61 [0.47-0.79]             |     62|       0.53|concordant   |
|c1_bk        | 11|post_block9 |2.48 [1.82-3.38]         |        1.06|2.36 [1.63-3.42]             |     17|       0.26|concordant   |
|c1_bsi       |  6|post_block9 |1.87 [1.33-2.62]         |        0.96|1.29 [0.61-2.73]             |     71|       0.75|CI crosses 1 |
|c1_cgvhd_any |  8|post_block9 |0.23 [0.18-0.30]         |        0.52|0.24 [0.15-0.40]             |     63|       0.51|concordant   |
|c1_cgvhd_ms  | 19|set_b       |0.47 [0.38-0.57]         |        0.77|0.42 [0.28-0.61]             |     58|       0.58|concordant   |
|c1_cmv       | 22|post_block9 |1.26 [1.07-1.47]         |        0.74|1.25 [0.94-1.66]             |     62|       0.50|CI crosses 1 |
|c1_ifi_any   |  6|post_block9 |0.43 [0.29-0.63]         |        1.64|0.60 [0.21-1.74]             |     80|       1.11|CI crosses 1 |
|c1_irm       | 13|set_b       |1.19 [1.00-1.43]         |        0.82|1.03 [0.72-1.46]             |     57|       0.45|concordant   |
|c1_nrm       | 12|post_block9 |0.88 [0.66-1.18]         |        0.72|0.91 [0.68-1.23]             |      0|       0.00|concordant   |
|c1_os        | 35|set_b       |0.84 [0.76-0.92]         |        0.66|0.79 [0.65-0.94]             |     64|       0.40|concordant   |
|c1_rrm       | 34|set_b       |0.86 [0.77-0.97]         |        0.47|0.86 [0.76-0.97]             |      0|       0.00|concordant   |
|c2_agvhd     |  8|set_b       |0.63 [0.47-0.83]         |        0.53|0.51 [0.28-0.94]             |     74|       0.73|concordant   |
|c2_bk        |  3|post_block9 |2.44 [1.40-4.26]         |        0.57|2.44 [1.41-4.22]             |      0|       0.00|concordant   |
|c2_cgvhd_ms  |  6|post_block9 |0.79 [0.55-1.14]         |        0.89|0.77 [0.40-1.45]             |     60|       0.57|concordant   |
|c2_cmv       | 12|set_b       |0.97 [0.77-1.23]         |        0.63|0.83 [0.51-1.33]             |     69|       0.66|concordant   |
|c2_irm       |  7|post_block9 |0.90 [0.74-1.09]         |        0.58|0.93 [0.66-1.31]             |     39|       0.25|concordant   |
|c2_os        |  9|set_b       |0.83 [0.75-0.92]         |        0.50|0.73 [0.44-1.21]             |     93|       0.67|CI crosses 1 |
|c2_rrm       | 10|post_block9 |0.79 [0.69-0.89]         |        0.16|0.78 [0.57-1.05]             |     57|       0.30|CI crosses 1 |
|c3_agvhd     |  7|post_block9 |1.00 [0.80-1.25]         |        0.82|0.52 [0.22-1.20]             |     77|       0.88|concordant   |
|c3_cgvhd     |  4|post_block9 |0.67 [0.39-1.14]         |        0.41|0.50 [0.19-1.30]             |     49|       0.68|concordant   |
|c3_nrm       |  5|post_block9 |0.96 [0.74-1.24]         |        1.22|0.49 [0.17-1.39]             |     80|       0.95|concordant   |
|c3_os        |  6|post_block9 |1.11 [0.95-1.30]         |        0.92|0.92 [0.57-1.49]             |     78|       0.45|concordant   |
|c3_rrm       |  6|post_block9 |0.80 [0.50-1.27]         |        0.39|0.75 [0.44-1.29]             |      7|       0.20|concordant   |

## Discordant outcomes

For 5 outcomes the Bayesian credible interval excludes 1 while the frequentist
confidence interval does not:

|Outcome    |  k|Bayesian         |Frequentist      | I2 (%)|
|:----------|--:|:----------------|:----------------|------:|
|c1_bsi     |  6|1.87 [1.33-2.62] |1.29 [0.61-2.73] |     71|
|c1_cmv     | 22|1.26 [1.07-1.47] |1.25 [0.94-1.66] |     62|
|c1_ifi_any |  6|0.43 [0.29-0.63] |0.60 [0.21-1.74] |     80|
|c2_os      |  9|0.83 [0.75-0.92] |0.73 [0.44-1.21] |     93|
|c2_rrm     | 10|0.79 [0.69-0.89] |0.78 [0.57-1.05] |     57|

These include four claims that carry weight in the main text: the C1 CMV excess, the
C1 BSI excess, the C1 IFI reduction, and the C2 overall-survival benefit (frequentist
0.73 [0.44-1.21], I2 = 93%). C2 relapse-related mortality is also discordant. The
direction of effect agrees in every case; only the interval width differs.

This does not invalidate the Bayesian estimates, but it does mean the infection
findings are less robust to model choice than the survival and GVHD findings, and the
discordance should be disclosed rather than left to a reader to discover. Consider
reporting it in the limitations paragraph.

*Source: `03_models/set_b/freq_results_setB.csv`; datasets as listed in the `Data`
column (`set_b` = refitted after deduplication, `post_block9` = unaffected).*

