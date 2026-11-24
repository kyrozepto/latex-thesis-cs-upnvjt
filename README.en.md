# LaTeX Thesis Template for Fasilkom UPN "Veteran" Jawa Timur

[Bahasa Indonesia](README.md)

A LaTeX template for undergraduate theses at the Faculty of Computer Science, UPN "Veteran" Jawa
Timur. Front matter, margins, spacing, numbering, and bibliography follow the faculty's 2026 sample
thesis book. One repository carries you from proposal to final manuscript: chapters are written
once, then built into the document each stage needs.

See the output: [`template-preview-id.pdf`](template-preview-id.pdf) and
[`template-preview-en.pdf`](template-preview-en.pdf).

## Start in 3 steps

**1. Install LaTeX** (once).

- **Windows:** install [MiKTeX](https://miktex.org/download) for the current user ("for me only").
  Open **MiKTeX Console**, then:
  - **Updates** → **Check for updates** → **Update now**;
  - **Settings** → **General** → install missing packages → **Always**.
- **Linux:** `sudo apt install texlive-full` (Debian/Ubuntu) or
  `sudo dnf install texlive-scheme-full` (Fedora).
- **macOS:** `brew install --cask mactex`.

**2. Fill in your details** in one file: [`config/thesis-config.tex`](config/thesis-config.tex) —
title, name, NPM, advisors, examiners, dates, and keywords. For an English manuscript, also set
`\ThesisLanguage` to `english`, or just use the `en` build targets below.

**3. Build.**

```bash
build proposal        # Windows
./build.sh proposal   # Linux, macOS, WSL
```

The result is `proposal.pdf`. The first MiKTeX build can take a few minutes while packages download;
later builds take seconds.

## What you can build

| Command | Output | Content | For |
|---|---|---|---|
| `build proposal` | `proposal.pdf` | Ch. I–III | proposal seminar |
| `build draft` | `skripsi-draft.pdf` | Ch. I–IV + appendix | supervision |
| `build semhas` | `semhas.pdf` | Ch. I–V + abstract | results seminar |
| `build skripsi` | `main.pdf` | full manuscript | final manuscript (screen) |
| `build cetak` | `main-cetak.pdf` | full manuscript | two-sided print |
| `build en` | `main-en.pdf` | full manuscript | English edition |
| `build en-cetak` | `main-en-cetak.pdf` | full manuscript | English edition, two-sided print |
| `build all` | all of the above | | |
| `build clean` | removes auxiliary files | | run it when output looks wrong |

Every manuscript uses the same chapter files. When the proposal becomes a thesis, nothing is copied;
you just run a different build command.

## Where to write

```text
config/thesis-config.tex      your details, title, dates       <- fill in once
chapters/english/ch01..ch05   Chapters I to V                  <- day-to-day writing
content/english/              abstract, acknowledgements, glossary, list of symbols
appendices/english/appA.tex   appendix
references/example.bib        bibliography
figures/                      images
```

For an Indonesian manuscript, write in the matching `indonesian/` folders. The other files
(`template.cls`, `content/*.tex`, `config/thesis-preamble.tex`) control the format and need no
changes.

Every sample chapter already has the section skeleton, example figures, tables, equations, and
algorithms, plus **"Complete this section"** boxes that explain what goes in each section. The boxes
appear only in `main.pdf` and disappear from the proposal, draft, and semhas files.

## Full guide

[`docs/guide.md`](docs/guide.md) covers:

- the settings in `thesis-config.tex` (language, outer cover, QR code, helper boxes);
- the skeleton of each chapter;
- figures, tables, equations, algorithms, cross-references, citations, and appendices;
- the print edition and preparing files for the print shop;
- TikZ figures;
- why a build fails and how to fix it.

## Pre-submission checklist

- [ ] Every field in `config/thesis-config.tex` is correct, including the defense date, the signing
      date, and the QR-code link.
- [ ] Names and NIP/NPT of advisors, examiners, the dean, and the study-program coordinator are
      checked.
- [ ] The signature-page format and the duty-stamp (meterai) requirement are confirmed with the
      study program.
- [ ] The QR code on the statement of originality has been scanned and opens the right link.
- [ ] `\ThesisShowHelpers` is `off`, and no `\TemplateTodo`, `\TemplateTip`, `\Placeholder`, or
      `\FigurePlaceholder` calls remain.
- [ ] Every bundled example has been replaced with your own content.
- [ ] `build clean` followed by `build skripsi` finishes with no `undefined references` note.

## Disclaimer

This template is a technical aid. Official requirements may change at any time; always check the
final document against the latest guidance from your study program, faculty, and advisors.
