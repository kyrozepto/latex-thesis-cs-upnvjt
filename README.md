# Template LaTeX Skripsi Fasilkom UPN "Veteran" Jawa Timur

Template LaTeX untuk skripsi Fakultas Ilmu Komputer, Universitas Pembangunan Nasional "Veteran"
Jawa Timur. Satu repositori dipakai dari proposal sampai naskah akhir: isi bab ditulis sekali, lalu
dibangun menjadi naskah yang berbeda dengan satu perintah.

```
build proposal    -> proposal.pdf        Bab I-III, untuk seminar proposal
build draft       -> skripsi-draft.pdf   Bab I-IV, untuk bimbingan
build semhas      -> semhas.pdf          Bab I-V, untuk seminar hasil
build skripsi     -> main.pdf            Bab I-V, naskah akhir (layar)
build cetak       -> main-cetak.pdf      Bab I-V, naskah akhir cetak bolak-balik
build en          -> main-en.pdf         naskah akhir edisi bahasa Inggris
build en-cetak    -> main-en-cetak.pdf   edisi bahasa Inggris, cetak bolak-balik
```

Halaman depan naskah akhir (lembar pengesahan, lembar persetujuan, pernyataan orisinalitas, abstrak)
mengikuti buku skripsi contoh fakultas tahun 2026.

Tidak ada isi yang perlu disalin antar naskah. Ketika proposal naik menjadi skripsi, Anda cukup
menjalankan perintah build yang berbeda.

## Daftar isi

- [Fitur utama](#fitur-utama)
- [Persiapan: MiKTeX di Windows](#persiapan-miktex-di-windows)
- [Persiapan: TeX Live di Linux atau macOS](#persiapan-tex-live-di-linux-atau-macos)
- [Build pertama](#build-pertama)
- [Perintah build](#perintah-build)
- [Memilih naskah yang tepat](#memilih-naskah-yang-tepat)
- [Struktur project](#struktur-project)
- [Konfigurasi](#konfigurasi)
- [Menulis naskah](#menulis-naskah)
- [Edisi cetak](#edisi-cetak)
- [Gambar TikZ](#gambar-tikz)
- [Kalau build gagal](#kalau-build-gagal)
- [Checklist sebelum mengumpulkan](#checklist-sebelum-mengumpulkan)
- [Disclaimer](#disclaimer)

## Fitur utama

- **Banyak naskah, satu sumber.** `proposal.tex`, `skripsi-draft.tex`, `semhas.tex`, dan `main.tex`
  memakai berkas bab yang sama dan hanya berbeda pada jumlah bab serta halaman depan yang
  disertakan. Edisi cetak dan edisi bahasa Inggris memuat `main.tex` apa adanya.
- **Edisi cetak bolak-balik.** `\documentclass[print]{template}` membuat setiap bab mulai di
  halaman kanan, margin 4 cm selalu di sisi jilid, dan halaman pengisi diberi keterangan
  "Halaman ini sengaja dikosongkan". `tools/siapkan_cetak.py` memecah PDF-nya untuk percetakan.
- **Build satu perintah.** `build.bat` (Windows) dan `build.sh` (Linux, macOS, WSL) menjalankan
  urutan `pdflatex -> bibtex -> pdflatex -> pdflatex` yang benar, lengkap dengan target `clean`.
- **Dua bahasa.** Ganti satu variabel untuk memindahkan seluruh label dokumen antara Bahasa
  Indonesia dan English. Isi naskah dipisah per bahasa sehingga Anda menulis tanpa `\Lang{...}{...}`.
- **Format Fasilkom UPN 2026.** Sampul luar oranye dan sampul dalam putih dengan garis kuning dan
  logo, lembar pengesahan dan lembar persetujuan berwatermark, pernyataan orisinalitas dengan QR
  code, margin kiri 4 cm, spasi isi 1,33, penomoran `Gambar 3. 1`, dan `BAB III` beraksara Romawi.
- **Daftar lengkap.** Daftar Isi, Daftar Gambar, Daftar Tabel, Daftar Algoritma, Daftar Lampiran,
  Daftar Istilah, dan Daftar Simbol, masing-masing muncul hanya pada naskah yang membutuhkannya.
- **Daftar pustaka gaya IEEE dengan DOI.** `IEEEtran-doi.bst` mencetak `doi: ...` bila tersedia,
  dan `Accessed: ... [Online]. Available: ...` untuk sumber daring.
- **Daftar Lampiran terpisah.** Rincian lampiran tercatat di halaman `DAFTAR LAMPIRAN`, bukan
  memenuhi `DAFTAR ISI`.
- **Penanda draf.** `\TemplateTodo`, `\TemplateTip`, `\Placeholder`, dan `\FigurePlaceholder`
  membantu selama menulis, lalu hilang sendiri pada naskah yang Anda serahkan.
- **Pipeline gambar TikZ.** Folder `tikz/` merender gambar vektor menjadi PDF terlebih dahulu,
  sehingga kompilasi naskah tetap cepat.

## Persiapan: MiKTeX di Windows

Cukup sekali, sekitar 15 menit termasuk unduhan.

1. **Unduh dan pasang MiKTeX** dari <https://miktex.org/download>. Pilih installer 64-bit.
   Saat ditanya, pasang **"for me only"** (pengguna saat ini); pemasangan sistem membutuhkan hak
   administrator setiap kali ada paket baru yang perlu diunduh.

2. **Perbarui basis paket.** Buka **MiKTeX Console** dari Start Menu, lalu:

   - tab **Updates** → **Check for updates** → **Update now**,
   - tunggu sampai selesai, lalu jalankan sekali lagi sampai tidak ada pembaruan tersisa.

   Langkah ini wajib. Tanpa pemeriksaan pembaruan, `pdflatex` mencetak peringatan
   `major issue: So far, no MiKTeX administrator has checked for updates` pada setiap build.

3. **Aktifkan pemasangan paket otomatis.** Di MiKTeX Console:

   **Settings** → tab **General** → **You can choose whether missing packages are to be installed
   automatically** → pilih **Always**.

   Ini penting. `build.bat` menjalankan `pdflatex` dengan `-interaction=nonstopmode`, sehingga tidak
   ada seorang pun yang bisa menjawab dialog "install package?" — build akan menggantung atau gagal.
   Dengan setelan **Always**, paket yang belum ada diunduh sendiri.

4. **Pastikan perintahnya bisa dipanggil.** Buka Command Prompt atau PowerShell baru, lalu:

   ```
   pdflatex --version
   bibtex --version
   ```

   Keduanya harus mencetak nomor versi. Kalau muncul "is not recognized", tutup dan buka ulang
   terminalnya; kalau masih gagal, pasang ulang MiKTeX dan pastikan opsi penambahan PATH aktif.

MiKTeX **tidak** memerlukan Perl: template ini sengaja tidak memakai `latexmk`, dan `build.bat`
menjalankan setiap langkah secara langsung.

## Persiapan: TeX Live di Linux atau macOS

Pasang distribusi lengkapnya, lalu Anda tidak perlu memikirkan paket satu per satu:

```bash
# Debian, Ubuntu
sudo apt install texlive-full

# Fedora
sudo dnf install texlive-scheme-full

# macOS
brew install --cask mactex
```

Kalau ruang disk terbatas dan Anda memasang `texlive-base` saja, paket berikut yang dibutuhkan
template ini:

```bash
tlmgr install geometry setspace microtype ragged2e indentfirst titlesec tocloft \
  fancyhdr caption enumitem array booktabs tabularx xltabular multirow makecell \
  xcolor background iftex newtx helvetic graphics float amsmath listings \
  algorithm2e hyperref cite pgf pgfplots standalone tools qrcode needspace \
  emptypage url
```

Template dibangun dan diuji dengan pdfTeX. XeLaTeX dan LuaLaTeX juga didukung `template.cls`
(keduanya memakai font Times New Roman asli bila tersedia), tetapi `build.bat`/`build.sh` memanggil
`pdflatex`.

## Build pertama

```bash
git clone https://github.com/<akun>/latex-thesis-cs-upnvjt.git
cd latex-thesis-cs-upnvjt

build proposal        # Windows
./build.sh proposal   # Linux, macOS, WSL
```

Hasilnya adalah `proposal.pdf`.

**Build pertama lebih lambat.** Pada MiKTeX, sebagian paket baru diunduh saat itu juga, sehingga
langkah `[1/4] pdflatex` bisa berjalan beberapa menit. Build berikutnya hanya butuh beberapa detik.

Empat langkah itu semuanya diperlukan:

| Langkah | Gunanya |
|---|---|
| `pdflatex` #1 | mencatat seluruh `\label` dan `\cite` ke berkas `.aux` |
| `bibtex` | mengubah daftar sitasi menjadi `.bbl` |
| `pdflatex` #2 | mencetak daftar pustaka dan mengisi nomor rujukan |
| `pdflatex` #3 | membetulkan nomor halaman yang bergeser akibat halaman daftar pustaka |

Kalau Anda menjalankan `pdflatex` sekali saja, rujukan silang muncul sebagai `??`.

## Perintah build

```
build                 # sama dengan "build proposal"
build proposal        # proposal.tex       -> proposal.pdf
build draft           # skripsi-draft.tex  -> skripsi-draft.pdf
build semhas          # semhas.tex         -> semhas.pdf
build skripsi         # main.tex           -> main.pdf
build main            # alias "build skripsi"
build cetak           # main-cetak.tex     -> main-cetak.pdf     (alias: print)
build en              # main-en.tex        -> main-en.pdf        (alias: english)
build en-cetak        # main-en-cetak.tex  -> main-en-cetak.pdf  (alias: en-print)
build all             # seluruh target, berhenti pada kegagalan pertama
build clean           # hapus berkas bantu, PDF dipertahankan
```

Berkas `main-cetak.tex`, `main-en.tex`, `main-en-cetak.tex`, dan `semhas.tex` masing-masing hanya
menetapkan satu atau dua nilai lalu memuat `main.tex`, sehingga semua edisi selalu berisi naskah
yang sama.

Pada Linux, macOS, dan WSL, ganti `build` dengan `./build.sh` — target dan perilakunya sama persis.

`build clean` menghapus `.aux`, `.bbl`, `.blg`, `.lof`, `.log`, `.lot`, `.loa`, `.lap`, `.out`,
`.toc`, `.fls`, dan `.fdb_latexmk`. Jalankan ini setiap kali Anda mengganti `\ThesisLanguage`: daftar
isi lama tersimpan di `.toc` dan akan tercetak dalam bahasa yang salah pada build berikutnya.

## Memilih naskah yang tepat

| | `proposal` | `draft` | `semhas` | `skripsi` |
|---|---|---|---|---|
| Bab | I–III | I–IV | I–V | I–V |
| Sampul | PRA-SKRIPSI | SKRIPSI (DRAF BAB I--IV) | SKRIPSI | SKRIPSI |
| Sampul luar oranye | – | – | – | ✓ |
| Lembar pengesahan, persetujuan, pernyataan orisinalitas | – | – | – | ✓ |
| Abstrak | – | – | ✓ | ✓ |
| Kata pengantar | – | – | – | ✓ |
| Daftar Isi, Gambar, Tabel | ✓ | ✓ | ✓ | ✓ |
| Daftar Algoritma, Daftar Lampiran | – | ✓ | ✓ | ✓ |
| Daftar Istilah, Daftar Simbol | ✓ | ✓ | ✓ | ✓ |
| Lampiran | – | ✓ | ✓ | ✓ |
| Kotak `\TemplateTodo` dan `\Placeholder` | – | – | – | ✓ |
| Paket `algorithm2e` | – | ✓ | ✓ | ✓ |

Alasan pembagiannya:

- **Proposal** belum diuji dan belum punya hasil, sehingga tidak memuat halaman tanda tangan,
  abstrak, Bab IV, maupun lampiran. Daftar Algoritma juga dilewati karena penyajian algoritma
  ditempatkan pada Bab IV — dan karena itu `algorithm2e` tidak dimuat sama sekali.
- **Draf** adalah naskah yang dibawa ke bimbingan setelah hasil mulai ada. Kotak bantuan
  disembunyikan supaya pembimbing membaca naskah, bukan catatan Anda.
- **Semhas** adalah berkas seminar hasil: isi lengkap dan abstrak, tetapi tanpa halaman yang baru
  ditandatangani setelah ujian.
- **Skripsi** adalah naskah akhir yang lengkap. Edisi cetak (`cetak`, `en-cetak`) isinya sama.

Tidak ada DAFTAR SINGKATAN tersendiri: singkatan beserta kepanjangannya ditulis di DAFTAR ISTILAH,
mengikuti buku skripsi contoh.

## Struktur project

```text
.
├── build.bat / build.sh          # skrip build
├── main.tex                      # naskah skripsi penuh, Bab I-V
├── main-cetak.tex                # main.tex, edisi cetak bolak-balik
├── main-en.tex                   # main.tex, edisi bahasa Inggris
├── main-en-cetak.tex             # main.tex, Inggris, cetak bolak-balik
├── semhas.tex                    # naskah seminar hasil, Bab I-V
├── proposal.tex                  # naskah proposal, Bab I-III
├── skripsi-draft.tex             # naskah draf, Bab I-IV
├── template.cls                  # format halaman, tipografi, penomoran, opsi print
├── IEEEtran-doi.bst              # gaya daftar pustaka IEEE dengan DOI
├── logo_upn.png
├── config/
│   ├── thesis-config.tex         # metadata, bahasa, tipe dokumen   <- yang Anda ubah
│   ├── thesis-language.tex       # kamus label Indonesia/English
│   └── thesis-preamble.tex       # paket dan makro bersama seluruh naskah
├── content/
│   ├── cover.tex                 # sampul luar oranye dan sampul dalam
│   ├── frontmatter-pages.tex     # lembar tanda tangan, abstrak, kata pengantar
│   ├── frontmatter-lists.tex     # daftar isi dan daftar lainnya
│   ├── backmatter.tex            # daftar pustaka dan lampiran
│   ├── indonesian/{abstract,preface,glossary,symbols}.tex
│   └── english/{abstract,preface,glossary,symbols}.tex
├── chapters/
│   ├── indonesian/ch01..ch05.tex
│   └── english/ch01..ch05.tex
├── appendices/
│   ├── indonesian/appA.tex
│   └── english/appA.tex
├── figures/                      # gambar yang disisipkan naskah
│   └── english/                  # versi Inggris gambar berlabel (opsional)
├── references/
│   └── example.bib
├── tikz/                         # sumber gambar vektor, lihat tikz/README.md
└── tools/
    ├── siapkan_cetak.py          # pecah PDF cetak untuk percetakan
    └── plot_style.py             # gaya matplotlib yang menyatu dengan naskah
```

Berkas di `content/` yang tidak berada di dalam folder bahasa (`cover.tex`, `frontmatter-*.tex`,
`backmatter.tex`) adalah kerangka yang dipakai bersama seluruh naskah. Anda jarang perlu
menyentuhnya; yang berubah dari hari ke hari ada di `config/thesis-config.tex` dan `chapters/`.

## Konfigurasi

Semua yang perlu Anda ubah ada di **`config/thesis-config.tex`**.

### Bahasa

```latex
\providecommand{\ThesisLanguage}{indonesian}   % indonesian | english
```

Nilai ini menentukan folder yang dibaca (`content/<bahasa>/`, `chapters/<bahasa>/`,
`appendices/<bahasa>/`) sekaligus seluruh label. Untuk membangun kedua edisi tanpa mengubah
berkas ini, pakai `build en` dan `build en-cetak`: keduanya menetapkan bahasa Inggris lebih dahulu.
Gambar berlabel Inggris diletakkan di `figures/english/` dengan nama berkas yang sama; gambar yang
tidak ada di sana diambil dari `figures/`.

| Indonesian | English |
|---|---|
| `BAB I` | `CHAPTER I` |
| `DAFTAR ISI` | `TABLE OF CONTENTS` |
| `DAFTAR GAMBAR` | `LIST OF FIGURES` |
| `DAFTAR TABEL` | `LIST OF TABLES` |
| `DAFTAR ALGORITMA` | `LIST OF ALGORITHMS` |
| `DAFTAR LAMPIRAN` | `LIST OF APPENDICES` |
| `DAFTAR ISTILAH` | `GLOSSARY` |
| `DAFTAR SIMBOL` | `LIST OF SYMBOLS` |
| `DAFTAR PUSTAKA` | `BIBLIOGRAPHY` |
| `LAMPIRAN` | `APPENDIX` |
| `LEMBAR PENGESAHAN` | `APPROVAL SHEET` |
| `LEMBAR PERSETUJUAN` | `APPROVAL SHEET` |
| `PERNYATAAN ORISINALITAS` | `STATEMENT OF ORIGINALITY` |
| `Gambar 3. 1` | `Figure 3. 1` |
| `Algoritma 4. 1` | `Algorithm 4. 1` |

Teks Inggris ketiga halaman tanda tangan disalin dari edisi Inggris buku skripsi contoh, termasuk
judul `APPROVAL SHEET` yang sama untuk dua halaman dan ejaan "Acknowledge by".

Jalankan `build clean` setelah mengganti bahasa.

### Tipe dokumen

```latex
\newcommand{\ThesisDocumentType}{skripsi}   % skripsi | tesis
```

`skripsi` → *Undergraduate Thesis*, `tesis` → *Thesis*.

### Kotak bantuan penulisan

```latex
\newcommand{\ThesisShowHelpers}{auto}   % auto | on | off
```

- `auto` — tampil pada `main.tex` beserta edisi cetak dan Inggrisnya, tersembunyi pada
  `proposal.tex`, `skripsi-draft.tex`, dan `semhas.tex`.
- `on` — selalu tampil.
- `off` — selalu tersembunyi. Pakai ini untuk naskah akhir yang dikumpulkan.

### Sampul luar oranye

```latex
\providecommand{\ThesisColorCover}{auto}   % auto | on | off
```

- `auto` — hanya pada naskah akhir (`main.tex` dan edisi cetak/Inggrisnya).
- `on` — pada semua naskah.
- `off` — tidak pernah; hanya sampul dalam putih.

Sampul luar dicetak satu sisi, sehingga edisi cetak pun tidak memberi halaman kosong di baliknya.

### Metadata

Sisanya adalah isian biasa: judul (Indonesia dan English), nama dan NPM mahasiswa, nama program
studi, dua pembimbing, Ketua Penguji dan Penguji I, dekan, koordinator program studi, tanggal
sidang, tahun, dan kata kunci. Setiap isian dipakai ulang di sampul, lembar tanda tangan, dan
abstrak, jadi cukup ubah di satu tempat. Dua isian baru pada naskah akhir:

- `\SignDateID` / `\SignDateEN` — tanggal penandatanganan pernyataan orisinalitas dan kata
  pengantar, biasanya beberapa hari setelah sidang, setelah revisi selesai.
- `\OriginalityQRLink` — tautan yang dikodekan sebagai QR code di samping tanda tangan pernyataan
  orisinalitas, misalnya folder berkas pendukung yang diminta program studi. Kosongkan isinya
  (`\newcommand{\OriginalityQRLink}{}`) untuk menghilangkan QR code.

Verifikasi nama dan NIP/NPT dekan serta koordinator program studi dengan pedoman terbaru sebelum
mencetak. Tanyakan juga ke program studi apakah pernyataan orisinalitas memerlukan meterai.

### Spasi baris

Halaman depan dan seluruh daftar memakai spasi 1,5. Mulai Bab I sampai lampiran, serta teks abstrak
dan kata pengantar, memakai `\ThesisBodySpacing` (spasi 1,33, sekitar 19,3 pt), mengikuti kerapatan
baris buku skripsi contoh. Nilainya diatur di `template.cls`.

## Menulis naskah

### Bab

Tulis di `chapters/<bahasa>/`. Berkas bab dimulai dengan `\chapter{...}`; penomoran `BAB` dan
`3.2.1.` diatur `template.cls`, Anda tidak perlu menuliskannya. Judul bab otomatis dicetak kapital.

Kerangka bab mengikuti susunan skripsi yang sudah lulus. Setiap bab dibuka dengan satu paragraf
pengantar sebelum subbab pertama.

| Bab | Subbab |
|---|---|
| I Pendahuluan | Latar Belakang, Rumusan Masalah, Tujuan Penelitian, Manfaat Penelitian, Batasan Penelitian |
| II Tinjauan Pustaka | Penelitian Terdahulu, lalu satu subbab per konsep teori (tanpa subbab payung "Landasan Teori") |
| III Metodologi Penelitian | Tahapan Penelitian, Studi Literatur, Analisis Kebutuhan, Pengumpulan Data, subbab perancangan sesuai metode, Pengujian, Evaluasi |
| IV Hasil dan Pembahasan | Lingkungan dan Pelaksanaan Penelitian, subbab hasil yang berpasangan dengan subbab Bab III, Pembahasan (Jawaban atas Rumusan Masalah, Perbandingan dengan Penelitian Terdahulu, Faktor Pembatas Validitas Penelitian) |
| V Kesimpulan dan Saran | Kesimpulan, Saran |

### Gambar

Letakkan berkasnya di `figures/`, lalu:

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\linewidth]{nama-gambar.pdf}
  \caption{Keterangan gambar.}
  \label{fig:nama-gambar}
\end{figure}
```

`\graphicspath{{figures/}}` sudah diatur, jadi cukup nama berkasnya. `[H]` menahan gambar tepat di
posisi itu. Rujuk dengan `Gambar~\ref{fig:nama-gambar}` — jangan menulis nomornya sendiri.

Gambar yang belum tersedia dapat diisi sementara dengan `\FigurePlaceholder{4cm}{keterangan}`:
nomor, caption, dan `\label`-nya tetap hidup, sehingga rujukan di paragraf lain tidak bergeser
ketika gambar aslinya dipasang. Contohnya ada di Bab III.

Gambar dengan beberapa panel (a)/(b) cukup memakai satu environment `figure` dan satu caption.
Ada dua contoh: panel yang dilabeli di atas satu gambar dengan TikZ (Bab II), dan panel dari
beberapa berkas gambar yang masing-masing diletakkan di `minipage[t]` (Bab IV). Paket `subcaption`
tidak diperlukan.

Judul gambar atau tabel yang panjang diberi versi pendek untuk daftarnya:
`\caption[Judul pendek]{Judul lengkap yang tercetak di bawah gambar.}`.

Tangkapan layar dan pindaian dokumen yang berlatar putih diberi bingkai tipis dengan
`\BorderedGraphics[width=\linewidth]{berkas.png}`, pengganti `\includegraphics`.

Grafik dari Python dapat memakai `tools/plot_style.py`, yang menyamakan font, ukuran huruf, dan
lebar gambar dengan naskah.

### Tabel

Seluruh tabel memakai gaya yang sama: bergaris penuh, judul di atas, dan boleh terpotong
antarhalaman. Empat contoh siap pakai ada di dalam naskah — Tabel 2.1, 3.1, 4.1, dan 4.2 — masing-
masing untuk satu bentuk yang berbeda.

Aturan yang berlaku untuk semuanya:

- **Jangan bungkus dengan `\begin{table}` dan jangan pakai `[H]`.** `xltabular` dan `longtable`
  menempatkan dirinya sendiri. Membungkusnya dengan environment `table` justru mengunci tabel pada
  satu halaman dan membuatnya meluber.
- **`\caption` dan `\label` ditulis di baris pertama di dalam tabel**, diakhiri `\\`.
- **Baris judul diulang** melalui `\endfirsthead` dan `\endhead`, sehingga pembaca tetap tahu arti
  tiap kolom pada halaman lanjutan.
- **`\endlastfoot` sudah memberi `\hline` penutup**, jadi baris data terakhir tidak perlu diberi
  `\hline` lagi.
- **Sebut tabel di dalam kalimat sebelum tabelnya muncul**, misalnya `Tabel \ref{tab:nama}`.
- **Bahas isinya, jangan mengulangnya.** Paragraf setelah tabel menjelaskan arti angkanya.

#### Bentuk 1 — sebagian kolom tetap, satu kolom lentur (paling sering dipakai)

```latex
\begin{xltabular}{\linewidth}{|P{0.20\linewidth}|P{0.30\linewidth}|Y|}
\caption{Judul tabel.}\label{tab:nama}\\
\hline
Kolom 1 & Kolom 2 & Kolom 3 \\
\hline
\endfirsthead
\hline
Kolom 1 & Kolom 2 & Kolom 3 \\
\hline
\endhead
\hline
\endlastfoot
isi & isi & isi \\
\hline
isi & isi & isi \\
\end{xltabular}
```

Kolom `P{...}` lebarnya dikunci, kolom `Y` menyerap sisa lebar halaman. Letakkan kolom yang isinya
paling panjang di posisi `Y`. Jumlah lebar seluruh kolom `P` sebaiknya di bawah `1.0\linewidth`
agar kolom `Y` masih kebagian ruang.

#### Bentuk 2 — seluruh kolom lentur, memakai bobot

```latex
\begin{xltabular}{\linewidth}{|L{0.70}|L{1.05}|L{1.20}|L{1.15}|L{0.90}|}
```

Jumlah seluruh bobot harus sama dengan cacah kolomnya: lima kolom di atas berjumlah
0,70 + 1,05 + 1,20 + 1,15 + 0,90 = 5,00. Kolom yang isinya paling panjang diberi bobot terbesar.
Cocok untuk tabel ringkasan penelitian terdahulu, yang seluruh kolomnya berisi kalimat.

#### Bentuk 3 — tabel angka

```latex
\begin{longtable}{|l|c|c|c|}
...
\multicolumn{4}{|l|}{\textbf{Judul kelompok}} \\
\hline
Skenario A & 0,00 & 0,00 & 0,00 \\
```

Kalau seluruh kolom berisi angka pendek, `tabularx` tidak diperlukan: `longtable` dengan kolom `l`
dan `c` biasa menyesuaikan lebarnya sendiri. Kolom `c` membuat angka rata tengah sehingga mudah
dibandingkan antarbaris. `\multicolumn{n}{|l|}{\textbf{...}}` membuat baris judul kelompok yang
membentang penuh, dipakai untuk memisahkan blok tanpa memecah tabel.

Angka desimal ditulis dengan koma pada naskah Bahasa Indonesia. Di dalam mode matematika, tulis
`$0{,}00$` agar tidak muncul spasi setelah komanya.

#### Bentuk 4 — tabel lebar

```latex
\begingroup\footnotesize\setlength{\tabcolsep}{4pt}
\begin{xltabular}{\linewidth}{|P{0.06\linewidth}|...|Y|}
...
\end{xltabular}\endgroup
```

Tabel dengan banyak kolom akan meluber melewati margin. Bungkus dengan `\begingroup` ... `\endgroup`
lalu perkecil ukuran huruf dan `\tabcolsep` di dalamnya; karena dibungkus grup, kedua pengaturan itu
tidak bocor ke tabel berikutnya. Gunakan `\cline{4-6}` bila beberapa baris berbagi isi kolom awal
sehingga kolom tersebut dibiarkan menyatu.

#### Jenis kolom tambahan

| Kolom | Artinya |
|---|---|
| `P{0.2\linewidth}` | seperti `p{...}`, tetapi rata kiri |
| `Y` | seperti `X`, tetapi rata kiri |
| `L{1.5}` | kolom `X` berbobot |

Ketiganya rata kiri, bukan rata kanan-kiri, supaya kolom sempit tidak diregangkan sampai berlubang.

### Persamaan

```latex
\begin{equation}
  E = mc^2
  \label{eq:einstein}
\end{equation}
```

Penomorannya otomatis menjadi `(2.1)`. `\allowdisplaybreaks[4]` sudah aktif, sehingga turunan
panjang boleh terpotong antarhalaman daripada meninggalkan halaman setengah kosong.

### Algoritma

Pseudocode ditempatkan di Bab IV bersama hasil, bukan di Bab III.

```latex
\begin{algorithm}[H]
\caption{Judul algoritma}\label{alg:nama}
\KwInput{Masukan}
\KwOutput{Keluaran}
Langkah pertama \tcp*{komentar di ujung baris, menggantikan \;}
\tcp{komentar satu baris penuh}
\ForEach{item}{
  Langkah di dalam perulangan\;
}
\KwReturn{Hasil}
\end{algorithm}
```

`\KwInput`, `\KwOutput`, dan `\KwReturn` mengikuti `\ThesisLanguage`
(Masukan/Keluaran/Kembalikan atau Input/Output/Return). Perintah bawaan `algorithm2e`
(`\KwIn`, `\KwOut`, `\Return`) tetap bisa dipakai, tetapi selalu berbahasa Inggris. Pada edisi
Inggris titik koma di akhir baris tidak dicetak.

Algoritma dibingkai penuh (`boxruled`) dan diberi jarak atas-bawah yang sama dengan gambar dan
tabel. Nomornya menjadi `Algoritma 4. 1` dan otomatis masuk `DAFTAR ALGORITMA`.

### Rujukan silang

Rujuk gambar, tabel, persamaan, dan algoritma dengan nomornya: `Gambar~\ref{fig:nama}`. Rujuk subbab
dengan judulnya: `Subbab \nameref{sec:nama}`. `\nameref` mencetak judul subbab yang diberi
`\label`, sehingga rujukan tetap benar ketika nomor subbab bergeser. Lampiran dirujuk dengan
nomornya, `Lampiran 1`, dan tabel atau gambar di dalamnya dengan `\ref` (`Tabel~\ref{tab:nama}` di
Lampiran 1). Contohnya ada di subbab Pembahasan Bab IV.

### Sitasi

Tambahkan entri ke `references/example.bib`, lalu `\cite{kunci}`. Beberapa sitasi dalam satu kalimat
dicetak `[4],[5]` — berurutan menaik, tanpa diringkas menjadi `[4]-[6]`.

Daftar pustaka memakai `IEEEtran-doi.bst`, salinan IEEEtran.bst yang dimodifikasi:

- entri yang punya isian `doi` dicetak dengan `doi: ...`, tanpa URL;
- entri tanpa DOI tetapi dengan `url` dan `urldate` dicetak `Accessed: ... [Online]. Available: ...`;
- lebih dari enam penulis diringkas menjadi "et al.";
- URL dan DOI dicetak dengan huruf teks, bukan huruf mesin tik.

`references/example.bib` memuat satu contoh untuk setiap bentuk. Selalu isi `doi` bila sumbernya
memilikinya.

Untuk memakai lebih dari satu berkas `.bib`, ubah baris di `content/backmatter.tex`:

```latex
\bibliography{references/example,references/berkas-lain}
```

Tulis tanpa ekstensi `.bib`.

### Lampiran

Isi lampiran ada di `appendices/<bahasa>/appA.tex`. `DAFTAR ISI` hanya menampilkan satu entri
`LAMPIRAN`; rinciannya masuk ke `DAFTAR LAMPIRAN` melalui:

```latex
\AppendixSection{Lampiran 1. Judul Lampiran}
\AppendixSubsection{Judul Subbagian}
\AppendixSection{Lampiran 2. Judul Lampiran Berikutnya}
```

Lampiran diberi nomor angka (`Lampiran 1`, `Lampiran 2`, ...), bukan huruf, dan subbagiannya tidak
bernomor. Tabel dan gambar di dalam lampiran bernomor tersendiri, `Tabel L.1` dan `Gambar L.1`
(`Table A.1` dan `Figure A.1` pada edisi Inggris), sehingga tidak melanjutkan nomor Bab IV.
Pengaturannya ada di awal `appA.tex`.

**Jangan** memakai `\section` atau `\subsection` biasa di dalam lampiran: judulnya akan membanjiri
`DAFTAR ISI` dan tidak akan tercatat di `DAFTAR LAMPIRAN`. Setiap `\AppendixSection` setelah yang
pertama otomatis mulai di halaman baru. `\label` tepat setelah kedua perintah itu dapat dirujuk dari
bab dengan `\nameref`. Dokumen pindaian (surat etik, lembar validasi data) disisipkan dengan
`\BorderedGraphics`.

### Daftar istilah dan daftar simbol

`content/<bahasa>/glossary.tex` (DAFTAR ISTILAH) memuat istilah khusus beserta singkatan dan
kepanjangannya; tidak ada DAFTAR SINGKATAN tersendiri. Istilah yang umum dikenal pembaca program
studi atau yang hanya disebut sambil lalu tidak perlu dicantumkan.

`content/<bahasa>/symbols.tex` (DAFTAR SIMBOL) memuat notasi inti yang dipakai lintas bab, berurutan
huruf Latin, huruf Yunani, lalu simbol kaligrafi. Simbol yang hanya muncul pada satu persamaan cukup
didefinisikan di bawah persamaannya. Jika naskah tidak memuat persamaan, hapus blok DAFTAR SIMBOL
di `content/frontmatter-lists.tex`.

## Edisi cetak

`build cetak` (atau `build en-cetak`) menghasilkan naskah yang sama untuk dicetak bolak-balik:

- setiap halaman depan dan setiap bab dimulai di halaman kanan (bernomor ganjil);
- margin 4 cm selalu berada di sisi jilid, bergantian kiri dan kanan;
- halaman pengisi diberi keterangan "Halaman ini sengaja dikosongkan", sama dengan edisi layar;
- sampul luar oranye tetap satu sisi.

Di naskah, pakai `\ThesisBlankPage` dan `\ThesisPageBreak` alih-alih `\halamanKosong` dan
`\clearpage` pada halaman depan; keduanya menyesuaikan diri dengan edisinya.

Untuk percetakan, `python tools/siapkan_cetak.py` (membutuhkan `pip install pypdf`) memecah
`main-cetak.pdf` menjadi sampul luar, buku utuh bolak-balik, bagian depan satu sisi tanpa halaman
pengisi, dan isi Bab I sampai lampiran bolak-balik. Tanyakan ke percetakan atau program studi bagian
mana yang dicetak satu sisi.

## Gambar TikZ

Gambar yang digambar dengan TikZ atau pgfplots dirender lebih dahulu menjadi PDF, bukan digambar
ulang setiap kali naskah dikompilasi:

```
cd tikz
build                     REM seluruh gambar
build nama-gambar         REM satu gambar saja
bash build.sh             # Linux, macOS, WSL
```

Hasilnya masuk ke `figures/` dan siap dipanggil `\includegraphics`. `tikz/preamble.tex` menyediakan
gaya diagram alur, gaya sumbu pgfplots, dan `\gridmat`/`\window` untuk menggambar matriks bernilai
(konvolusi, pooling, padding); lihat `tikz/example-grid.tex`. Rinciannya ada di
[`tikz/README.md`](tikz/README.md). Foto, tangkapan layar, dan keluaran skrip tidak perlu lewat
sini — letakkan langsung di `figures/`.

## Kalau build gagal

`build.bat` mencetak baris galat dari `.log` ketika gagal. Berikut masalah yang paling sering
muncul.

**Build menggantung, atau `LaTeX Error: File 'xltabular.sty' not found`**
Pemasangan paket otomatis MiKTeX belum aktif. Buka MiKTeX Console → **Settings** → **General** →
setel pemasangan paket ke **Always**, lalu ulangi. Pada TeX Live, jalankan perintah `tlmgr install`
di bagian persiapan.

**`major issue: So far, no MiKTeX administrator has checked for updates`**
Peringatan, bukan galat — build tetap berjalan. Hilangkan dengan menjalankan **Check for updates**
di MiKTeX Console satu kali.

**`bibtex: I found no \citation commands`**
Naskah belum memuat satu pun `\cite`. Bukan kegagalan build; daftar pustaka memang kosong.
`build.bat` hanya mencetak catatan dan meneruskan.

**`NOTE: undefined references remain`**
Ada `\ref` atau `\cite` yang menunjuk `\label`/kunci yang tidak ada, biasanya karena salah ketik.
Periksa `.log` untuk nama yang dikeluhkan.

**Rujukan silang muncul sebagai `??` atau nomor halaman salah**
Anda menjalankan `pdflatex` sendiri, bukan lewat `build`. Pakai `build`, yang menjalankan keempat
langkahnya.

**Judul daftar masih berbahasa lama setelah mengganti `\ThesisLanguage`**
Berkas `.toc`, `.lof`, dan `.lot` lama masih terpakai. Jalankan `build clean`, lalu build ulang.

**`Undefined control sequence \algorithmcfname` atau `Environment algorithm undefined`**
Anda memakai `\begin{algorithm}` di Bab I–III. Naskah proposal sengaja tidak memuat `algorithm2e`.
Pindahkan pseudocode ke Bab IV, atau bangun dengan `build draft` / `build skripsi`.

**`File 'logo_upn.png' not found`**
Kompilasi dijalankan dari folder lain. `build.bat` dan `build.sh` selalu berpindah ke folder
repositori lebih dahulu; jalankan lewat keduanya, bukan memanggil `pdflatex` dari dalam
subdirektori.

## Checklist sebelum mengumpulkan

- [ ] Seluruh metadata di `config/thesis-config.tex` sudah diisi, termasuk tanggal sidang, tanggal
      tanda tangan, dan tautan QR code.
- [ ] Nama dan NIP/NPT pembimbing, penguji, dekan, serta koordinator program studi sudah
      diverifikasi dengan pedoman terbaru.
- [ ] Format halaman tanda tangan dan kebutuhan meterai sudah dicocokkan dengan program studi.
- [ ] QR code pada pernyataan orisinalitas sudah dipindai dan mengarah ke tautan yang benar.
- [ ] `\ThesisShowHelpers` disetel `off`.
- [ ] Tidak ada lagi pemanggilan `\TemplateTodo`, `\TemplateTip`, `\Placeholder`, atau
      `\FigurePlaceholder` yang tersisa di naskah.
- [ ] Contoh bawaan template (tabel penelitian terdahulu, gambar contoh, algoritma contoh, entri
      daftar istilah, daftar simbol, entri `example.bib`) sudah diganti isi sendiri.
- [ ] `build clean` lalu `build skripsi` dan `build cetak` berjalan tanpa catatan
      `undefined references`.
- [ ] Daftar Isi, Daftar Gambar, Daftar Tabel, Daftar Algoritma, dan Daftar Lampiran sudah sesuai
      isi naskah.
- [ ] Berkas `.bib` tidak memuat entri ganda dengan kunci berbeda.

Jika repositori akan dipublikasikan:

- [ ] Tidak ada data pribadi, tanda tangan pindaian, atau dokumen administrasi sensitif.
- [ ] Berkas bantu LaTeX tidak ikut ter-commit (sudah diatur `.gitignore`).

## Disclaimer

Template ini adalah bantuan teknis. Format resmi dapat berubah sewaktu-waktu. Selalu cocokkan hasil
akhir dengan pedoman terbaru dari program studi, fakultas, dan dosen pembimbing.

---

# LaTeX Thesis Template for Fasilkom UPN "Veteran" Jawa Timur

A LaTeX template for undergraduate theses at the Faculty of Computer Science, Universitas
Pembangunan Nasional "Veteran" Jawa Timur. One repository carries you from proposal to final
manuscript: chapters are written once, then built into different documents with one command.

```
build proposal    -> proposal.pdf        Ch. I-III, for the proposal seminar
build draft       -> skripsi-draft.pdf   Ch. I-IV, for supervision meetings
build semhas      -> semhas.pdf          Ch. I-V, for the results seminar
build skripsi     -> main.pdf            Ch. I-V, final manuscript (screen)
build cetak       -> main-cetak.pdf      Ch. I-V, final manuscript, two-sided print
build en          -> main-en.pdf         final manuscript, English edition
build en-cetak    -> main-en-cetak.pdf   English edition, two-sided print
```

The front matter of the final manuscript (approval sheets, statement of originality, abstract)
follows the faculty's 2026 sample thesis book.

Nothing is copied between manuscripts. When the proposal becomes a thesis, you simply run a
different build command.

## Contents

- [Main features](#main-features)
- [Setup: MiKTeX on Windows](#setup-miktex-on-windows)
- [Setup: TeX Live on Linux or macOS](#setup-tex-live-on-linux-or-macos)
- [First build](#first-build)
- [Build commands](#build-commands)
- [Choosing the right manuscript](#choosing-the-right-manuscript)
- [Project structure](#project-structure)
- [Configuration](#configuration)
- [Writing](#writing)
- [Print edition](#print-edition)
- [TikZ figures](#tikz-figures)
- [When a build fails](#when-a-build-fails)
- [Pre-submission checklist](#pre-submission-checklist)
- [Disclaimer](#disclaimer-1)

## Main features

- **Several manuscripts, one source.** `proposal.tex`, `skripsi-draft.tex`, `semhas.tex`, and
  `main.tex` share the same chapter files and differ only in how many chapters and front-matter
  pages they include. The print and English editions load `main.tex` unchanged.
- **Two-sided print edition.** `\documentclass[print]{template}` starts every chapter on a
  right-hand page, keeps the 4 cm margin on the binding side, and marks filler pages "This page is
  intentionally left blank". `tools/siapkan_cetak.py` splits the PDF for the print shop.
- **One-command builds.** `build.bat` (Windows) and `build.sh` (Linux, macOS, WSL) run the correct
  `pdflatex -> bibtex -> pdflatex -> pdflatex` sequence, with a `clean` target.
- **Two languages.** Change one variable to move every document label between Indonesian and
  English. Manuscript text is split per language, so you write without `\Lang{...}{...}`.
- **Fasilkom UPN 2026 formatting.** Orange outer cover and white inner cover with the yellow rule
  and logo, watermarked approval sheets, statement of originality with a QR code, 4 cm left margin,
  1.33 body line spacing, `Figure 3. 1` numbering, and Roman chapter numbers.
- **Complete front matter.** Table of contents, list of figures, tables, algorithms, appendices,
  glossary, and symbols — each appearing only in the manuscript that needs it.
- **IEEE bibliography with DOIs.** `IEEEtran-doi.bst` prints `doi: ...` when available, and
  `Accessed: ... [Online]. Available: ...` for online sources.
- **Separate list of appendices.** Appendix detail is recorded on its own page rather than flooding
  the table of contents.
- **Draft markers.** `\TemplateTodo`, `\TemplateTip`, `\Placeholder`, and `\FigurePlaceholder` help
  while writing, then disappear from the manuscript you hand in.
- **TikZ figure pipeline.** The `tikz/` folder pre-renders vector figures to PDF so manuscript
  compilation stays fast.

## Setup: MiKTeX on Windows

One-time, about 15 minutes including downloads.

1. **Download and install MiKTeX** from <https://miktex.org/download>. Pick the 64-bit installer.
   When asked, install **"for me only"** (current user); a system-wide install needs administrator
   rights every time a new package has to be downloaded.

2. **Update the package database.** Open **MiKTeX Console** from the Start Menu, then:

   - tab **Updates** → **Check for updates** → **Update now**,
   - wait, then run it once more until nothing is left to update.

   This step is mandatory. Without it, `pdflatex` prints
   `major issue: So far, no MiKTeX administrator has checked for updates` on every build.

3. **Turn on automatic package installation.** In MiKTeX Console:

   **Settings** → tab **General** → **You can choose whether missing packages are to be installed
   automatically** → select **Always**.

   This matters. `build.bat` runs `pdflatex` with `-interaction=nonstopmode`, so nobody is there to
   answer an "install package?" dialog — the build would hang or fail. With **Always**, missing
   packages are fetched silently.

4. **Check that the commands are reachable.** Open a new Command Prompt or PowerShell and run:

   ```
   pdflatex --version
   bibtex --version
   ```

   Both must print a version number. If you get "is not recognized", close and reopen the terminal;
   if it still fails, reinstall MiKTeX with the PATH option enabled.

MiKTeX does **not** need Perl: this template deliberately avoids `latexmk`, and `build.bat` runs
each step directly.

## Setup: TeX Live on Linux or macOS

Install the full distribution and you never have to think about individual packages:

```bash
# Debian, Ubuntu
sudo apt install texlive-full

# Fedora
sudo dnf install texlive-scheme-full

# macOS
brew install --cask mactex
```

If disk space is tight and you install only `texlive-base`, these are the packages the template
needs:

```bash
tlmgr install geometry setspace microtype ragged2e indentfirst titlesec tocloft \
  fancyhdr caption enumitem array booktabs tabularx xltabular multirow makecell \
  xcolor background iftex newtx helvetic graphics float amsmath listings \
  algorithm2e hyperref cite pgf pgfplots standalone tools qrcode needspace \
  emptypage url
```

The template is built and tested with pdfTeX. `template.cls` also supports XeLaTeX and LuaLaTeX
(both use the real Times New Roman when available), but `build.bat`/`build.sh` call `pdflatex`.

## First build

```bash
git clone https://github.com/<account>/latex-thesis-cs-upnvjt.git
cd latex-thesis-cs-upnvjt

build proposal        # Windows
./build.sh proposal   # Linux, macOS, WSL
```

The result is `proposal.pdf`.

**The first build is slower.** On MiKTeX some packages are downloaded on the spot, so
`[1/4] pdflatex` can take several minutes. Later builds take seconds.

All four passes are needed:

| Pass | What it does |
|---|---|
| `pdflatex` #1 | records every `\label` and `\cite` into the `.aux` file |
| `bibtex` | turns the citation list into a `.bbl` |
| `pdflatex` #2 | typesets the bibliography and fills in reference numbers |
| `pdflatex` #3 | fixes page numbers shifted by the new bibliography pages |

Run `pdflatex` only once and cross-references come out as `??`.

## Build commands

```
build                 # same as "build proposal"
build proposal        # proposal.tex       -> proposal.pdf
build draft           # skripsi-draft.tex  -> skripsi-draft.pdf
build semhas          # semhas.tex         -> semhas.pdf
build skripsi         # main.tex           -> main.pdf
build main            # alias for "build skripsi"
build cetak           # main-cetak.tex     -> main-cetak.pdf     (alias: print)
build en              # main-en.tex        -> main-en.pdf        (alias: english)
build en-cetak        # main-en-cetak.tex  -> main-en-cetak.pdf  (alias: en-print)
build all             # every target, stopping at the first failure
build clean           # remove auxiliary files, keep the PDFs
```

`main-cetak.tex`, `main-en.tex`, `main-en-cetak.tex`, and `semhas.tex` each set one or two values
and then load `main.tex`, so every edition always carries the same manuscript.

On Linux, macOS, and WSL replace `build` with `./build.sh` — same targets, same behaviour.

`build clean` removes `.aux`, `.bbl`, `.blg`, `.lof`, `.log`, `.lot`, `.loa`, `.lap`, `.out`,
`.toc`, `.fls`, and `.fdb_latexmk`. Run it whenever you change `\ThesisLanguage`: the old table of
contents lives in `.toc` and would be typeset in the wrong language on the next build.

## Choosing the right manuscript

| | `proposal` | `draft` | `semhas` | `skripsi` |
|---|---|---|---|---|
| Chapters | I–III | I–IV | I–V | I–V |
| Cover reads | RESEARCH PROPOSAL | THESIS (DRAFT CH. I--IV) | UNDERGRADUATE THESIS | UNDERGRADUATE THESIS |
| Orange outer cover | – | – | – | ✓ |
| Approval sheets, statement of originality | – | – | – | ✓ |
| Abstract | – | – | ✓ | ✓ |
| Acknowledgements | – | – | – | ✓ |
| Contents, figures, tables | ✓ | ✓ | ✓ | ✓ |
| List of algorithms, list of appendices | – | ✓ | ✓ | ✓ |
| Glossary, list of symbols | ✓ | ✓ | ✓ | ✓ |
| Appendix | – | ✓ | ✓ | ✓ |
| `\TemplateTodo` and `\Placeholder` boxes | – | – | – | ✓ |
| `algorithm2e` package | – | ✓ | ✓ | ✓ |

Why it is split this way:

- A **proposal** has not been defended and has no results yet, so it carries no signature pages, no
  abstract, no Chapter IV, and no appendix. The list of algorithms is skipped too, because
  pseudocode belongs in Chapter IV — which is why `algorithm2e` is not loaded at all.
- A **draft** is what you bring to supervision once results start to appear. Helper boxes are hidden
  so your advisor reads the manuscript, not your notes.
- The **semhas** file is for the results seminar: full content and the abstract, but none of the
  pages that are signed after the examination.
- The **thesis** is the complete final manuscript. The print editions (`cetak`, `en-cetak`) carry
  the same content.

There is no separate list of abbreviations: abbreviations and their expansions go in the glossary,
as in the sample book.

## Project structure

```text
.
├── build.bat / build.sh          # build scripts
├── main.tex                      # full thesis, Ch. I-V
├── main-cetak.tex                # main.tex, two-sided print edition
├── main-en.tex                   # main.tex, English edition
├── main-en-cetak.tex             # main.tex, English, two-sided print
├── semhas.tex                    # results-seminar manuscript, Ch. I-V
├── proposal.tex                  # proposal, Ch. I-III
├── skripsi-draft.tex             # running draft, Ch. I-IV
├── template.cls                  # page format, typography, numbering, print option
├── IEEEtran-doi.bst              # IEEE bibliography style with DOIs
├── logo_upn.png
├── config/
│   ├── thesis-config.tex         # metadata, language, document type   <- you edit this
│   ├── thesis-language.tex       # Indonesian/English label dictionary
│   └── thesis-preamble.tex       # packages and macros shared by every driver
├── content/
│   ├── cover.tex                 # orange outer cover and white inner cover
│   ├── frontmatter-pages.tex     # signature sheets, abstract, acknowledgements
│   ├── frontmatter-lists.tex     # table of contents and the other lists
│   ├── backmatter.tex            # bibliography and appendix
│   ├── indonesian/{abstract,preface,glossary,symbols}.tex
│   └── english/{abstract,preface,glossary,symbols}.tex
├── chapters/
│   ├── indonesian/ch01..ch05.tex
│   └── english/ch01..ch05.tex
├── appendices/
│   ├── indonesian/appA.tex
│   └── english/appA.tex
├── figures/                      # images included by the manuscript
│   └── english/                  # English versions of labelled figures (optional)
├── references/
│   └── example.bib
├── tikz/                         # vector figure sources, see tikz/README.md
└── tools/
    ├── siapkan_cetak.py          # split the print PDF for the print shop
    └── plot_style.py             # matplotlib style that matches the manuscript
```

The files in `content/` that are not inside a language folder (`cover.tex`, `frontmatter-*.tex`,
`backmatter.tex`) are the skeleton shared by every manuscript. You rarely need to touch them;
day-to-day work happens in `config/thesis-config.tex` and `chapters/`.

## Configuration

Everything you need to change lives in **`config/thesis-config.tex`**.

### Language

```latex
\providecommand{\ThesisLanguage}{indonesian}   % indonesian | english
```

This selects the folders that are read (`content/<language>/`, `chapters/<language>/`,
`appendices/<language>/`) and every label. To build both editions without editing this file, use
`build en` and `build en-cetak`, which set English first. Figures with English labels go in
`figures/english/` under the same file name; anything not found there is taken from `figures/`.

| Indonesian | English |
|---|---|
| `BAB I` | `CHAPTER I` |
| `DAFTAR ISI` | `TABLE OF CONTENTS` |
| `DAFTAR GAMBAR` | `LIST OF FIGURES` |
| `DAFTAR TABEL` | `LIST OF TABLES` |
| `DAFTAR ALGORITMA` | `LIST OF ALGORITHMS` |
| `DAFTAR LAMPIRAN` | `LIST OF APPENDICES` |
| `DAFTAR ISTILAH` | `GLOSSARY` |
| `DAFTAR SIMBOL` | `LIST OF SYMBOLS` |
| `DAFTAR PUSTAKA` | `BIBLIOGRAPHY` |
| `LAMPIRAN` | `APPENDIX` |
| `LEMBAR PENGESAHAN` | `APPROVAL SHEET` |
| `LEMBAR PERSETUJUAN` | `APPROVAL SHEET` |
| `PERNYATAAN ORISINALITAS` | `STATEMENT OF ORIGINALITY` |
| `Gambar 3. 1` | `Figure 3. 1` |
| `Algoritma 4. 1` | `Algorithm 4. 1` |

The English text of the three signature pages is copied from the English edition of the sample
book, including the shared `APPROVAL SHEET` title and the spelling "Acknowledge by".

Run `build clean` after switching languages.

### Document type

```latex
\newcommand{\ThesisDocumentType}{skripsi}   % skripsi | tesis
```

`skripsi` → *Undergraduate Thesis*, `tesis` → *Thesis*.

### Writing-guide boxes

```latex
\newcommand{\ThesisShowHelpers}{auto}   % auto | on | off
```

- `auto` — shown in `main.tex` and its print/English editions, hidden in `proposal.tex`,
  `skripsi-draft.tex`, and `semhas.tex`.
- `on` — always shown.
- `off` — always hidden. Use this for the final submitted manuscript.

### Orange outer cover

```latex
\providecommand{\ThesisColorCover}{auto}   % auto | on | off
```

- `auto` — final manuscript only (`main.tex` and its print/English editions).
- `on` — every manuscript.
- `off` — never; only the white inner cover.

The outer cover is printed on one side, so even the print edition puts no blank page behind it.

### Metadata

The rest is plain data entry: title (Indonesian and English), student name and NPM, study program,
two advisors, the head examiner and examiner I, dean, study-program coordinator, defense date,
year, and keywords. Each field is reused on the cover, the signature sheets, and the abstract, so
you set it once. Two fields are new for the final manuscript:

- `\SignDateID` / `\SignDateEN` — the signing date of the statement of originality and the
  acknowledgements, usually a few days after the defense once revisions are done.
- `\OriginalityQRLink` — the link encoded as a QR code beside the signature on the statement of
  originality, for example the supporting-files folder your study program asks for. Empty it
  (`\newcommand{\OriginalityQRLink}{}`) to drop the QR code.

Verify the names and NIP/NPT of the dean and the study-program coordinator against the current
faculty guide before printing. Ask your study program whether the statement of originality needs a
meterai (duty stamp).

### Line spacing

Front matter and every list use 1.5 spacing. From Chapter I through the appendix, and in the
abstract and acknowledgements text, the template uses `\ThesisBodySpacing` (1.33, about 19.3 pt),
matching the line density of the sample book. The value is set in `template.cls`.

## Writing

### Chapters

Write in `chapters/<language>/`. Chapter files start with `\chapter{...}`; the `CHAPTER` and
`3.2.1.` numbering is handled by `template.cls`, you never type it. Chapter titles are uppercased
automatically.

The chapter skeleton follows the structure of a thesis that has passed. Every chapter opens with one
introductory paragraph before its first section.

| Chapter | Sections |
|---|---|
| I Introduction | Background, Research Questions, Research Objectives, Research Benefits, Scope and Limitations |
| II Literature Review | Related Work, then one section per theory concept (no "Theoretical Foundation" umbrella section) |
| III Research Methodology | Research Workflow, Literature Review, Requirements Analysis, Data Collection, design sections for your method, Testing, Evaluation |
| IV Results and Discussion | Research Environment and Execution, results sections paired with the Chapter III sections, Discussion (Answers to the Research Questions, Comparison with Prior Studies, Threats to Validity) |
| V Conclusions and Recommendations | Conclusions, Recommendations |

### Figures

Put the file in `figures/`, then:

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\linewidth]{figure-name.pdf}
  \caption{Figure caption.}
  \label{fig:figure-name}
\end{figure}
```

`\graphicspath{{figures/}}` is already set, so the file name alone is enough. `[H]` pins the figure
exactly where you put it. Refer to it with `Figure~\ref{fig:figure-name}` — never type the number
yourself.

A figure that does not exist yet can be held open with `\FigurePlaceholder{4cm}{description}`: the
number, caption, and `\label` stay alive, so references elsewhere do not shift when the real image
arrives. Chapter III has an example.

Multi-panel (a)/(b) figures need only one `figure` environment and one caption. There are two
examples: panels labelled on top of one image with TikZ (Chapter II), and panels built from separate
image files, each in a `minipage[t]` (Chapter IV). The `subcaption` package is not needed.

Give a long caption a short form for the list:
`\caption[Short title]{Full title printed under the figure.}`.

Frame screenshots and scanned documents on a white background with
`\BorderedGraphics[width=\linewidth]{file.png}` in place of `\includegraphics`.

Python plots can use `tools/plot_style.py`, which matches the font, font size, and figure width to
the manuscript.

### Tables

Every table uses the same style: fully ruled, caption on top, free to break across pages. Four
ready-made examples ship inside the manuscript — Tables 2.1, 3.1, 4.1, and 4.2 — one per form.

Rules that apply to all of them:

- **Do not wrap them in `\begin{table}` and do not use `[H]`.** `xltabular` and `longtable` place
  themselves. Wrapping one in a `table` environment pins it to a single page and makes it overflow.
- **`\caption` and `\label` go on the first line inside the table**, ended with `\\`.
- **Header rows repeat** through `\endfirsthead` and `\endhead`, so readers still know what each
  column means on continuation pages.
- **`\endlastfoot` already supplies the closing `\hline`**, so the last data row needs none.
- **Mention the table in a sentence before it appears**, e.g. `Table \ref{tab:name}`.
- **Discuss the content, do not repeat it.** The paragraph after the table explains what the numbers
  mean.

#### Form 1 — some fixed columns, one flexible column (the common case)

```latex
\begin{xltabular}{\linewidth}{|P{0.20\linewidth}|P{0.30\linewidth}|Y|}
\caption{Table caption.}\label{tab:name}\\
\hline
Column 1 & Column 2 & Column 3 \\
\hline
\endfirsthead
\hline
Column 1 & Column 2 & Column 3 \\
\hline
\endhead
\hline
\endlastfoot
cell & cell & cell \\
\hline
cell & cell & cell \\
\end{xltabular}
```

A `P{...}` column has its width locked; the `Y` column absorbs the remaining page width. Put the
wordiest column in the `Y` position. Keep the `P` widths summing to under `1.0\linewidth` so the `Y`
column still gets room.

#### Form 2 — every column flexible, using weights

```latex
\begin{xltabular}{\linewidth}{|L{0.70}|L{1.05}|L{1.20}|L{1.15}|L{0.90}|}
```

The weights must sum to the number of columns: the five above add up to
0.70 + 1.05 + 1.20 + 1.15 + 0.90 = 5.00. Give the wordiest column the largest weight. This suits a
related-work summary, where every column holds full sentences.

#### Form 3 — numeric tables

```latex
\begin{longtable}{|l|c|c|c|}
...
\multicolumn{4}{|l|}{\textbf{Group heading}} \\
\hline
Scenario A & 0.00 & 0.00 & 0.00 \\
```

When every column holds a short number, `tabularx` is unnecessary: a `longtable` with plain `l` and
`c` columns sizes itself. `c` centres the numbers so they stay comparable down the column.
`\multicolumn{n}{|l|}{\textbf{...}}` makes a full-width group heading row, used to separate blocks
without splitting the table.

Report the same number of decimal places within one column so the values line up.

#### Form 4 — wide tables

```latex
\begingroup\footnotesize\setlength{\tabcolsep}{4pt}
\begin{xltabular}{\linewidth}{|P{0.06\linewidth}|...|Y|}
...
\end{xltabular}\endgroup
```

A table with many columns will overflow the margins. Wrap it in `\begingroup` ... `\endgroup` and
shrink the font size and `\tabcolsep` inside; because it is grouped, neither setting leaks into the
next table. Use `\cline{4-6}` when consecutive rows share the leading columns and those cells are
left merged.

#### Extra column types

| Column | Meaning |
|---|---|
| `P{0.2\linewidth}` | like `p{...}`, but ragged right |
| `Y` | like `X`, but ragged right |
| `L{1.5}` | weighted `X` column |

All three are ragged right rather than justified, so narrow columns are not stretched into gappy
lines.

### Equations

```latex
\begin{equation}
  E = mc^2
  \label{eq:einstein}
\end{equation}
```

Numbering is automatic, `(2.1)`. `\allowdisplaybreaks[4]` is already on, so a long derivation may
break across pages instead of leaving a half-empty one.

### Algorithms

Pseudocode belongs in Chapter IV alongside the results, not in Chapter III.

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

`\KwInput`, `\KwOutput`, and `\KwReturn` follow `\ThesisLanguage`
(Masukan/Keluaran/Kembalikan or Input/Output/Return). The stock `algorithm2e` commands
(`\KwIn`, `\KwOut`, `\Return`) still work but are always English. The English edition drops the
end-of-line semicolons.

Algorithms are fully framed (`boxruled`) and get the same space above and below as figures and
tables. The number reads `Algorithm 4. 1` and is added to the `LIST OF ALGORITHMS` automatically.

### Cross-references

Refer to figures, tables, equations, and algorithms by number: `Figure~\ref{fig:name}`. Refer to
sections by title: `Section \nameref{sec:name}`. `\nameref` prints the title of the labelled
section, so the reference stays right when numbering shifts. Refer to appendices by number,
`Appendix 1`, and to the tables or figures inside them with `\ref` (`Table~\ref{tab:name}` in
Appendix 1). The Discussion section of Chapter IV has an example.

### Citations

Add entries to `references/example.bib`, then `\cite{key}`. Several citations in one sentence print
as `[4],[5]` — ascending, never compressed into `[4]-[6]`.

The bibliography uses `IEEEtran-doi.bst`, a modified copy of IEEEtran.bst:

- an entry with a `doi` field prints `doi: ...` and no URL;
- an entry without a DOI but with `url` and `urldate` prints `Accessed: ... [Online]. Available: ...`;
- more than six authors are shortened to "et al.";
- URLs and DOIs use the text font, not typewriter.

`references/example.bib` has one example of each shape. Always fill in `doi` when the source has
one.

To use more than one `.bib` file, edit the line in `content/backmatter.tex`:

```latex
\bibliography{references/example,references/another-file}
```

Write the names without the `.bib` extension.

### Appendices

Appendix content lives in `appendices/<language>/appA.tex`. The table of contents shows a single
`APPENDIX` entry; the detail goes to the `LIST OF APPENDICES` through:

```latex
\AppendixSection{Appendix 1. Appendix Title}
\AppendixSubsection{Subsection Title}
\AppendixSection{Appendix 2. Next Appendix Title}
```

Appendices are numbered (`Appendix 1`, `Appendix 2`, ...), not lettered, and their subsections are
unnumbered. Tables and figures inside the appendix have their own numbering, `Table A.1` and
`Figure A.1` (`Tabel L.1` and `Gambar L.1` in the Indonesian edition), so they do not continue the
Chapter IV counters. The setting is at the top of `appA.tex`.

Do **not** use plain `\section` or `\subsection` inside an appendix: the titles would flood the
table of contents and never reach the list of appendices. Every `\AppendixSection` after the first
starts on a new page automatically. A `\label` right after either command can be cited from the
chapters with `\nameref`. Scanned documents (ethics letter, data validation form) go in with
`\BorderedGraphics`.

### Glossary and list of symbols

`content/<language>/glossary.tex` (GLOSSARY) holds domain terms together with abbreviations and
their expansions; there is no separate list of abbreviations. Leave out terms every reader of your
study program knows, or that are only mentioned in passing.

`content/<language>/symbols.tex` (LIST OF SYMBOLS) holds the core notation used across chapters,
ordered Latin letters, Greek letters, then calligraphic symbols. A symbol used in only one equation
is defined below that equation. If the manuscript has no equations, remove the LIST OF SYMBOLS
block from `content/frontmatter-lists.tex`.

## Print edition

`build cetak` (or `build en-cetak`) produces the same manuscript laid out for two-sided printing:

- every front-matter page and every chapter starts on a right-hand (odd) page;
- the 4 cm margin is always on the binding side, alternating left and right;
- filler pages say "This page is intentionally left blank", as in the screen edition;
- the orange outer cover stays one-sided.

In the front matter, use `\ThesisBlankPage` and `\ThesisPageBreak` instead of `\halamanKosong` and
`\clearpage`; both adapt to the edition.

For the print shop, `python tools/siapkan_cetak.py` (needs `pip install pypdf`) splits
`main-cetak.pdf` into the outer cover, the whole book two-sided, the front matter one-sided without
filler pages, and Chapter I through the appendix two-sided. Ask the print shop or your study
program which parts are printed one-sided.

## TikZ figures

Figures drawn with TikZ or pgfplots are pre-rendered to PDF rather than redrawn on every
compilation:

```
cd tikz
build                     REM every figure
build figure-name         REM a single figure
bash build.sh             # Linux, macOS, WSL
```

Output lands in `figures/`, ready for `\includegraphics`. `tikz/preamble.tex` provides flowchart
styles, pgfplots axis styles, and `\gridmat`/`\window` for drawing matrices with values
(convolution, pooling, padding); see `tikz/example-grid.tex`. Details are in
[`tikz/README.md`](tikz/README.md). Photos, screenshots, and script output do not need this
pipeline — put them straight into `figures/`.

## When a build fails

`build.bat` prints the error lines from the `.log` when a build fails. These are the usual causes.

**The build hangs, or `LaTeX Error: File 'xltabular.sty' not found`**
MiKTeX automatic package installation is off. Open MiKTeX Console → **Settings** → **General** → set
package installation to **Always**, then retry. On TeX Live, run the `tlmgr install` command from
the setup section.

**`major issue: So far, no MiKTeX administrator has checked for updates`**
A warning, not an error — the build still runs. Clear it by running **Check for updates** in MiKTeX
Console once.

**`bibtex: I found no \citation commands`**
The manuscript has no `\cite` yet. Not a build failure; the bibliography is simply empty.
`build.bat` prints a note and carries on.

**`NOTE: undefined references remain`**
Some `\ref` or `\cite` points at a `\label` or key that does not exist, usually a typo. Check the
`.log` for the name it complains about.

**Cross-references show up as `??`, or page numbers are wrong**
You ran `pdflatex` directly instead of through `build`. Use `build`, which runs all four passes.

**List titles are still in the old language after changing `\ThesisLanguage`**
The old `.toc`, `.lof`, and `.lot` files are still in use. Run `build clean`, then rebuild.

**`Undefined control sequence \algorithmcfname` or `Environment algorithm undefined`**
You used `\begin{algorithm}` in Chapters I–III. The proposal manuscript deliberately omits
`algorithm2e`. Move the pseudocode to Chapter IV, or build with `build draft` / `build skripsi`.

**`File 'logo_upn.png' not found`**
The compile was started from another folder. `build.bat` and `build.sh` always change into the
repository folder first; run through them instead of calling `pdflatex` from a subdirectory.

## Pre-submission checklist

- [ ] All metadata in `config/thesis-config.tex` is filled in, including the defense date, the
      signing date, and the QR-code link.
- [ ] Names and NIP/NPT of advisors, examiners, the dean, and the study-program coordinator are
      verified against the current faculty guide.
- [ ] The signature-page format and the duty-stamp requirement are confirmed with the study program.
- [ ] The QR code on the statement of originality has been scanned and opens the right link.
- [ ] `\ThesisShowHelpers` is set to `off`.
- [ ] No `\TemplateTodo`, `\TemplateTip`, `\Placeholder`, or `\FigurePlaceholder` calls remain.
- [ ] The bundled examples (related-work table, example figures, example algorithm, glossary and
      symbol entries, `example.bib` entries) have been replaced with your own content.
- [ ] `build clean` followed by `build skripsi` and `build cetak` completes with no
      `undefined references` note.
- [ ] The contents, figure, table, algorithm, and appendix lists match the manuscript.
- [ ] The `.bib` file has no duplicate entries under different keys.

If you are publishing the repository:

- [ ] No personal data, scanned signatures, or sensitive administrative documents.
- [ ] LaTeX auxiliary files are not committed (already handled by `.gitignore`).

## Disclaimer

This template is a technical aid. Official formatting requirements may change at any time. Always
check the final document against the latest guidance from your study program, faculty, and
advisors.
