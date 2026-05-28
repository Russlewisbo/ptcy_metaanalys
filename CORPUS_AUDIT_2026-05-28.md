# Corpus completeness audit — ptcy_metaanalys vs Marta_selected

**Date:** 2026-05-28
**Workbook audited:** `PTCy_MA_extraction_template_v1.2.xlsx` (220 studies extracted)
**Reference list:** `Marta_selected.xlsx` (481 records that survived title/abstract screening)

---

## Headline

The workbook in this folder is **identical** to the one I rebuilt yesterday (same 220 studies, 410 papers attempted, same IDs and DOIs — the row-count difference earlier was a header-row artifact when reading without the metadata-row skip). **Blocks 7 and 8 were extracted in the same session as blocks 1–6.**

**The real question is whether your Paperpile corpus (410 PDFs) was itself complete.** Against your Marta_selected.xlsx screening output (481 records), I find:

| Bucket | N |
|---|---|
| Marta-selected, confidently extracted (DOI match) | 112 |
| Marta-selected, likely extracted (no DOI in workbook, but author+year matches) | 17 |
| Marta-selected, fuzzy title match to workbook | 14 |
| Marta-selected, likely excluded as abstract/review (author+year matches an excluded paper_label) | 23 |
| Marta-selected with abstract-style DOI (Blood/JCO/JTCT supplement issues) | 213 |
| **Marta-selected, TRULY NOT in workbook (likely real journal articles)** | **102** |

**Top-line answer: ~102 Marta-selected journal papers appear to be missing from your extraction.**

Full list: `TRULY_MISSING_studies.csv` (also saved in your old PTCY_analysis folder).

---

## Year distribution of the 102 truly-missing papers

| Year | N | Comment |
|---|---|---|
| 2013–2018 | 22 | older PTCy papers, likely never PDFed into Paperpile |
| 2019 | 12 | |
| 2020 | 11 | |
| 2021 | 11 | |
| 2022 | 12 | |
| 2023 | 9 | |
| 2024 | 6 | |
| 2025 | 21 | many published after Paperpile snapshot was taken |
| 2026 | 3 | published after snapshot |

---

## What this means for your R analysis

Your current models (`03_models/`) are based on **220 extracted studies → 35-study OS model, 18-study CMV model, 6-study BSI model, 8-study IFI model**. The 102 missing papers, if added, would affect the sparse outcomes the most:

- **BSI (k=6 now)** is the most vulnerable to shift. A few of the missing papers report BSI (e.g., the Frontiers/EJH/BMT articles from 2022–2025). Adding even 3–4 BSI-reporting papers could move the BSI OR estimate and/or τ.
- **IFI (k=8 now)** similarly sparse. Yanada 2026 (the zero-event arm driving τ=1.05) is in the workbook, but more IFI-reporting papers in the missing list could shift the corrected OR.
- **CMV (k=18)** and **aGVHD (k=24)** are more robust but ~20 missing PTCy-vs-CNI or PTCy-vs-ATG papers would still meaningfully tighten or shift CrIs.
- **OS / NRM** are best-powered (k=35 / 15) and likely most stable.

The directional findings (CMV harmful vs CNI but protective vs ATG; OS benefit partially steroid-mediated; NRM completely steroid-mediated) are likely robust — but the **point estimates and CrI widths** could shift.

---

## Categories within the 102 missing — likely impact

Skimming the title list:

### High-priority candidates (likely affect estimates)
- **Phase 2/3 trials with original data:** Bashey 2013 JCO (BMT for hematologic malignancies); Cancer 2016 phase-2 PTCy; Blood Advances 2025 prospective PTCy trial; Blood Advances 2021 phase 2 GVHD prophylaxis.
- **PTCy vs CNI head-to-head (Comp 1):** several Bone Marrow Transplantation 2020–2022 articles; Journal of Hematology & Oncology 2020.
- **PTCy vs ATG head-to-head (Comp 2):** Annals of Hematology 2022 risk factors; EJH 2019 ATG+PTCy; Blood Cancer Journal 2023 low-dose ATG+PTCy.
- **Within-PTCy dose variants (Comp 3):** EJH 2025 standard vs reduced dose PTCy; JCO 2025 reduced-dose PTCy; BMT 2025 low-dose PTCy + low-dose alemtuzumab; BMT 2022 PTCy + sirolimus.
- **Infection-focused** (most likely to expand sparse BSI/IFI): BMT 2019 evaluation of infectious complications; BMT 2020 patterns of infection; Transplant Infectious Disease 2015/2016 infection epidemiology; Leukemia & Lymphoma 2020 EBV-PTLD.

### Lower-priority
- 2025–2026 publications still in press / very recent (3–4 papers) — may or may not have been Paperpile-downloaded yet.
- bioRxiv/medRxiv preprints (3 papers) — likely intentionally excluded as non-peer-reviewed.
- Single-author reviews/editorials ("PTCY keeps on giving!", "Is Post-Transplant Cyclophosphamide the New Methotrexate?", "Posttransplant cyclophosphamide: a universal GVHD prophylaxis") — these should be excluded anyway.

A rough estimate: of the 102, maybe **50–60 are real journal data papers worth attempting to extract**, while the rest are reviews, preprints, or duplicates I missed by normalization.

---

## What I cannot determine from this audit

1. **Whether the papers were ever PDF-downloaded into Paperpile.** My corpus was the 410 PDFs in `Paperpile files/` at the start of my session. If a Marta-selected paper was never downloaded, I never saw it.
2. **Why some Marta papers weren't in Paperpile.** Could be paywalled, full text unobtainable, withdrawn, or simply pending.
3. **The audit's false-negative rate.** Author-name format differences (Marta: "A. Al-Homsi"; workbook: "Al-Homsi A") may cause additional false negatives in the missing list. Conservatively, the 102 figure could be 10–20% inflated.

---

## Recommended next steps (in priority order)

1. **Open `TRULY_MISSING_studies.csv`** and triage manually — for each row, decide:
   - Already extracted (false negative in my audit): mark as done
   - PDF not in Paperpile: try to download
   - Already excluded for cause: note the reason
   - Worth extracting: add to the queue

2. **Focus on the high-impact subset first.** The sparse-outcome papers (BSI / IFI / Comparison 3 within-PTCy) are most likely to shift estimates. If you only have credits for 15–20 more extractions, those are the ones to do.

3. **Bayesian models can be updated incrementally.** brms supports `update()` with new data — you don't have to refit from scratch. Once new papers are extracted, re-run the CSV exports and refit each affected model. The Table2_results table can be regenerated cleanly.

4. **Document the corpus cutoff date.** Whatever date you decide is the final search date, any Marta papers more recent than that are out of scope for this round. Many of the 2025–2026 entries probably fall here.

5. **Update your PRISMA flow diagram.** Right now the flow goes 1488 (search) → 1051 (dedup) → 481 (screened) → ? (full-text retrieved) → 220 + 190 (extracted + excluded). The audit fills in the missing arrow: 481 screened → 410 PDF-retrieved → 220 included after full-text review.

---

## Files

- `TRULY_MISSING_studies.csv` — full list of 102 likely-missing journal articles (this is what you need to triage)
- `POTENTIALLY_MISSING_studies.csv` — wider 325-record list including conference abstracts (likely most are correctly excluded)
- `POTENTIALLY_MISSING_journal_articles.csv` — intermediate 116-record cut before fuzzy title matching
