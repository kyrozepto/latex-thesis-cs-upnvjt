# LaTeX Skripsi/Tesis UPN Veteran Jawa Timur

Template ini dibuat untuk membantu mahasiswa Fakultas Ilmu Komputer, Universitas Pembangunan Nasional "Veteran" Jawa Timur dalam menulis skripsi menggunakan LaTeX.

Project ini berisi struktur awal skripsi/tesis, halaman administrasi, contoh bab, placeholder, dan tips penulisan. Isi contoh **bukan naskah final**, mahasiswa wajib menyesuaikan semua metadata, isi bab, sitasi, dan lampiran dengan penelitian masing-masing.

---

## Struktur Project

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

---

## Cara Cepat Menggunakan Template

1. **Install distribusi LaTeX** sesuai sistem operasi:
   - Linux/Ubuntu: `sudo apt install texlive-full`
   - macOS: gunakan [MacTeX](https://www.tug.org/mactex/)
   - Windows: gunakan [TeX Live](https://www.tug.org/texlive/) atau [MiKTeX](https://miktex.org/)
   - Online: upload project ini ke [Overleaf](https://www.overleaf.com/)
2. Buka `main.tex`.
3. Ganti metadata pada bagian **Metadata Skripsi**, terutama:
   - `\ThesisTitleID` dan `\ThesisTitleIDUpper`
   - `\ThesisTitle` dan `\ThesisTitleUpper`
   - `\StudentName` dan `\StudentNameUpper`
   - `\StudentID`
   - `\AdvisorOne` dan `\AdvisorTwo`
   - nama penguji, tanggal ujian, tahun pengumpulan, dan kata kunci
4. Tulis isi bab di folder `chapters/`.
5. Simpan gambar di folder `figures/`.
6. Simpan referensi BibTeX di folder `references/`.
7. Kompilasi dokumen hingga daftar isi dan sitasi terbarui.

---

## Panduan Menulis Setiap Bagian

### Judul

Judul yang baik bersifat spesifik, ringkas, dan mencerminkan objek, metode, serta tujuan penelitian. Hindari judul terlalu umum seperti "Sistem Informasi Berbasis Web" tanpa konteks masalah dan objek yang jelas.

### Abstrak

Abstrak memuat komponen berikut secara singkat:

1. Latar belakang
2. Tujuan penelitian
3. Metode yang digunakan
4. Data atau objek penelitian
5. Hasil utama
6. Kesimpulan

Hindari sitasi, gambar, tabel, dan pembahasan yang terlalu panjang di dalam abstrak.

### Bab I — Pendahuluan

Bab I harus menjawab mengapa penelitian perlu dilakukan. Pastikan rumusan masalah, tujuan, manfaat, dan batasan penelitian saling konsisten satu sama lain.

### Bab II — Tinjauan Pustaka

Bab II menjelaskan dasar ilmiah penelitian. Jangan sekadar menumpuk ringkasan artikel — susun berdasarkan tema dan tunjukkan celah penelitian yang ingin diisi.

### Bab III — Metodologi Penelitian

Bab III harus cukup rinci agar pembaca memahami bagaimana penelitian dilakukan. Jelaskan data, alat, metode, skenario uji, metrik evaluasi, dan teknik analisis yang digunakan.

### Bab IV — Hasil dan Pembahasan

Bab IV menyajikan hasil faktual lalu membahas maknanya. Jangan hanya menampilkan tabel atau grafik — jelaskan pola, penyebab, perbandingan antar kondisi, dan keterbatasan yang ditemukan.

### Bab V — Kesimpulan dan Saran

Kesimpulan harus menjawab rumusan masalah berdasarkan hasil penelitian. Saran sebaiknya lahir dari keterbatasan penelitian, bukan sekadar daftar ide yang tidak berkaitan.

---

## Menghapus Placeholder Sebelum Final

Template menggunakan dua perintah bantuan:

- `\TemplateTip{...}` — untuk tips penulisan
- `\TemplateTodo{...}` — untuk instruksi pengisian

Sebelum naskah final dikumpulkan, hapus semua pemanggilan kedua perintah tersebut dan ganti dengan isi skripsi yang sebenarnya. Gunakan fitur pencarian teks untuk menemukan sisa placeholder:

```text
TemplateTip
TemplateTodo
Tips penulisan
Isi bagian ini
```

---

## Menambahkan Gambar

1. Simpan file gambar ke folder `figures/`, misalnya `alur_penelitian.png`.
2. Tambahkan kode berikut di file bab yang sesuai:

```latex
\begin{figure}[H]
    \centering
    \includegraphics[width=0.85\linewidth]{alur_penelitian.png}
    \caption{Alur penelitian}
    \label{fig:alur-penelitian}
\end{figure}
```

3. Rujuk gambar di dalam teks dengan `Gambar~\ref{fig:alur-penelitian}`.

---

## Menambahkan Referensi

Tambahkan entri BibTeX ke file `.bib` di folder `references/`, lalu sitasi di dalam teks:

```latex
Penelitian sebelumnya menunjukkan bahwa ... \cite{exampleReference}.
```

Jika menggunakan lebih dari satu file BibTeX, daftarkan semuanya di `main.tex`:

```latex
\bibliography{references/example,references/referensi_lain}
```

---

## Checklist Sebelum Dikumpulkan

- [ ] Semua metadata mahasiswa, judul, pembimbing, penguji, tanggal, dan tahun sudah benar.
- [ ] Nama dekan dan koordinator program studi sudah diverifikasi dengan pedoman terbaru.
- [ ] Semua placeholder dan tips template sudah dihapus atau diganti.
- [ ] Semua gambar memiliki caption dan dirujuk dalam teks.
- [ ] Semua tabel memiliki caption dan dirujuk dalam teks.
- [ ] Semua sitasi muncul di daftar pustaka.
- [ ] Tidak ada data pribadi atau sensitif yang tidak boleh dipublikasikan.
- [ ] Dokumen berhasil dikompilasi tanpa error fatal.
- [ ] PDF akhir sudah diperiksa secara manual.

---

## Disclaimer

Template ini adalah bantuan teknis untuk penulisan LaTeX. Format resmi dapat berubah sewaktu-waktu. Selalu cocokkan hasil akhir dengan pedoman terbaru dari program studi, fakultas, dan dosen pembimbing.
