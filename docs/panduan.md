# Panduan Lengkap

[← Kembali ke README](../README.md) · [English](guide.md)

- [Pengaturan](#pengaturan)
- [Isi tiap naskah](#isi-tiap-naskah)
- [Kerangka bab](#kerangka-bab)
- [Gambar](#gambar)
- [Tabel](#tabel)
- [Persamaan dan algoritma](#persamaan-dan-algoritma)
- [Rujukan silang dan sitasi](#rujukan-silang-dan-sitasi)
- [Lampiran](#lampiran)
- [Daftar istilah dan daftar simbol](#daftar-istilah-dan-daftar-simbol)
- [Edisi cetak](#edisi-cetak)
- [Gambar TikZ](#gambar-tikz)
- [Kalau build gagal](#kalau-build-gagal)
- [Struktur berkas](#struktur-berkas)

## Pengaturan

Semua pengaturan ada di `config/thesis-config.tex`.

| Isian | Nilai | Keterangan |
|---|---|---|
| `\ThesisLanguage` | `indonesian` / `english` | Bahasa label dan folder yang dibaca. `build en` dan `build en-cetak` memakai bahasa Inggris tanpa perlu mengubah isian ini. |
| `\ThesisDocumentType` | `skripsi` / `tesis` | Menentukan kata *Skripsi* atau *Tesis* di seluruh naskah. |
| `\ThesisShowHelpers` | `auto` / `on` / `off` | Kotak "Isi bagian ini". `auto`: tampil hanya di `main.pdf`. Setel `off` untuk naskah yang dikumpulkan. |
| `\ThesisColorCover` | `auto` / `on` / `off` | Sampul luar oranye. `auto`: hanya pada naskah akhir. |
| `\DefenseDateID` / `EN` | tanggal | Tanggal sidang, tercetak di lembar pengesahan. |
| `\SignDateID` / `EN` | tanggal | Tanggal tanda tangan pernyataan orisinalitas dan kata pengantar, biasanya setelah revisi selesai. |
| `\OriginalityQRLink` | tautan | Dicetak sebagai QR code di samping tanda tangan pernyataan orisinalitas, misalnya folder berkas pendukung. Kosongkan untuk menghilangkan QR code. |

Sisanya isian biasa: judul Indonesia dan Inggris, nama, NPM, program studi, pembimbing, Ketua
Penguji dan Penguji I, dekan, koordinator program studi, tahun, dan kata kunci.

Jalankan `build clean` setiap kali mengganti bahasa, karena daftar isi lama masih tersimpan.

## Isi tiap naskah

| | `proposal` | `draft` | `semhas` | `skripsi` |
|---|---|---|---|---|
| Bab | I–III | I–IV | I–V | I–V |
| Tulisan di sampul | PRA-SKRIPSI | SKRIPSI (DRAF BAB I--IV) | SKRIPSI | SKRIPSI |
| Sampul luar oranye | – | – | – | ✓ |
| Lembar pengesahan, persetujuan, pernyataan orisinalitas | – | – | – | ✓ |
| Abstrak | – | – | ✓ | ✓ |
| Kata pengantar | – | – | – | ✓ |
| Daftar Isi, Gambar, Tabel, Istilah, Simbol | ✓ | ✓ | ✓ | ✓ |
| Daftar Algoritma, Daftar Lampiran, Lampiran | – | ✓ | ✓ | ✓ |

Edisi cetak dan edisi Inggris isinya sama dengan `skripsi`. Tidak ada DAFTAR SINGKATAN: singkatan
ditulis di DAFTAR ISTILAH.

## Kerangka bab

Kerangka bab mengikuti susunan skripsi yang sudah lulus. Setiap bab dibuka dengan satu paragraf
pengantar sebelum subbab pertama. Judul bab otomatis dicetak kapital, dan penomoran `BAB I` serta
`3.2.1.` diatur template.

| Bab | Subbab |
|---|---|
| I Pendahuluan | Latar Belakang, Rumusan Masalah, Tujuan Penelitian, Manfaat Penelitian, Batasan Penelitian |
| II Tinjauan Pustaka | Penelitian Terdahulu, lalu satu subbab per konsep teori (tanpa subbab payung "Landasan Teori") |
| III Metodologi Penelitian | Tahapan Penelitian, Studi Literatur, Analisis Kebutuhan, Pengumpulan Data, subbab perancangan sesuai metode, Pengujian, Evaluasi |
| IV Hasil dan Pembahasan | Lingkungan dan Pelaksanaan Penelitian, subbab hasil yang berpasangan dengan subbab Bab III, Pembahasan (Jawaban atas Rumusan Masalah, Perbandingan dengan Penelitian Terdahulu, Faktor Pembatas Validitas Penelitian) |
| V Kesimpulan dan Saran | Kesimpulan, Saran |

Pseudocode ditempatkan di Bab IV, bukan Bab III, karena yang dilaporkan adalah prosedur yang
benar-benar dijalankan. Karena itu naskah proposal tidak memuat paket algoritma sama sekali.

## Gambar

Letakkan berkas di `figures/`, lalu:

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\linewidth]{nama-gambar.pdf}
  \caption{Keterangan gambar.}
  \label{fig:nama-gambar}
\end{figure}
```

Rujuk dengan `Gambar~\ref{fig:nama-gambar}`, jangan menulis nomornya sendiri.

| Kebutuhan | Cara | Contoh di |
|---|---|---|
| Gambar belum ada | `\FigurePlaceholder{4cm}{keterangan}` di dalam `figure`; nomor dan caption tetap hidup | Bab III |
| Beberapa panel (a)/(b) dari satu gambar | label panel digambar dengan TikZ | Bab II |
| Beberapa panel dari beberapa berkas | tiap berkas di `minipage[t]`, satu caption bersama | Bab IV |
| Judul panjang | `\caption[Judul pendek untuk daftar]{Judul lengkap}` | Bab IV |
| Tangkapan layar, pindaian dokumen | `\BorderedGraphics[width=\linewidth]{berkas.png}` (bingkai tipis) | Bab IV, Lampiran 2 |
| Gambar berlabel Inggris | simpan di `figures/english/` dengan nama yang sama | |
| Grafik dari Python | `tools/plot_style.py` menyamakan font dan lebar dengan naskah | |

## Tabel

Empat bentuk tabel sudah ada di naskah contoh, masing-masing dengan penjelasan di komentarnya:

| Bentuk | Kapan dipakai | Contoh |
|---|---|---|
| Kolom tetap `P{...}` + satu kolom lentur `Y` | paling sering | Tabel 3.1 |
| Seluruh kolom lentur berbobot `L{...}` | semua kolom berisi kalimat | Tabel 2.1 |
| `longtable` dengan kolom `l`/`c` | tabel angka | Tabel 4.1 |
| Huruf diperkecil dalam `\begingroup` | tabel dengan banyak kolom | Tabel 4.2 |

Aturan untuk semua tabel:

- Jangan bungkus dengan `\begin{table}` dan jangan pakai `[H]`; tabel ini boleh terpotong
  antarhalaman dan menempatkan dirinya sendiri.
- `\caption` dan `\label` ditulis di baris pertama di dalam tabel, diakhiri `\\`.
- Sebut tabel dalam kalimat sebelum tabelnya muncul, lalu bahas isinya setelahnya.
- Angka desimal ditulis dengan koma pada naskah Indonesia. Di mode matematika tulis `$0{,}00$`.

Kolom `P`, `Y`, dan `L` rata kiri supaya kolom sempit tidak diregangkan sampai berlubang.

## Persamaan dan algoritma

Persamaan bernomor otomatis `(2.1)`:

```latex
\begin{equation}
  E = mc^2
  \label{eq:einstein}
\end{equation}
```

Algoritma bernomor `Algoritma 4. 1`, dibingkai penuh, dan masuk DAFTAR ALGORITMA:

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

`\KwInput`, `\KwOutput`, dan `\KwReturn` otomatis berbahasa Indonesia atau Inggris mengikuti
naskah.

## Rujukan silang dan sitasi

| Yang dirujuk | Cara menulis | Hasil |
|---|---|---|
| Gambar, tabel, persamaan, algoritma | `Gambar~\ref{fig:nama}` | Gambar 3. 1 |
| Subbab | `Subbab \nameref{sec:nama}` | Subbab *judul subbabnya* |
| Lampiran | tulis nomornya: `Lampiran 1`; isinya dengan `\ref` | Tabel L.1 di Lampiran 1 |
| Pustaka | `\cite{kunci}` atau `\cite{a,b}` | [4],[5] |

`\nameref` mencetak judul subbab, sehingga rujukan tetap benar walaupun nomornya bergeser.

Daftar pustaka bergaya IEEE (`IEEEtran-doi.bst`): entri ber-`doi` dicetak `doi: ...`, entri daring
dengan `url` dan `urldate` dicetak `Accessed: ... [Online]. Available: ...`, dan lebih dari enam
penulis diringkas menjadi "et al.". `references/example.bib` memuat contoh ketiganya. Selalu isi
`doi` bila sumbernya punya.

Untuk lebih dari satu berkas `.bib`, ubah baris di `content/backmatter.tex` menjadi
`\bibliography{references/example,references/berkas-lain}` (tanpa ekstensi).

## Lampiran

Lampiran ditulis di `appendices/<bahasa>/appA.tex`:

```latex
\AppendixSection{Lampiran 1. Judul Lampiran}
\AppendixSubsection{Judul Subbagian}
\AppendixSection{Lampiran 2. Judul Lampiran Berikutnya}
```

- Lampiran bernomor angka, bukan huruf; subbagiannya tidak bernomor.
- Tabel dan gambar di lampiran bernomor `Tabel L.1` dan `Gambar L.1` (`Table A.1`, `Figure A.1` pada
  edisi Inggris), terpisah dari nomor Bab IV.
- Rincian lampiran tercatat di DAFTAR LAMPIRAN; DAFTAR ISI hanya menampilkan satu entri LAMPIRAN.
  Karena itu jangan memakai `\section` biasa di lampiran.
- Setiap lampiran setelah yang pertama dimulai di halaman baru.
- Dokumen pindaian, misalnya surat etik atau lembar validasi data, disisipkan dengan
  `\BorderedGraphics`.

## Daftar istilah dan daftar simbol

- `content/<bahasa>/glossary.tex` (DAFTAR ISTILAH): istilah khusus beserta singkatan dan
  kepanjangannya, urut abjad. Istilah yang umum dikenal tidak perlu dicantumkan.
- `content/<bahasa>/symbols.tex` (DAFTAR SIMBOL): notasi inti yang dipakai lintas bab, urut huruf
  Latin, Yunani, lalu kaligrafi. Simbol yang muncul di satu persamaan saja cukup dijelaskan di bawah
  persamaannya. Jika naskah tanpa persamaan, hapus blok DAFTAR SIMBOL di
  `content/frontmatter-lists.tex`.

## Edisi cetak

`build cetak` dan `build en-cetak` menghasilkan naskah yang sama untuk dicetak bolak-balik:

- setiap halaman depan dan setiap bab dimulai di halaman kanan;
- margin 4 cm selalu di sisi jilid;
- halaman pengisi bertuliskan "Halaman ini sengaja dikosongkan";
- sampul luar oranye tetap satu sisi.

Untuk percetakan, jalankan `python tools/siapkan_cetak.py` (perlu `pip install pypdf`). Skrip ini
memecah `main-cetak.pdf` menjadi sampul luar, buku utuh, bagian depan satu sisi, dan isi bolak-balik
di folder `siap_cetak_main-cetak/`. Tanyakan ke percetakan atau program studi bagian mana yang
dicetak satu sisi.

## Gambar TikZ

Diagram TikZ dan grafik pgfplots dirender lebih dulu menjadi PDF di `figures/`:

```bash
cd tikz
build nama-gambar        # Windows; tanpa nama = semua gambar
bash build.sh            # Linux, macOS, WSL
```

`tikz/preamble.tex` menyediakan gaya diagram alur, gaya grafik, dan `\gridmat`/`\window` untuk
menggambar matriks bernilai (konvolusi, pooling). Lihat [`tikz/README.md`](../tikz/README.md) dan
contoh `tikz/example-diagram.tex` serta `tikz/example-grid.tex`. Foto dan tangkapan layar langsung
diletakkan di `figures/`.

## Kalau build gagal

`build` mencetak baris galat dari berkas `.log` saat gagal.

| Gejala | Penyebab dan solusi |
|---|---|
| Build menggantung, atau `File '...sty' not found` | MiKTeX belum memasang paket otomatis. Setel **Settings → General → Always** di MiKTeX Console. |
| `major issue: ... checked for updates` | Hanya peringatan. Jalankan **Check for updates** di MiKTeX Console sekali. |
| `I found no \citation commands` | Belum ada `\cite`. Bukan galat. |
| `NOTE: undefined references remain` | Ada `\ref` atau `\cite` yang salah ketik. Cari namanya di berkas `.log`. |
| Rujukan muncul sebagai `??` | `pdflatex` dijalankan sendiri. Pakai `build`, yang menjalankan keempat langkahnya. |
| Judul daftar masih bahasa lama | Jalankan `build clean`, lalu build ulang. |
| `Environment algorithm undefined` | Algoritma dipakai di Bab I–III. Pindahkan ke Bab IV. |
| `File 'logo_upn.png' not found` | Build dijalankan dari folder lain. Jalankan `build` dari folder repositori. |

## Struktur berkas

```text
.
├── build.bat / build.sh          skrip build
├── main.tex                      naskah lengkap (dipakai juga oleh edisi cetak, Inggris, semhas)
├── main-cetak.tex, main-en.tex, main-en-cetak.tex, semhas.tex
├── proposal.tex, skripsi-draft.tex
├── template.cls                  format halaman, tipografi, penomoran
├── IEEEtran-doi.bst              gaya daftar pustaka
├── config/
│   ├── thesis-config.tex         isian Anda
│   ├── thesis-language.tex       label Indonesia/Inggris
│   └── thesis-preamble.tex       paket dan makro bersama
├── content/                      sampul, halaman depan, daftar, daftar pustaka
│   ├── indonesian/               abstrak, kata pengantar, daftar istilah, daftar simbol
│   └── english/
├── chapters/{indonesian,english}/ch01..ch05.tex
├── appendices/{indonesian,english}/appA.tex
├── figures/                      gambar (figures/english/ untuk versi Inggris)
├── references/example.bib
├── tikz/                         sumber gambar TikZ
└── tools/                        siapkan_cetak.py, plot_style.py
```
