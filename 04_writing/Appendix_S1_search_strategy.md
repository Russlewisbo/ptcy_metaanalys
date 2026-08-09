# Appendix S1: Search Strategy

*Status: drafted from PROSPERO protocol (`PTCy_PROSPERO_Protocol_Final.docx`); flagged items below need confirmation before this is submission-ready.*

## Table S1: Search strategy summary

| Field | Content |
|---|---|
| **Databases searched** | PubMed/MEDLINE, EMBASE (Elsevier), SCOPUS |
| **Search dates** | Database inception to **[FINAL SEARCH DATE — not recorded in the protocol; must be pulled from the Covidence/RIS export log]** |
| **Records retrieved** | PubMed: 1,061 · EMBASE: 2,603 · SCOPUS: 481 (total 4,145; source: `PRISMA_2020_flow_data.md`) |
| **Date limits applied** | **Conflicting across sources — see Flag 2 below** |
| **Language limit** | English |
| **Publication types excluded via filter** | None — conference abstracts, editorials, letters, and case reports are excluded at screening, not via search filters, to minimize inappropriate exclusion |
| **Other sources searched** | Reference list screening of included studies and prior systematic reviews; forward citation tracking (Web of Science) for key index publications; PROSPERO search for related/ongoing reviews |
| **Deduplication / management** | RIS export from each database, imported into Covidence for deduplication and screening |
| **Peer review of strategy** | Planned via PRESS (Peer Review of Electronic Search Strategies) checklist by a biomedical librarian, University of Padova |
| **Search piloted against** | 8 known included publications (Holtan 2022, Moiseev 2016, Tang 2023, Papanicolaou 2023, Salas 2023, Massoud 2021, Meyer 2024, Shaffer 2024) to verify recall |

## PubMed/MEDLINE search strategy (draft, reconstructed from protocol concept blocks)

The protocol specifies three concept blocks combined with AND, each block an OR of MeSH terms and free-text synonyms. Reconstructed as a PubMed syntax string:

```
#1  Allogeneic HCT population
    ("Hematopoietic Stem Cell Transplantation"[Mesh] OR "Bone Marrow Transplantation"[Mesh]
    OR "allogeneic stem cell transplant*"[tiab] OR "allo-HCT"[tiab] OR "allo-HSCT"[tiab]
    OR "haploidentical"[tiab] OR "HLA-matched"[tiab] OR "matched unrelated donor"[tiab]
    OR "mismatched unrelated donor"[tiab])

#2  PTCy intervention
    ("post-transplant cyclophosphamide"[tiab] OR "post-transplantation cyclophosphamide"[tiab]
    OR "posttransplant cyclophosphamide"[tiab] OR "posttransplantation cyclophosphamide"[tiab]
    OR "PTCy"[tiab] OR "PT-Cy"[tiab] OR "PTCY"[tiab]
    OR ("Cyclophosphamide"[Mesh] AND "Graft vs Host Disease"[Mesh]))

#3  Infection outcomes
    ("Infections"[Mesh] OR "Bacterial Infections"[Mesh] OR "Virus Diseases"[Mesh]
    OR "Mycoses"[Mesh] OR "Bacteremia"[Mesh] OR "Sepsis"[Mesh]
    OR "Cytomegalovirus Infections"[Mesh] OR "Invasive Fungal Infections"[Mesh]
    OR "bacterial infection*"[tiab] OR "viral infection*"[tiab] OR "fungal infection*"[tiab]
    OR "BSI"[tiab] OR "sepsis"[tiab] OR "CMV"[tiab] OR "EBV"[tiab] OR "HHV-6"[tiab]
    OR "BK virus"[tiab] OR "aspergillosis"[tiab] OR "candida"[tiab] OR "mucormycosis"[tiab]
    OR "mold"[tiab] OR "yeast"[tiab] OR "mortality"[tiab])

#4  #1 AND #2 AND #3

Filters: Humans; English
```

**This string is a reconstruction from the protocol's concept-block term lists, not a verbatim copy of the actual executed/PRESS-reviewed query.** It has not been run, has no associated hit count, and has not undergone the PRESS peer review the protocol calls for. It should be replaced with the actual final string and per-database hit count once retrieved from the database export logs, before this appendix is submission-ready.

## EMBASE (Emtree) search strategy (draft, translated from the PubMed string above)

**Flags 1–3 below are still unresolved** — this is a term-level translation of the same unverified PubMed draft, not a confirmation that the underlying concept blocks, date limit, or search date are final. Written in Embase.com (Elsevier) syntax; Ovid Embase syntax differs (e.g. `exp` before the heading, `.mp.` / `.ti,ab.` field codes, no leading quote-and-slash).

```
#1  Allogeneic HCT population
    ('bone marrow transplantation'/exp OR 'stem cell transplantation'/exp
    OR 'allogeneic stem cell transplant*':ti,ab OR 'allo-hct':ti,ab OR 'allo-hsct':ti,ab
    OR haploidentical:ti,ab OR 'hla-matched':ti,ab OR 'matched unrelated donor':ti,ab
    OR 'mismatched unrelated donor':ti,ab)

#2  PTCy intervention
    ('post-transplant cyclophosphamide':ti,ab OR 'post-transplantation cyclophosphamide':ti,ab
    OR 'posttransplant cyclophosphamide':ti,ab OR 'posttransplantation cyclophosphamide':ti,ab
    OR ptcy:ti,ab OR 'pt-cy':ti,ab
    OR ('cyclophosphamide'/exp AND 'graft versus host reaction'/exp))

#3  Infection outcomes
    ('infection'/exp OR 'bacterial infection'/exp OR 'virus infection'/exp OR 'mycosis'/exp
    OR 'bacteremia'/exp OR 'sepsis'/exp OR 'cytomegalovirus infection'/exp
    OR 'invasive fungal infection'/exp
    OR 'bacterial infection*':ti,ab OR 'viral infection*':ti,ab OR 'fungal infection*':ti,ab
    OR bsi:ti,ab OR sepsis:ti,ab OR cmv:ti,ab OR ebv:ti,ab OR 'hhv-6':ti,ab
    OR 'bk virus':ti,ab OR aspergillosis:ti,ab OR candida:ti,ab OR mucormycosis:ti,ab
    OR mold:ti,ab OR yeast:ti,ab OR mortality:ti,ab)

#4  #1 AND #2 AND #3

Filters: #4 AND [humans]/lim AND [english]/lim
```

## SCOPUS search strategy (draft, translated from the PubMed string above)

**Same caveat as above** — flags 1–3 remain open. Scopus has no controlled-vocabulary thesaurus (no MeSH/Emtree equivalent), so this block relies entirely on the free-text terms via `TITLE-ABS-KEY()`, with the MeSH/Emtree-only concepts (e.g. "Hematopoietic Stem Cell Transplantation") added back in as plain-text phrases.

```
TITLE-ABS-KEY(
  ("allogeneic stem cell transplant*" OR "allo-HCT" OR "allo-HSCT"
   OR "hematopoietic stem cell transplantation" OR "bone marrow transplantation"
   OR haploidentical OR "HLA-matched" OR "matched unrelated donor" OR "mismatched unrelated donor")
  AND
  ("post-transplant cyclophosphamide" OR "post-transplantation cyclophosphamide"
   OR "posttransplant cyclophosphamide" OR "posttransplantation cyclophosphamide"
   OR PTCy OR "PT-Cy" OR (cyclophosphamide AND "graft versus host disease"))
  AND
  (infection* OR "bacterial infection*" OR "viral infection*" OR "fungal infection*"
   OR BSI OR sepsis OR bacteremia OR CMV OR "cytomegalovirus infection*" OR EBV OR "HHV-6"
   OR "BK virus" OR aspergillosis OR candida OR mucormycosis OR mold OR yeast
   OR "invasive fungal infection*" OR mortality)
)
AND LANGUAGE(english)
```

Per the protocol, no document-type filter (e.g. excluding conference abstracts) is applied at the search stage in any of the three strings — that exclusion happens during screening instead.

## Flags requiring resolution before finalizing

1. **Database mismatch.** The protocol (§3.2 Information Sources) names four planned databases: PubMed/MEDLINE, Embase, **Cochrane CENTRAL**, and **Web of Science Core Collection**. The actual executed search, per the PRISMA 2020 flow data (`PRISMA_2020_flow_data.md`) and the manuscript draft, used PubMed, EMBASE, and **SCOPUS** — Cochrane CENTRAL and Web of Science do not appear in the executed counts, and SCOPUS is not in the protocol's list. This needs to be reconciled: either the protocol was amended (and that amendment documented) or the reported PRISMA counts need correction. Because SCOPUS and EMBASE are the databases actually reflected in the PRISMA counts, strings were drafted for those two rather than for Cochrane CENTRAL/Web of Science — but this does not resolve the underlying discrepancy about which databases the protocol says should have been searched.
2. **Date-limit mismatch.** The protocol (§3.3) specifies a filter of "publication date 2010 to present." The manuscript's Methods section instead states the search covered "database inception to [date]" with no 2010 lower bound. These cannot both be correct — confirm which was actually applied, then add the corresponding date filter to all three strings above (none currently include one).
3. **Final search date missing.** Neither the protocol nor the PRISMA flow data file records the actual date each database was searched. The protocol states this "will be recorded for each database" but the value itself isn't filled in anywhere I could find.
4. **All three strings are unverified reconstructions.** None have been run, have an associated hit count, or have undergone the PRESS peer review the protocol calls for. They should be replaced with the actual final strings and per-database hit counts once retrieved from the database export logs, before this appendix is submission-ready.

*Source: `PTCy_PROSPERO_Protocol_Final.docx` §3.2–3.3; `04_writing/PRISMA_2020_flow_data.md`.*
