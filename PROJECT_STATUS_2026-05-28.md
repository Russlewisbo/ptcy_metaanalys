# PTCy meta-analysis — project status (resumption doc)

**Date:** 2026-05-29 (updated after Block 9 extraction)
**Lead:** R. Lewis (UniPD) · **Co-reviewer:** BMT program director (verification pending)
**Working folder:** `/Users/russelllewis/Desktop/ptcy_metaanalys/` (git-tracked, R workspace)
**Legacy scratch folder:** `/Users/russelllewis/Desktop/PTCY_analysis/` (Claude-created outputs, audit CSVs)

---

## Where we are

**Phase 1–3 complete.** Protocol, schema, and corpus extraction finished. v1.2 database locked.

**Phase 4 partially complete.** Self-audit done; BMT director's second-pass spot-check not yet started.

**Phase 5 in progress.** Bayesian models for Comparison 1 (k=35 OS, 15 NRM, 24 aGVHD, 18 CMV, 6 BSI, 8 IFI) and Comparison 2 (k=10 OS, 5 NRM, 6 aGVHD, 12 CMV) have been fit on the 220-study baseline. Results tables, GRADE assessments, forest plots, and Discussion drafts exist in `03_models/` and `04_writing/`. **These need to be refit on the post-Block-9 corpus.**

**2026-05-28 audit:** Found ~102 Marta-selected journal articles missing from the original extraction (`CORPUS_AUDIT_2026-05-28.md`). Russ triaged the list to 55 PDFs in `Missing papers/`.

**2026-05-29 Block 9 extraction:** All 55 PDFs processed via parallel subagent pipeline. **30 extracted, 1 PRISMA-tracked single-arm trial (Raiola PHYLOS), 24 excluded** (19 single-arm descriptive, 3 narrative reviews, 1 systematic review, 1 conference abstract, 1 non-eligible population). **+4 new RCTs (Koura 2025, Zhang 2023, Zu 2022, Zu 2023) — total 14 RCTs.** See `BLOCK_9_extraction_summary_2026-05-29.md` for full details.

---

## Database snapshot (post Block 9, 2026-05-29)

| Sheet | Pre Block 9 | Post Block 9 |
|---|---:|---:|
| `cohorts` | 160 | **181** |
| `studies` | 220 | **251** |
| `arms` | 457 | **525** |
| `outcomes` | 3,050 | **3,604** |
| `outcomes_subgroup` | 116 | **126** |
| `rob` | 210 | **241** |
| Excluded (PRISMA-tracked) | 190 | **214** |
| **RCTs** | **10** | **14** |

| Comparison eligibility (arms) | Pre | Post | Δ |
|---|---:|---:|---:|
| C1: PTCy vs CNI+MTX/MMF | 301 | 313 | +12 |
| C2: PTCy vs ATG | 101 | 109 | +8 |
| C3: Within-PTCy variants | 29 | 68 | **+39** |

**Workbook (active):** `PTCy_MA_extraction_template_v1.2_post_block9.xlsx`
**Workbook (frozen baseline):** `PTCy_MA_extraction_template_v1.2.xlsx`
**Schema:** `PTCy_MA_database_schema_v1.2.md`
**Exclusion log:** `PTCy_MA_extraction_template_v1.2_excluded_papers.json` (214 records)

---

## What's next — pending decisions

### 1. Corpus expansion (DONE for this round)

✅ Russ triaged the 102-candidate audit list down to 55 PDFs in `Missing papers/`.
✅ Block 9 extraction completed 2026-05-29 — 30 new studies + 1 PRISMA single-arm + 24 excluded.
✅ Workbook consolidated into `PTCy_MA_extraction_template_v1.2_post_block9.xlsx`.
⏸ **Bayesian model refit paused for Russ's review of the delta** (next step on resume).

**Priority subset (highest expected impact on point estimates):**
- BSI / IFI–reporting papers (current k=6 and k=8 are most sensitive to τ shift): BMT 2019 infection-complications eval; BMT 2020 patterns-of-infection; Transplant Infectious Disease 2015/2016 epidemiology; Leukemia & Lymphoma 2020 EBV-PTLD; Frontiers/EJH 2022–2025 infection series.
- Within-PTCy dose variants (Comparison 3, k=29 arms): EJH 2025 standard-vs-reduced PTCy; JCO 2025 reduced-dose PTCy; BMT 2025 low-dose PTCy + low-dose alemtuzumab; BMT 2022 PTCy+sirolimus.
- PTCy-vs-ATG (Comparison 2): Annals of Hematology 2022; EJH 2019 ATG+PTCy; Blood Cancer Journal 2023 low-dose ATG+PTCy.
- Phase 2/3 originals: Bashey 2013 JCO; Cancer 2016 phase-2; Blood Advances 2025 prospective; Blood Advances 2021 phase-2 GVHD prophylaxis.

**Skip pile:** reviews/editorials, bioRxiv/medRxiv preprints, 2025–2026 papers past the search cutoff (set a cutoff date and document it).

### 2. BMT director second-pass verification (Phase 4)

Stratified random spot-check (~20–30 papers across blocks) + resolution of these flagged items (from `FINAL_STATUS.md`):
- Moiseev 2016 (study 7) — RCT vs prospective_cohort?
- Outcome 225 (Alousi 2015) — denominator > arm.n_patients
- Lim CX 2019 (study 218) — mislabeled PDF
- Park 2021 (study 303) — SAA/ATG, no PTCy
- Pavlov cohorts 1007 vs 1099 — same trial?
- Cohort-merger clusters: GETH/Spanish (1019/20/49/50/51); PMH Toronto (1042/43/44); MDACC Mehta (1089/90/91); JSTCT (1064/70/1103/08/09/13).

### 3. Phase 5 finalization

Models exist for Comparisons 1 and 2 on the 220-study baseline. Open items:
- **Refit C1 and C2 models** on the 251-study post-Block-9 corpus. `brms::update()` supports incremental refitting.
- **Fit Comparison 3 models** — k jumped from 29 to 68 arms after Block 9; the within-PTCy comparison is now adequately powered.
- Poisson sub-model for rate-reporting papers (Khimani 2021, Meyer 2025).
- `RoBMA` publication-bias sensitivity.

### 4. Known data issues to handle during refit (from Block 9 validation)

- **Lazana 2026 (study 433)**: CMV, engraftment_failure, other_infection outcomes are pooled across PTCy-15 (n=33) and PTCy-25 (n=30) subgroups but assigned to arm A1 in the workbook. For the C3 model, either collapse A1+A2 into a single n=63 "PTCy combined" arm or drop these outcome rows from the dose-subgroup analysis.
- **Garcia-Cadenas 2021 (study 426)**: engraftment_failure rate is whole-cohort (n=117) not stratified by donor type; assigned to A1 with note. Either drop or model at cohort level.

---

## Key files (where to look)

**Database & schema (this folder):**
- `PTCy_MA_extraction_template_v1.2_post_block9.xlsx` — **CURRENT working workbook** (251 studies, 14 RCTs)
- `PTCy_MA_extraction_template_v1.2.xlsx` — frozen 220-study baseline (preserved for reference)
- `PTCy_MA_database_schema_v1.2.md` — schema spec
- `FINAL_STATUS.md` — extraction handoff after blocks 1–8 (2026-05-27)
- `CORPUS_AUDIT_2026-05-28.md` — completeness audit that identified the 102 missing
- `BLOCK_9_extraction_summary_2026-05-29.md` — Block 9 extraction report
- `PROJECT_STATUS_2026-05-28.md` — this file (updated 2026-05-29)
- `Missing papers/` — the 55 PDFs Russ triaged for Block 9 extraction

**Analysis (this folder):**
- `02_extraction/` — extraction R scripts, CSV exports from workbook
- `03_models/` — Bayesian `.rds` files for C1 and C2, `Table2_results.csv`, forest plots
- `04_writing/` — Results, GRADE, Discussion drafts (markdown)
- `05_website/` — site outputs

**Audit CSVs (legacy folder, `/Users/russelllewis/Desktop/PTCY_analysis/`):**
- `TRULY_MISSING_studies.csv` — 102 candidates for extraction
- `POTENTIALLY_MISSING_studies.csv` — wider 325-record list
- `POTENTIALLY_MISSING_journal_articles.csv` — intermediate 116-record cut

**Per-paper JSONs (Claude scratch, can be re-presented on request):**
- `extraction_paper_<N>.json` × 410
- `excluded_papers_block_<N>.json` × 8

---

## To pick this back up next session

Tell me one of:
- **"Refit all affected models on the post-Block-9 corpus."** I'll re-export CSVs from `PTCy_MA_extraction_template_v1.2_post_block9.xlsx`, run `brms::update()` on m1/m2/m3 for OS/NRM/aGVHD/CMV/BSI/IFI (C1 and C2), fit new C3 models from scratch, regenerate `Table2_results.csv`, forest plots, and GRADE.
- **"Refit only the sparse-outcome (BSI/IFI/CMV) models first."** Fastest way to see whether the +15 BSI / +8 IFI_any rows move the estimates.
- **"Fit Comparison 3 models from scratch."** k=68 arms now adequately powered.
- **"BMT director is ready for the spot-check — prep the list."** I'll generate a stratified random sample plus the flagged-anomaly list.
- **"Draft the methods section of the manuscript."** Output goes to `04_writing/`.

I'll read this file plus `BLOCK_9_extraction_summary_2026-05-29.md`, `FINAL_STATUS.md`, and `CORPUS_AUDIT_2026-05-28.md` to re-orient.

---

## Can this move to Claude projects?

**Short answer: partially. The extraction workflow needs Cowork (or Claude Code), not Claude.ai Projects.**

Claude.ai Projects is great for conversation continuity with custom instructions and a shared knowledge base of uploaded files. It is NOT great for what this project actually requires.

What Projects can do well for this work:
- Hold the protocol, schema, status docs, and extraction template as persistent reference files so any new chat starts with full context.
- Keep custom instructions ("you are extracting data per schema v1.2, the rules are X, Y, Z").
- Serve as the canonical home for the planning conversation and write-up brainstorming.

What Projects cannot do (and why this workflow needs to stay in Cowork):
- No file system access on your computer. Projects can't read `/Users/russelllewis/Desktop/ptcy_metaanalys/` or write to the xlsx in place. Files have to be uploaded one by one and downloaded back.
- No parallel subagents. The block-of-50 extraction relies on spawning ~50 independent agents simultaneously. Projects runs a single conversation thread.
- No R execution. The `brms` model fits, CSV exports, and forest-plot regeneration need a working R environment (which Cowork has via the sandbox; Projects does not).
- File upload limits. A Project's knowledge base caps out well below the 410 PDFs (~2 GB) plus the workbook plus 410 JSONs.
- No persistent xlsx editing. Even single-file edits require download → edit → re-upload each turn.

**Recommended hybrid setup:**
1. **Cowork (here)** stays the primary workspace for extraction, model fitting, and any file-system-heavy task. The mounted folder + parallel subagents + sandbox bash is what makes the block workflow possible.
2. **Claude.ai Project** (optional, if you want it) can mirror the protocol PDF, schema v1.2 markdown, `FINAL_STATUS.md`, this status doc, and `CORPUS_AUDIT_2026-05-28.md` as the project's knowledge base — useful for quick consults from a phone or web browser when you're away from this Mac, e.g. "remind me what the back-calculation rule was" or "what's the BSI count again?".
3. **Manuscript drafting** is the one phase where Projects becomes genuinely competitive with Cowork — once the analysis is done and the deliverable is prose + tables, a Project with the Results/GRADE/Discussion drafts as knowledge files works well.

So: keep the heavy lifting here, and consider Projects as a secondary read-only briefing room.
