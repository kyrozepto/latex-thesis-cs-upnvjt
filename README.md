# Template LaTeX Skripsi/Thesis Fasilkom UPN "Veteran" Jawa Timur

Template ini adalah template LaTeX untuk skripsi/undergraduate thesis Program Studi Informatika, Fakultas Ilmu Komputer, Universitas Pembangunan Nasional "Veteran" Jawa Timur.

Fokus utama versi ini adalah **mode bahasa yang mudah diganti**. Mahasiswa dapat mengganti sebagian besar label dokumen dari Bahasa Indonesia ke English hanya dengan mengubah satu variabel di file konfigurasi.

## Fitur utama

- Satu project untuk dua mode bahasa:
  - `indonesian` untuk format skripsi Bahasa Indonesia.
  - `english` untuk format thesis English.
- Metadata dipusatkan di `config/thesis-config.tex`.
- Label dokumen dipusatkan di `config/thesis-language.tex`.
- Tipe dokumen dapat dipilih antara `skripsi` dan `tesis`.
- Struktur dokumen tetap sederhana:
  - `main.tex` sebagai file utama.
  - `template.cls` untuk format halaman dan tipografi.
  - `chapters/` untuk Bab I sampai Bab V.
  - `appendices/` untuk lampiran.
  - `references/` untuk BibTeX.
  - `figures/` untuk gambar.
- Chapter, section, caption, daftar isi, daftar gambar, daftar tabel, daftar kode, daftar pustaka, dan lampiran dapat mengikuti bahasa yang dipilih.
- `DAFTAR PUSTAKA`/`BIBLIOGRAPHY` dan `LAMPIRAN`/`APPENDIX` masuk daftar isi tanpa awalan `BAB`/`CHAPTER`.

## Struktur project

```text
.
├── main.tex
├── template.cls
├── logo_upn.png
├── config/
│   ├── thesis-config.tex      # metadata dan pilihan bahasa
│   └── thesis-language.tex    # kamus label Indonesia/English
├── chapters/
│   ├── ch01-introduction.tex
│   ├── ch02-literature-review.tex
│   ├── ch03-methodology.tex
│   ├── ch04-results-discussion.tex
│   └── ch05-conclusion-recommendations.tex
├── appendices/
│   └── appA.tex
├── figures/
│   ├── README.md
│   └── example-figure.pdf
└── references/
    └── example.bib
```

## Cara mengganti Bahasa Indonesia ke English

Buka file:

```text
config/thesis-config.tex
```

Cari baris:

```latex
\newcommand{\ThesisLanguage}{indonesian}
```

Ganti menjadi:

```latex
\newcommand{\ThesisLanguage}{english}
```

Lalu compile ulang. Sebagian besar label akan berubah otomatis, misalnya:

- `Skripsi` → `Undergraduate Thesis`
- `BAB I` → `CHAPTER I`
- `DAFTAR ISI` → `TABLE OF CONTENTS`
- `DAFTAR GAMBAR` → `LIST OF FIGURES`
- `DAFTAR TABEL` → `LIST OF TABLES`
- `DAFTAR KODE` → `LIST OF CODE`
- `DAFTAR PUSTAKA` → `BIBLIOGRAPHY`
- `LAMPIRAN` → `APPENDIX`
- `Kata Kunci` → `Keywords`

## Cara mengganti tipe dokumen

Buka file:

```text
config/thesis-config.tex
```

Cari baris:

```latex
\newcommand{\ThesisDocumentType}{skripsi}
```

Nilai yang tersedia:

- `skripsi`: tampil sebagai `Skripsi` dalam Bahasa Indonesia dan `Undergraduate Thesis` dalam English.
- `tesis`: tampil sebagai `Tesis` dalam Bahasa Indonesia dan `Thesis` dalam English.

## Metadata yang perlu diganti mahasiswa

Semua metadata utama berada di:

```text
config/thesis-config.tex
```

Bagian yang biasanya perlu diganti:

```latex
\newcommand{\ThesisTitleID}{Judul Skripsi Bahasa Indonesia ...}
\newcommand{\ThesisTitleEN}{English Thesis Title ...}
\newcommand{\StudentName}{Nama Lengkap Mahasiswa}
\newcommand{\StudentID}{Nomor Pokok Mahasiswa}
\newcommand{\AdvisorOne}{Nama Dosen Pembimbing I, Gelar}
\newcommand{\AdvisorTwo}{Nama Dosen Pembimbing II, Gelar}
\newcommand{\ExaminerOne}{Nama Ketua Penguji, Gelar}
\newcommand{\ExaminerTwo}{Nama Anggota Penguji, Gelar}
\newcommand{\DefenseDateID}{Tanggal Bulan Tahun}
\newcommand{\DefenseDateEN}{Month Day, Year}
\newcommand{\SubmissionYear}{Tahun}
\newcommand{\KeywordsID}{kata kunci pertama, kata kunci kedua, kata kunci ketiga}
\newcommand{\KeywordsEN}{first keyword, second keyword, third keyword}
```

Nama dekan dan koordinator program studi tetap disediakan dalam konfigurasi, tetapi harus tetap diverifikasi dengan pedoman fakultas/prodi terbaru sebelum pengumpulan resmi.

## Cara menulis isi bab dalam dua bahasa

Template menyediakan perintah:

```latex
\Lang{teks Bahasa Indonesia}{English text}
```

Contoh:

```latex
\section{\Lang{Latar Belakang}{Background}}
```

Jika `\ThesisLanguage` bernilai `indonesian`, yang tampil adalah `Latar Belakang`.
Jika bernilai `english`, yang tampil adalah `Background`.

Untuk naskah final, mahasiswa boleh memilih salah satu pendekatan:

1. Tetap memakai `\Lang{...}{...}` agar satu source dapat menghasilkan dua versi bahasa.
2. Menghapus sisi bahasa yang tidak dipakai setelah final jika hanya ingin mempertahankan satu versi.

## Cara compile

Dari root project, jalankan:

```bash
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

Jika belum memakai sitasi BibTeX, `bibtex main` bisa dilewati. Namun, untuk dokumen final dengan daftar pustaka, gunakan alur lengkap.

## Menambahkan gambar

Simpan gambar ke folder `figures/`, lalu gunakan:

```latex
\begin{figure}[H]
\centering
\includegraphics[width=0.85\linewidth]{example-figure.pdf}
\caption{\Lang{Judul gambar Bahasa Indonesia}{English figure caption}}
\label{fig:example-figure}
\end{figure}
```

Rujuk dengan:

```latex
Gambar~\ref{fig:example-figure}
```

atau untuk English:

```latex
Figure~\ref{fig:example-figure}
```

Contoh figure sudah tersedia di `chapters/ch02-literature-review.tex` dan memakai file `figures/example-figure.pdf`.

## Menambahkan notasi matematika

Gunakan environment `equation` untuk rumus bernomor:

```latex
\begin{equation}
\mathbf{a}^{[l]} = \sigma\left(\mathbf{W}^{[l]}\mathbf{a}^{[l-1]} + \mathbf{b}^{[l]}\right)
\end{equation}
```

Nomor persamaan mengikuti bab dengan angka Arab, misalnya `(2.1)`, walaupun judul bab tetap tampil sebagai `BAB II`.

## Menambahkan kode program atau algoritma

Template memakai `algorithm2e` untuk contoh kode program/algoritma. Gunakan:

```latex
\begin{algorithm}[H]
\caption{\Lang{Contoh format algoritma penelitian}{Example research algorithm format}}
\KwInput{\Lang{Data atau masukan penelitian}{Research data or input}}
\KwOutput{\Lang{Hasil yang dievaluasi}{Evaluated results}}
\Lang{Lakukan tahap persiapan data}{Perform data preparation}\;
\KwReturn{\Lang{Ringkasan hasil dan analisis}{Summary of results and analysis}}
\end{algorithm}
```

Caption akan masuk ke `DAFTAR KODE` / `LIST OF CODE` dengan format seperti `Kode Program 3. 1`.

## Menambahkan referensi

Tambahkan entri BibTeX ke file di folder `references/`, misalnya `references/example.bib`.

Sitasi di teks:

```latex
... \cite{exampleReference}
```

Jika menambah file BibTeX baru, ubah bagian akhir `main.tex`:

```latex
\bibliography{references/example,references/nama_file_baru}
```

## Menghapus tips template sebelum final

Template memakai helper:

```latex
\TemplateTip{...}
\TemplateTodo{...}
```

Sebelum dokumen resmi dikumpulkan, cari dan hapus semua pemanggilan tersebut, lalu ganti dengan isi naskah final.

## Checklist sebelum publikasi GitHub

- [ ] Tidak ada data pribadi, tanda tangan, atau dokumen administrasi sensitif.
- [ ] Metadata mahasiswa masih placeholder.
- [ ] Nama dekan dan koordinator prodi sudah diverifikasi.
- [ ] File build LaTeX tidak ikut di-commit jika tidak diperlukan.
- [ ] README menjelaskan cara compile dan cara mengganti bahasa.
- [ ] Template berhasil compile dalam mode `indonesian` dan `english`.

## Disclaimer

Template ini adalah bantuan teknis. Format resmi dapat berubah sewaktu-waktu. Selalu cocokkan hasil akhir dengan pedoman terbaru dari program studi, fakultas, dan dosen pembimbing.

---

# LaTeX Thesis Template for Fasilkom UPN "Veteran" Jawa Timur

This repository provides a LaTeX template for undergraduate thesis or thesis writing at the Informatics Study Program, Faculty of Computer Science, Universitas Pembangunan Nasional "Veteran" Jawa Timur.

The template is designed around centralized configuration. Most document metadata, document type, study program name, and language-dependent labels can be changed from the files in `config/`.

## Main Features

- One source project for Indonesian and English document labels.
- Document type can be selected as `skripsi` or `tesis`.
- Main metadata is centralized in `config/thesis-config.tex`.
- Language labels are centralized in `config/thesis-language.tex`.
- The template includes examples for tables, figures, mathematical notation, and code/algorithm blocks.
- Table of contents, list of figures, list of tables, list of code, bibliography, and appendix headings follow the selected language.
- Bibliography and appendix entries are added to the table of contents without `BAB` or `CHAPTER` prefixes.

## Project Structure

```text
.
├── main.tex
├── template.cls
├── logo_upn.png
├── config/
│   ├── thesis-config.tex
│   └── thesis-language.tex
├── chapters/
│   ├── ch01-introduction.tex
│   ├── ch02-literature-review.tex
│   ├── ch03-methodology.tex
│   ├── ch04-results-discussion.tex
│   └── ch05-conclusion-recommendations.tex
├── appendices/
│   └── appA.tex
├── figures/
│   ├── README.md
│   └── example-figure.pdf
└── references/
    └── example.bib
```

## Changing the Language

Open:

```text
config/thesis-config.tex
```

Set:

```latex
\newcommand{\ThesisLanguage}{english}
```

Available values are:

- `indonesian`
- `english`

When set to `english`, labels such as `BAB`, `DAFTAR ISI`, `DAFTAR GAMBAR`, and `DAFTAR PUSTAKA` are rendered as `CHAPTER`, `TABLE OF CONTENTS`, `LIST OF FIGURES`, and `BIBLIOGRAPHY`.

## Changing the Document Type

Open:

```text
config/thesis-config.tex
```

Set:

```latex
\newcommand{\ThesisDocumentType}{skripsi}
```

Available values are:

- `skripsi`: rendered as `Skripsi` in Indonesian and `Undergraduate Thesis` in English.
- `tesis`: rendered as `Tesis` in Indonesian and `Thesis` in English.

## Editing Metadata

Most student-specific metadata is configured in:

```text
config/thesis-config.tex
```

Common fields to update include:

```latex
\newcommand{\ThesisTitleID}{Indonesian Thesis Title}
\newcommand{\ThesisTitleEN}{English Thesis Title}
\newcommand{\StudentName}{Student Full Name}
\newcommand{\StudentID}{Student ID Number}
\newcommand{\ProgramNameID}{Informatika}
\newcommand{\ProgramNameEN}{Informatics}
\newcommand{\AdvisorOne}{Advisor I Name, Degree}
\newcommand{\AdvisorTwo}{Advisor II Name, Degree}
\newcommand{\DefenseDateID}{Tanggal Bulan Tahun}
\newcommand{\DefenseDateEN}{Month Day, Year}
\newcommand{\SubmissionYear}{2026}
```

Dean and head-of-program metadata is also provided in the config file, but it should be verified against the latest official faculty or program guide before submission.

## Writing Bilingual Content

The template provides:

```latex
\Lang{Indonesian text}{English text}
```

Example:

```latex
\section{\Lang{Latar Belakang}{Background}}
```

If `\ThesisLanguage` is `indonesian`, the Indonesian text is rendered. If it is `english`, the English text is rendered.

## Compiling

From the project root, run:

```bash
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

If the document does not use BibTeX citations yet, the `bibtex main` step can be skipped. For the final document, use the full sequence so references and lists are updated correctly.

## Figures, Equations, and Code Blocks

The template includes a figure example in:

```text
chapters/ch02-literature-review.tex
```

It uses:

```latex
\includegraphics[width=0.85\linewidth]{example-figure.pdf}
```

Mathematical equations use the `equation` environment and are numbered with Arabic chapter numbers, such as `(2.1)`, even when the chapter title is displayed as `BAB II`.

Code or algorithm examples use `algorithm2e`. Their captions are listed under `DAFTAR KODE` or `LIST OF CODE`, with numbering such as `Kode Program 3. 1`.

## Before Final Submission

- Replace all placeholder metadata.
- Verify dean and head-of-program names.
- Remove all `\TemplateTip{...}` and `\TemplateTodo{...}` blocks.
- Ensure all figures, tables, equations, citations, and code blocks are referenced correctly.
- Compile multiple times until the table of contents, lists, and bibliography are stable.

## Disclaimer

This repository is a technical writing aid. Official formatting rules may change. Always compare the generated document with the latest requirements from the study program, faculty, and advisor.
