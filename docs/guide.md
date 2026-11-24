# Full Guide

[← Back to README](../README.en.md) · [Bahasa Indonesia](panduan.md)

- [Settings](#settings)
- [What each manuscript contains](#what-each-manuscript-contains)
- [Chapter skeleton](#chapter-skeleton)
- [Figures](#figures)
- [Tables](#tables)
- [Equations and algorithms](#equations-and-algorithms)
- [Cross-references and citations](#cross-references-and-citations)
- [Appendix](#appendix)
- [Glossary and list of symbols](#glossary-and-list-of-symbols)
- [Print edition](#print-edition)
- [TikZ figures](#tikz-figures)
- [When a build fails](#when-a-build-fails)
- [File structure](#file-structure)

## Settings

All settings live in `config/thesis-config.tex`.

| Field | Values | Meaning |
|---|---|---|
| `\ThesisLanguage` | `indonesian` / `english` | Label language and the folders that are read. `build en` and `build en-cetak` use English without changing this field. |
| `\ThesisDocumentType` | `skripsi` / `tesis` | Prints *Undergraduate Thesis* or *Thesis* throughout. |
| `\ThesisShowHelpers` | `auto` / `on` / `off` | The "Complete this section" boxes. `auto`: shown only in `main.pdf`. Set `off` for the submitted manuscript. |
| `\ThesisColorCover` | `auto` / `on` / `off` | Orange outer cover. `auto`: final manuscript only. |
| `\DefenseDateID` / `EN` | date | Defense date, printed on the approval sheet. |
| `\SignDateID` / `EN` | date | Signing date of the statement of originality and the acknowledgements, usually after revisions. |
| `\OriginalityQRLink` | link | Printed as a QR code beside the signature on the statement of originality, for example a supporting-files folder. Leave it empty to drop the QR code. |

The rest is plain data: Indonesian and English titles, name, NPM, study program, advisors, head
examiner and examiner I, dean, study-program coordinator, year, and keywords.

Run `build clean` whenever you switch languages, because the old table of contents is still cached.

## What each manuscript contains

| | `proposal` | `draft` | `semhas` | `skripsi` |
|---|---|---|---|---|
| Chapters | I–III | I–IV | I–V | I–V |
| Cover reads | RESEARCH PROPOSAL | THESIS (DRAFT CH. I--IV) | UNDERGRADUATE THESIS | UNDERGRADUATE THESIS |
| Orange outer cover | – | – | – | ✓ |
| Approval sheets, statement of originality | – | – | – | ✓ |
| Abstract | – | – | ✓ | ✓ |
| Acknowledgements | – | – | – | ✓ |
| Contents, figures, tables, glossary, symbols | ✓ | ✓ | ✓ | ✓ |
| List of algorithms, list of appendices, appendix | – | ✓ | ✓ | ✓ |

The print and English editions have the same content as `skripsi`. There is no list of
abbreviations: abbreviations go in the glossary.

## Chapter skeleton

The chapter skeleton follows the structure of a thesis that has passed. Every chapter opens with one
introductory paragraph before its first section. Chapter titles are uppercased automatically, and
the `CHAPTER I` and `3.2.1.` numbering is handled by the template.

| Chapter | Sections |
|---|---|
| I Introduction | Background, Research Questions, Research Objectives, Research Benefits, Scope and Limitations |
| II Literature Review | Related Work, then one section per theory concept (no "Theoretical Foundation" umbrella section) |
| III Research Methodology | Research Workflow, Literature Review, Requirements Analysis, Data Collection, design sections for your method, Testing, Evaluation |
| IV Results and Discussion | Research Environment and Execution, results sections paired with the Chapter III sections, Discussion (Answers to the Research Questions, Comparison with Prior Studies, Threats to Validity) |
| V Conclusions and Recommendations | Conclusions, Recommendations |

Pseudocode goes in Chapter IV, not Chapter III, because it reports the procedure that was actually
run. That is also why the proposal does not load the algorithm package at all.

## Figures

Put the file in `figures/`, then:

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\linewidth]{figure-name.pdf}
  \caption{Figure caption.}
  \label{fig:figure-name}
\end{figure}
```

Refer to it with `Figure~\ref{fig:figure-name}`; never type the number yourself.

| Need | How | Example in |
|---|---|---|
| Image not ready yet | `\FigurePlaceholder{4cm}{description}` inside `figure`; number and caption stay alive | Chapter III |
| Panels (a)/(b) on one image | panel labels drawn with TikZ | Chapter II |
| Panels from separate files | each file in a `minipage[t]`, one shared caption | Chapter IV |
| Long caption | `\caption[Short title for the list]{Full title}` | Chapter IV |
| Screenshots, scanned documents | `\BorderedGraphics[width=\linewidth]{file.png}` (thin frame) | Chapter IV, Appendix 2 |
| English-labelled figure | save it in `figures/english/` under the same name | |
| Python plots | `tools/plot_style.py` matches font and width to the manuscript | |

## Tables

Four table forms ship in the sample manuscript, each explained in its comments:

| Form | When | Example |
|---|---|---|
| Fixed `P{...}` columns + one flexible `Y` column | the common case | Table 3.1 |
| All columns flexible, weighted `L{...}` | every column holds sentences | Table 2.1 |
| `longtable` with `l`/`c` columns | numeric tables | Table 4.1 |
| Smaller font inside `\begingroup` | many columns | Table 4.2 |

Rules for every table:

- Do not wrap it in `\begin{table}` and do not use `[H]`; these tables break across pages and place
  themselves.
- `\caption` and `\label` go on the first line inside the table, ended with `\\`.
- Mention the table in a sentence before it appears, then discuss it afterwards.
- The Indonesian edition uses a decimal comma. In math mode write `$0{,}00$`.

`P`, `Y`, and `L` columns are ragged right so narrow columns are not stretched into gappy lines.

## Equations and algorithms

Equations are numbered automatically, `(2.1)`:

```latex
\begin{equation}
  E = mc^2
  \label{eq:einstein}
\end{equation}
```

Algorithms are numbered `Algorithm 4. 1`, fully framed, and listed in the LIST OF ALGORITHMS:

```latex
\begin{algorithm}[H]
\caption{Algorithm title}\label{alg:name}
\KwInput{Input}
\KwOutput{Output}
First step \tcp*{end-of-line comment, replaces \;}
\tcp{a full-line comment}
\ForEach{item}{
  A step inside the loop\;
}
\KwReturn{Result}
\end{algorithm}
```

`\KwInput`, `\KwOutput`, and `\KwReturn` follow the manuscript language automatically.

## Cross-references and citations

| What | How to write it | Result |
|---|---|---|
| Figure, table, equation, algorithm | `Figure~\ref{fig:name}` | Figure 3. 1 |
| Section | `Section \nameref{sec:name}` | Section *its title* |
| Appendix | type its number: `Appendix 1`; its contents with `\ref` | Table A.1 in Appendix 1 |
| Reference | `\cite{key}` or `\cite{a,b}` | [4],[5] |

`\nameref` prints the section title, so the reference stays right when numbering shifts.

The bibliography uses IEEE style (`IEEEtran-doi.bst`): entries with a `doi` print `doi: ...`, online
entries with `url` and `urldate` print `Accessed: ... [Online]. Available: ...`, and more than six
authors become "et al.". `references/example.bib` has one example of each. Always fill in `doi` when
the source has one.

For more than one `.bib` file, change the line in `content/backmatter.tex` to
`\bibliography{references/example,references/another}` (no extension).

## Appendix

The appendix lives in `appendices/<language>/appA.tex`:

```latex
\AppendixSection{Appendix 1. Appendix Title}
\AppendixSubsection{Subsection Title}
\AppendixSection{Appendix 2. Next Appendix Title}
```

- Appendices are numbered, not lettered; their subsections are unnumbered.
- Tables and figures in the appendix are numbered `Table A.1` and `Figure A.1` (`Tabel L.1`,
  `Gambar L.1` in the Indonesian edition), separate from Chapter IV.
- Appendix detail goes in the LIST OF APPENDICES; the table of contents shows a single APPENDIX
  entry. That is why plain `\section` must not be used in the appendix.
- Every appendix after the first starts on a new page.
- Scanned documents, such as an ethics letter or a data validation form, go in with
  `\BorderedGraphics`.

## Glossary and list of symbols

- `content/<language>/glossary.tex` (GLOSSARY): domain terms with abbreviations and their
  expansions, in alphabetical order. Leave out terms every reader already knows.
- `content/<language>/symbols.tex` (LIST OF SYMBOLS): core notation used across chapters, ordered
  Latin, Greek, then calligraphic. A symbol used in only one equation is explained below that
  equation. With no equations, remove the LIST OF SYMBOLS block from `content/frontmatter-lists.tex`.

## Print edition

`build cetak` and `build en-cetak` produce the same manuscript laid out for two-sided printing:

- every front-matter page and every chapter starts on a right-hand page;
- the 4 cm margin is always on the binding side;
- filler pages say "This page is intentionally left blank";
- the orange outer cover stays one-sided.

For the print shop, run `python tools/siapkan_cetak.py` (needs `pip install pypdf`). It splits
`main-cetak.pdf` into the outer cover, the whole book, the front matter one-sided, and the body
two-sided, in `siap_cetak_main-cetak/`. Ask the print shop or your study program which parts are
printed one-sided.

## TikZ figures

TikZ diagrams and pgfplots charts are pre-rendered to PDF in `figures/`:

```bash
cd tikz
build figure-name        # Windows; no name = every figure
bash build.sh            # Linux, macOS, WSL
```

`tikz/preamble.tex` provides flowchart styles, chart styles, and `\gridmat`/`\window` for drawing
matrices with values (convolution, pooling). See [`tikz/README.md`](../tikz/README.md) and the
examples `tikz/example-diagram.tex` and `tikz/example-grid.tex`. Photos and screenshots go straight
into `figures/`.

## When a build fails

`build` prints the error lines from the `.log` file when it fails.

| Symptom | Cause and fix |
|---|---|
| Build hangs, or `File '...sty' not found` | MiKTeX is not installing packages automatically. Set **Settings → General → Always** in MiKTeX Console. |
| `major issue: ... checked for updates` | Only a warning. Run **Check for updates** in MiKTeX Console once. |
| `I found no \citation commands` | No `\cite` yet. Not an error. |
| `NOTE: undefined references remain` | A `\ref` or `\cite` has a typo. Find the name in the `.log` file. |
| References show as `??` | `pdflatex` was run on its own. Use `build`, which runs all four passes. |
| List titles still in the old language | Run `build clean`, then rebuild. |
| `Environment algorithm undefined` | An algorithm is used in Chapters I–III. Move it to Chapter IV. |
| `File 'logo_upn.png' not found` | The build was started from another folder. Run `build` from the repository folder. |

## File structure

```text
.
├── build.bat / build.sh          build scripts
├── main.tex                      full manuscript (also used by the print, English, semhas editions)
├── main-cetak.tex, main-en.tex, main-en-cetak.tex, semhas.tex
├── proposal.tex, skripsi-draft.tex
├── template.cls                  page format, typography, numbering
├── IEEEtran-doi.bst              bibliography style
├── config/
│   ├── thesis-config.tex         your details
│   ├── thesis-language.tex       Indonesian/English labels
│   └── thesis-preamble.tex       shared packages and macros
├── content/                      covers, front matter, lists, bibliography
│   ├── indonesian/               abstract, acknowledgements, glossary, list of symbols
│   └── english/
├── chapters/{indonesian,english}/ch01..ch05.tex
├── appendices/{indonesian,english}/appA.tex
├── figures/                      images (figures/english/ for English versions)
├── references/example.bib
├── tikz/                         TikZ figure sources
└── tools/                        siapkan_cetak.py, plot_style.py
```
