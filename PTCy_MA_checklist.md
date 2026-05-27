# PTCy vs Non-PTCy Infection Meta-Analysis — Project Checklist

**Protocol lead:** R. Lewis (UniPD)
**Co-lead / 2nd reviewer:** BMT Program Director
**Target timeline:** 6–8 months to submission

Legend: [ ] = not started · [~] = in progress · [x] = done · [!] = blocked/awaiting decision

---

## Phase 0 — Pre-registration setup (Weeks 1–3)

### Protocol finalization
- [~] Confirm five locked analytical decisions (population, comparisons, outcomes, timepoints, overlap rules)
- [ ] Resolve outstanding decisions:
  - [ ] **ATG dose stratification as Moderator #10** — accept/modify/reject
  - [ ] **Target journal** — JAC / BMT / TCT / Haematologica / CMI
  - [ ] **Hard timeline anchors** — any conference abstract, student thesis, or grant deadline driving the schedule?
  - [ ] **Authorship roles** — first, co-first, senior, statistical methodologist, content experts
- [ ] Draft full PROSPERO protocol document (see `PTCy_PROSPERO_Protocol.docx`)
- [ ] Circulate protocol to BMT director co-reviewer for review/sign-off
- [ ] Incorporate co-reviewer comments, lock protocol v1.0

### PROSPERO registration
- [ ] Create PROSPERO account (if R.L. doesn't have one)
- [ ] Enter protocol metadata into PROSPERO submission form
- [ ] Submit for PROSPERO review
- [ ] Receive PROSPERO ID; add to protocol and Covidence review
- [ ] File PROSPERO confirmation email in project DEVONthink group

### Infrastructure setup
- [ ] Create Covidence review (using UniPD institutional access)
- [ ] Configure Covidence:
  - [ ] Paste PICO eligibility criteria into Covidence fields
  - [ ] Set up full-text exclusion reason list (ordered by expected frequency)
  - [ ] Configure highlights for screening keywords
  - [ ] Invite BMT director as second reviewer
  - [ ] Set screening conflict resolution to "third reviewer" or "consensus" (decide)
  - [ ] Upload ROBINS-I template
  - [ ] Upload RoB 2 template for the RCTs
- [ ] Create Quarto project `ptcy-infection-ma/` with subfolders:
  - [ ] `01_search/` — database export files, PRISMA flow raw data
  - [ ] `02_extraction/` — Excel template, completed extraction
  - [ ] `03_rob/` — ROBINS-I/RoB 2 forms
  - [ ] `04_analysis/` — brms models, posterior samples, figures
  - [ ] `05_manuscript/` — Quarto manuscript, references, supplements
  - [ ] `99_protocol/` — frozen protocol v1.0 and amendments log
- [ ] Initialize git repository, first commit with protocol v1.0
- [ ] Set up `renv` for R package version management
- [ ] Install core R packages: `brms`, `bayesmeta`, `metafor`, `meta`, `tidybayes`, `ggdist`, `robvis`, `PRISMA2020`, `synthesisr`, `litsearchr`, `RoBMA`, `gt`

### Library consultation
- [ ] Email UniPD biomedical librarian requesting:
  - [ ] Confirmation of Embase access interface (Elsevier vs Ovid)
  - [ ] PRESS peer review of search strategies
  - [ ] Confirmation of Web of Science access (Core Collection)
  - [ ] Institutional access to any additional databases (LILACS, CINAHL?)

---

## Phase 1 — Search execution (Weeks 3–5)

### Search string development
- [ ] Refine search strings using `litsearchr` seeded from Elicit corpus
- [ ] Pilot-test strategy against known included papers (must all be retrieved):
  - [ ] Holtan 2022 (BMT CTN 1703)
  - [ ] Moiseev 2016
  - [ ] Tang 2023 (MA, for reference checking)
  - [ ] Papanicolaou 2023 (CIBMTR IFI)
  - [ ] Salas 2023 (Barcelona primary)
  - [ ] Massoud 2021 (Hamburg)
  - [ ] Meyer 2024 (Freiburg)
  - [ ] Shaffer 2024 (CIBMTR MUD/MMUD)
- [ ] If any known papers missed, iterate on search terms
- [ ] Finalize search strings for all four databases
- [ ] Send to UniPD librarian for PRESS review
- [ ] Incorporate librarian's PRESS feedback
- [ ] Lock final search strategy in protocol as Supplementary File 1

### Run searches (all on same date if possible)
- [ ] PubMed/MEDLINE — save search, export RIS, record hit count + date
- [ ] Embase — save search, export RIS, record hit count + date
- [ ] Cochrane CENTRAL — save search, export RIS, record hit count + date
- [ ] Web of Science Core Collection — save search, export RIS, record hit count + date
- [ ] Document search dates and hit counts in protocol and Covidence "Date of last search" field

### Supplementary searches
- [ ] Forward citation tracking in Web of Science for key index publications (BMT CTN 1703, Goldsmith 2021, Papanicolaou 2023)
- [ ] Reference list screening of included systematic reviews (Tang 2023, Jin 2025, Dybko 2023, de Almeida 2025, Luo 2024, Shafqat 2025)
- [ ] PROSPERO search for ongoing/related reviews to check for duplication

### Import to Covidence
- [ ] Upload all RIS files to Covidence
- [ ] Let Covidence auto-deduplicate
- [ ] Record pre- and post-deduplication counts in PRISMA flow
- [ ] Spot-check 10 duplicate merges to verify Covidence deduplication accuracy

---

## Phase 2 — Title/abstract screening (Weeks 5–8)

### Calibration
- [ ] R.L. + BMT director both screen same 50 records (pilot) without consensus
- [ ] Compare inclusion decisions; calculate Cohen's kappa
- [ ] If kappa <0.7, meet to recalibrate PICO criteria; document clarifications in protocol amendment log
- [ ] If kappa ≥0.7, proceed to full screening

### Full screening
- [ ] Both reviewers independently screen all records (target: 50–100/day each)
- [ ] Flag conflicts in Covidence
- [ ] Resolve conflicts via consensus meeting (weekly or bi-weekly)
- [ ] Escalate persistent disagreements (>48h) to third-reviewer arbitration (identify now: another ID or hematology colleague)
- [ ] Record screening completion date; lock title/abstract phase in Covidence

---

## Phase 3 — Full-text retrieval and screening (Weeks 8–12)

### Full-text retrieval
- [ ] Generate list of papers needing full text from Covidence
- [ ] Retrieve via UniPD library; flag unavailable items
- [ ] Request inter-library loans for missing full texts
- [ ] Email corresponding authors for papers still unavailable after ILL (document attempts)
- [ ] After 2 documented retrieval attempts, exclude with reason "full text not obtainable"

### Full-text screening
- [ ] Both reviewers independently screen all retrieved full texts
- [ ] Apply exclusion reasons in priority order
- [ ] Consensus resolution for conflicts
- [ ] Generate PRISMA flow diagram in Covidence with final included/excluded counts

### Cohort overlap mapping
- [ ] Build `cohort_id` lookup table mapping each included study to unique patient cohort
- [ ] Apply overlap rule: one publication per cohort per outcome
- [ ] Document which publications are retained as primary vs flagged as overlapping
- [ ] Tag overlapping publications as "sensitivity analysis only" in extraction DB

---

## Phase 4 — Data extraction and RoB assessment (Weeks 10–16, overlapping with Phase 3)

### Extraction template setup
- [ ] Build Excel extraction template with controlled vocabularies:
  - [ ] Study metadata (authors, year, journal, DOI, country, enrollment period)
  - [ ] `cohort_id` + primary/overlapping flag
  - [ ] Study design (RCT, prospective, retrospective, registry)
  - [ ] Population characteristics (n, age median/range, sex, disease mix, disease status)
  - [ ] Transplant characteristics (donor type, graft source, conditioning intensity, HLA match)
  - [ ] CMV serostatus D/R distribution
  - [ ] GVHD prophylaxis regimen (detailed: PTCy dose/day, CNI, MMF, ATG agent/dose, other)
  - [ ] Supportive care (letermovir use/dates, antibacterial prophylaxis agent, antifungal prophylaxis agent)
  - [ ] Outcome events + denominators at each pre-specified timepoint:
    - [ ] BSI any pathogen D+30, D+100
    - [ ] Sepsis-3 / CTCAE grade ≥3 bacterial (sensitivity)
    - [ ] Any CMV reactivation D+100, D+180
    - [ ] Clinically significant CMV / CMV disease (sensitivity)
    - [ ] Invasive mold disease EORTC/MSG proven+probable D+180, 1yr
    - [ ] Invasive yeast disease EORTC/MSG proven+probable D+180, 1yr
    - [ ] Any IFI investigator-reported (sensitivity)
    - [ ] Infection-related mortality D+100, 1yr
    - [ ] NRM D+100, 1yr
  - [ ] Time-to-event data where reported (cumulative incidence functions, HRs, 95% CI, median time)
  - [ ] Incidence rate per patient-time (Khimani, Meyer style)
  - [ ] Follow-up duration
  - [ ] Outcome ascertainment method (active surveillance, routine screening frequency)
  - [ ] Reported subgroup data for each moderator
- [ ] Pilot the extraction template on 3 diverse studies (1 RCT, 1 registry, 1 single-center retrospective)
- [ ] Refine template based on pilot; freeze v1.0

### Dual extraction workflow
- [ ] R.L. performs primary extraction on all included studies
- [ ] BMT director verifies 100% of extractions against source PDFs
- [ ] Log all discrepancies and resolutions
- [ ] Contact authors for missing critical data (denominators at specified timepoints, confidence intervals)
- [ ] Record author contact attempts and outcomes

### Risk of bias assessment
- [ ] Categorize each study: RCT → RoB 2; non-randomized → ROBINS-I
- [ ] Both reviewers independently complete RoB forms in Covidence
- [ ] Consensus resolution for disagreements
- [ ] Export RoB summaries for use with `robvis`

---

## Phase 5 — Bayesian analysis (Weeks 16–20)

### Data preparation
- [ ] Export extracted data from Excel/Covidence to tidy CSV in `02_extraction/`
- [ ] Validate data: check denominators sum, events ≤ n, no missing timepoints for primary outcomes
- [ ] Build analytical datasets (one per outcome × comparison combination)
- [ ] Apply `cohort_id` deduplication for primary analyses

### Frequentist sanity-check pass
- [ ] Run `metafor::rma()` on each primary comparison × outcome
- [ ] Produce Baujat and GOSH plots via `dmetar`
- [ ] Flag any studies driving heterogeneity; verify extraction accuracy for those

### Primary Bayesian analyses
- [ ] For each of 3 primary comparisons × each primary outcome × primary timepoint:
  - [ ] Fit `brms` binomial-normal random-effects model
  - [ ] Priors: β ~ N(0, 1.5); τ ~ half-N(0, 0.5)
  - [ ] 4 chains, 4000 iter, check Rhat <1.01 and bulk/tail ESS >400
  - [ ] Extract posterior log-OR
  - [ ] Derive RR and RD from posterior arm-level probabilities
  - [ ] Generate forest plot via `bayesmeta` or custom `tidybayes` + `ggplot2`
  - [ ] Report posterior median + 95% CrI + posterior probability OR>1

### Meta-regression for moderators
- [ ] For each primary outcome, fit `brms` with pre-specified moderators:
  - Donor type, graft source, conditioning, letermovir era, antimold prophylaxis, PTCy dose, CMV serostatus distribution, era, region, ATG dose category (if Moderator #10 accepted)
- [ ] Report moderator-specific posteriors

### Sensitivity analyses
- [ ] Primary timepoint vs secondary timepoint (e.g., D+30 vs D+100 BSI)
- [ ] EORTC/MSG proven+probable vs "any IFI investigator-reported"
- [ ] Any CMV reactivation vs clinically significant CMV
- [ ] Inclusion of overlapping cohort publications (retained for sensitivity)
- [ ] Inclusion of conference abstracts (retained for sensitivity)
- [ ] Leave-one-out analysis per outcome
- [ ] Low-risk-of-bias-only restriction
- [ ] Prior sensitivity: τ ~ half-Cauchy(0, 0.5) and half-N(0, 1.0) re-runs
- [ ] Parallel Poisson model for incidence-rate studies (Khimani, Meyer)

### Publication bias
- [ ] `RoBMA` for each primary outcome (Bayesian model-averaged publication-bias assessment)
- [ ] Funnel plots for pairwise analyses with ≥10 studies

### GRADE certainty of evidence
- [ ] Complete GRADE assessment per primary outcome (5 domains)
- [ ] Produce Summary of Findings table via `gt`

---

## Phase 6 — Manuscript drafting (Weeks 20–26)

### Manuscript structure (Quarto)
- [ ] Draft sections in parallel:
  - [ ] Abstract (structured, target journal word limit)
  - [ ] Introduction (rationale, knowledge gap, objectives)
  - [ ] Methods (PRISMA 2020 compliant)
  - [ ] Results (PRISMA flow, characteristics table, forest plots, meta-regression, sensitivity, GRADE)
  - [ ] Discussion (principal findings, comparison with prior literature, strengths, limitations)
  - [ ] Conclusions
- [ ] Generate final figures:
  - [ ] PRISMA 2020 flow diagram via `PRISMA2020`
  - [ ] Forest plots per primary outcome
  - [ ] Posterior density displays by moderator stratum
  - [ ] Risk of bias summary via `robvis`
  - [ ] Heterogeneity diagnostic plots
- [ ] Generate tables:
  - [ ] Study characteristics (gt or flextable)
  - [ ] Summary of Findings (GRADE)
  - [ ] Moderator effects summary
- [ ] Write supplementary materials:
  - [ ] Full search strategies per database
  - [ ] Full extraction table
  - [ ] Full brms model code and convergence diagnostics
  - [ ] Prior sensitivity analysis results
  - [ ] Excluded studies with reasons

### Internal review
- [ ] R.L. completes first full draft
- [ ] BMT director critical review
- [ ] Revisions
- [ ] Optional: circulate to one external HSCT/ID colleague for pre-submission read
- [ ] Final proofreading

### Submission prep
- [ ] Check PRISMA 2020 checklist
- [ ] Complete target journal submission checklist
- [ ] Prepare cover letter
- [ ] Verify ICMJE authorship criteria met for all listed authors
- [ ] Declare conflicts of interest
- [ ] Declare funding sources
- [ ] Update PROSPERO record with publication status

### Post-submission
- [ ] Respond to reviewer comments (track in separate Quarto file)
- [ ] Update PROSPERO on acceptance
- [ ] Deposit preprint (medRxiv?) if journal permits
- [ ] Archive frozen data, code, and protocol v_final on Zenodo with DOI

---

## Running decisions log (amendments to locked protocol)

| Date | Decision | Rationale | Reviewed by |
|------|----------|-----------|-------------|
| YYYY-MM-DD | | | |

---

## Outstanding questions for R.L. and BMT director

1. ATG dose stratification as Moderator #10 — accept or modify?
2. Target journal preference?
3. Third reviewer for arbitration (if R.L. + BMT director disagree >10% of time) — who?
4. COI check: is BMT director's center represented in any corpus publications? If so, plan recusal workflow.
5. PROSPERO registrant — R.L. as PI; confirm contact email for PROSPERO notifications.
6. Authorship sketch — first/co-first/senior slots and additional content experts if any.
7. Funding to declare? UniPD departmental support, any grants?
8. Hard timeline anchors? ASH/EBMT abstract deadlines? Student thesis dependencies?

---

*Checklist v1.0 — living document; update as protocol evolves.*
