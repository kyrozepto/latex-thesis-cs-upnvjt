# Template LaTeX Skripsi Fasilkom UPN "Veteran" Jawa Timur

[English](README.en.md)

Template LaTeX untuk skripsi Fakultas Ilmu Komputer UPN "Veteran" Jawa Timur. Format halaman depan,
margin, spasi, penomoran, dan daftar pustaka mengikuti buku skripsi contoh fakultas tahun 2026.
Satu repositori dipakai dari proposal sampai naskah akhir: bab ditulis sekali, lalu dibangun menjadi
naskah yang dibutuhkan pada tiap tahap.

Contoh hasilnya: [`template-preview-id.pdf`](template-preview-id.pdf) dan
[`template-preview-en.pdf`](template-preview-en.pdf).

## Mulai dalam 3 langkah

**1. Pasang LaTeX** (sekali saja).

- **Windows:** pasang [MiKTeX](https://miktex.org/download) untuk pengguna saat ini ("for me only").
  Buka **MiKTeX Console**, lalu:
  - **Updates** → **Check for updates** → **Update now**;
  - **Settings** → **General** → pemasangan paket otomatis → **Always**.
- **Linux:** `sudo apt install texlive-full` (Debian/Ubuntu) atau
  `sudo dnf install texlive-scheme-full` (Fedora).
- **macOS:** `brew install --cask mactex`.

**2. Isi data Anda** di satu berkas: [`config/thesis-config.tex`](config/thesis-config.tex) — judul,
nama, NPM, pembimbing, penguji, tanggal, dan kata kunci.

**3. Build.**

```bash
build proposal        # Windows
./build.sh proposal   # Linux, macOS, WSL
```

Hasilnya `proposal.pdf`. Build pertama di MiKTeX bisa beberapa menit karena paket diunduh; build
berikutnya beberapa detik.

## Naskah yang bisa dibangun

| Perintah | Hasil | Isi | Untuk |
|---|---|---|---|
| `build proposal` | `proposal.pdf` | Bab I–III | seminar proposal |
| `build draft` | `skripsi-draft.pdf` | Bab I–IV + lampiran | bimbingan |
| `build semhas` | `semhas.pdf` | Bab I–V + abstrak | seminar hasil |
| `build skripsi` | `main.pdf` | naskah lengkap | naskah akhir (layar) |
| `build cetak` | `main-cetak.pdf` | naskah lengkap | cetak bolak-balik |
| `build en` | `main-en.pdf` | naskah lengkap | edisi bahasa Inggris |
| `build en-cetak` | `main-en-cetak.pdf` | naskah lengkap | edisi Inggris, cetak bolak-balik |
| `build all` | semua di atas | | |
| `build clean` | menghapus berkas bantu | | jalankan bila hasil terlihat aneh |

Semua naskah memakai berkas bab yang sama. Saat proposal naik menjadi skripsi, tidak ada yang perlu
disalin; cukup jalankan perintah build yang lain.

## Di mana menulis

```text
config/thesis-config.tex        data diri, judul, tanggal        <- diisi sekali
chapters/indonesian/ch01..ch05  Bab I sampai Bab V               <- tempat menulis sehari-hari
content/indonesian/             abstrak, kata pengantar, daftar istilah, daftar simbol
appendices/indonesian/appA.tex  lampiran
references/example.bib          daftar pustaka
figures/                        gambar
```

Untuk naskah berbahasa Inggris, tulis di folder `english/` yang sejajar. Berkas lain (`template.cls`,
`content/*.tex`, `config/thesis-preamble.tex`) mengatur format dan tidak perlu diubah.

Setiap bab contoh sudah berisi kerangka subbab, contoh gambar, tabel, persamaan, dan algoritma, serta
kotak **"Isi bagian ini"** yang menjelaskan apa yang ditulis di tiap subbab. Kotak itu hanya tampil
di `main.pdf` dan hilang sendiri pada proposal, draf, dan semhas.

## Panduan lengkap

[`docs/panduan.md`](docs/panduan.md) menjelaskan:

- pengaturan di `thesis-config.tex` (bahasa, sampul luar, QR code, kotak bantuan);
- kerangka tiap bab;
- gambar, tabel, persamaan, algoritma, rujukan silang, sitasi, dan lampiran;
- edisi cetak dan cara menyiapkan berkas untuk percetakan;
- gambar TikZ;
- penyebab build gagal dan cara mengatasinya.

## Checklist sebelum mengumpulkan

- [ ] Seluruh isian `config/thesis-config.tex` sudah benar, termasuk tanggal sidang, tanggal tanda
      tangan, dan tautan QR code.
- [ ] Nama dan NIP/NPT pembimbing, penguji, dekan, dan koordinator program studi sudah dicek.
- [ ] Format halaman tanda tangan dan kebutuhan meterai sudah dikonfirmasi ke program studi.
- [ ] QR code pada pernyataan orisinalitas sudah dipindai dan membuka tautan yang benar.
- [ ] `\ThesisShowHelpers` disetel `off`, dan tidak ada lagi `\TemplateTodo`, `\TemplateTip`,
      `\Placeholder`, atau `\FigurePlaceholder` di naskah.
- [ ] Semua contoh bawaan template sudah diganti isi sendiri.
- [ ] `build clean` lalu `build skripsi` berjalan tanpa catatan `undefined references`.

## Disclaimer

Template ini adalah bantuan teknis. Format resmi dapat berubah sewaktu-waktu; selalu cocokkan hasil
akhir dengan pedoman terbaru dari program studi, fakultas, dan dosen pembimbing.
