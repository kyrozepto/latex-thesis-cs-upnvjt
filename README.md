# Template LaTeX Skripsi UPN "Veteran" Jawa Timur

Template ini disusun untuk membantu mahasiswa Program Studi Informatika, Fakultas Ilmu Komputer, Universitas Pembangunan Nasional "Veteran" Jawa Timur menulis skripsi menggunakan LaTeX.

Project ini berisi struktur awal skripsi, halaman administrasi, contoh bab, placeholder, dan tips penulisan. Isi contoh **bukan naskah final**; mahasiswa wajib menyesuaikan semua metadata, isi bab, sitasi, dan lampiran dengan penelitian masing-masing.

## Fitur utama

- Struktur skripsi lima bab:
  - Bab I Pendahuluan
  - Bab II Tinjauan Pustaka
  - Bab III Metodologi Penelitian
  - Bab IV Hasil dan Pembahasan
  - Bab V Kesimpulan dan Saran
- Halaman awal: halaman judul, lembar pengesahan, lembar persetujuan, pernyataan bebas plagiasi, abstrak, abstract, kata pengantar, daftar isi, daftar gambar, daftar tabel, daftar algoritma, dan daftar singkatan.
- Style LaTeX terpisah di `template.cls` agar isi dokumen lebih mudah dibaca.
- Placeholder dan tips di setiap bagian penting agar mahasiswa memahami apa yang perlu ditulis.
- Contoh penggunaan tabel, algoritma, daftar singkatan, lampiran, dan BibTeX.

## Struktur project

```text
.
├── main.tex                       # File utama dokumen
├── template.cls                   # Pengaturan format halaman, judul, daftar, caption, dan font
├── logo_upn.png                   # Logo yang digunakan pada halaman judul
├── chapters/
│   ├── ch01-introduction.tex
│   ├── ch02-literature-review.tex
│   ├── ch03-methodology.tex
│   ├── ch04-results-discussion.tex
│   └── ch05-conclusion-recommendations.tex
├── appendices/
│   └── appA.tex
├── figures/
│   └── README.md                  # Tempat menyimpan gambar/diagram
└── references/
    └── example.bib                # Contoh file BibTeX
```

## Cara cepat menggunakan template

1. Install distribusi LaTeX.
   - Linux/Ubuntu: `sudo apt install texlive-full`
   - macOS: gunakan MacTeX
   - Windows: gunakan TeX Live atau MiKTeX
   - Alternatif online: unggah project ini ke Overleaf.
2. Buka `main.tex`.
3. Ganti metadata pada bagian **Metadata Skripsi**, terutama:
   - `\ThesisTitleID`
   - `\ThesisTitleIDUpper`
   - `\ThesisTitle`
   - `\ThesisTitleUpper`
   - `\StudentName`
   - `\StudentNameUpper`
   - `\StudentID`
   - `\AdvisorOne`
   - `\AdvisorTwo`
   - nama penguji
   - tanggal ujian dan tahun pengumpulan
   - kata kunci
4. Tulis isi bab di folder `chapters/`.
5. Simpan gambar di folder `figures/`.
6. Simpan referensi BibTeX di folder `references/`.
7. Kompilasi dokumen hingga daftar isi dan sitasi terbarui.

## Cara kompilasi

Dari root project, jalankan:

```bash
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

Jika belum memakai sitasi BibTeX, perintah `bibtex main` dapat dilewati. Namun, untuk skripsi final dengan daftar pustaka, gunakan alur lengkap di atas.

Output utama adalah:

```text
main.pdf
```

## Metadata pejabat fakultas/prodi

Template ini mempertahankan nama berikut sesuai permintaan awal project:

- Dekan Fakultas Ilmu Komputer: **Prof. Dr. Ir. Novirina Hendrasarie, M.T.**
- Koordinator Program Studi Informatika: **Dr. Intan Yuniar Purbasari, S.Kom., M.Sc.**

Sebelum digunakan untuk pengumpulan resmi, tetap verifikasi nama, gelar, jabatan, dan NIP terbaru melalui pedoman fakultas/prodi.

## Panduan menulis setiap bagian

### Judul

Judul sebaiknya spesifik, ringkas, dan mencerminkan objek, metode, serta tujuan penelitian. Hindari judul terlalu umum seperti "Sistem Informasi Berbasis Web" tanpa konteks masalah dan objek.

### Abstrak

Abstrak biasanya memuat:

1. latar belakang singkat,
2. tujuan penelitian,
3. metode,
4. data atau objek penelitian,
5. hasil utama,
6. kesimpulan.

Hindari sitasi, gambar, tabel, dan pembahasan terlalu panjang di abstrak.

### Bab I Pendahuluan

Bab I harus menjawab mengapa penelitian perlu dilakukan. Pastikan rumusan masalah, tujuan, manfaat, dan batasan saling konsisten.

### Bab II Tinjauan Pustaka

Bab II menjelaskan dasar ilmiah penelitian. Jangan hanya menumpuk ringkasan artikel; susun berdasarkan tema dan tunjukkan celah penelitian.

### Bab III Metodologi Penelitian

Bab III harus cukup rinci agar pembaca memahami cara penelitian dilakukan. Jelaskan data, alat, metode, skenario uji, metrik, dan teknik analisis.

### Bab IV Hasil dan Pembahasan

Bab IV menyajikan hasil faktual lalu membahas maknanya. Jangan hanya menampilkan tabel; jelaskan pola, penyebab, perbandingan, dan keterbatasan.

### Bab V Kesimpulan dan Saran

Kesimpulan harus menjawab rumusan masalah berdasarkan hasil. Saran sebaiknya muncul dari keterbatasan penelitian, bukan daftar ide acak.

## Menghapus placeholder sebelum final

Template menggunakan dua perintah bantuan:

- `\TemplateTip{...}` untuk tips penulisan.
- `\TemplateTodo{...}` untuk instruksi pengisian.

Sebelum naskah final dikumpulkan, hapus semua pemanggilan `\TemplateTip` dan `\TemplateTodo`, lalu ganti dengan isi skripsi yang sebenarnya. Anda dapat mencari teks berikut:

```text
TemplateTip
TemplateTodo
Tips penulisan
Isi bagian ini
```

## Menambahkan gambar

1. Simpan gambar ke folder `figures/`, misalnya `alur_penelitian.png`.
2. Tambahkan di file bab:

```latex
\begin{figure}[H]
\centering
\includegraphics[width=0.85\linewidth]{alur_penelitian.png}
\caption{Alur penelitian}
\label{fig:alur-penelitian}
\end{figure}
```

3. Rujuk gambar di teks dengan `Gambar~\ref{fig:alur-penelitian}`.

## Menambahkan referensi

Tambahkan entri BibTeX ke file `.bib` di folder `references/`, lalu sitasi di teks:

```latex
Penelitian sebelumnya menunjukkan bahwa ... \cite{exampleReference}.
```

Jika membuat file BibTeX baru, ubah baris bibliography di `main.tex`, misalnya:

```latex
\bibliography{references/example,references/referensi_lain}
```

## Checklist sebelum dikumpulkan

- [ ] Semua metadata mahasiswa, judul, pembimbing, penguji, tanggal, dan tahun sudah benar.
- [ ] Nama dekan dan koordinator program studi sudah diverifikasi dengan pedoman terbaru.
- [ ] Semua placeholder dan tips template sudah dihapus atau diganti.
- [ ] Semua gambar memiliki caption dan dirujuk dalam teks.
- [ ] Semua tabel memiliki caption dan dirujuk dalam teks.
- [ ] Semua sitasi muncul di daftar pustaka.
- [ ] Tidak ada data pribadi/sensitif yang tidak boleh dipublikasikan.
- [ ] Dokumen berhasil dikompilasi tanpa error fatal.
- [ ] PDF akhir sudah diperiksa manual, terutama halaman administrasi.

## Catatan publikasi GitHub

Sebelum repository dipublikasikan:

- Jangan menyertakan naskah skripsi pribadi, data rahasia, tanda tangan, atau dokumen administrasi yang berisi informasi sensitif.
- Gunakan placeholder untuk nama mahasiswa, NPM, pembimbing, penguji, dan tanggal.
- Pastikan lisensi repository jelas jika template akan dipakai mahasiswa lain.
- Pertimbangkan menambahkan file `.gitignore` untuk file build LaTeX seperti `.aux`, `.log`, `.toc`, `.bbl`, `.blg`, dan `main.pdf` jika PDF tidak ingin dilacak.

## Disclaimer

Template ini adalah bantuan teknis penulisan LaTeX. Format resmi dapat berubah sewaktu-waktu. Selalu cocokkan hasil akhir dengan pedoman terbaru dari program studi, fakultas, dan dosen pembimbing.
