"""siapkan_cetak.py -- pecah PDF edisi cetak menjadi berkas untuk percetakan.

Pemakaian (dari folder akar repositori, setelah `build cetak`):

    python tools/siapkan_cetak.py                 # main-cetak.pdf
    python tools/siapkan_cetak.py main-en-cetak   # edisi Inggris
    python tools/siapkan_cetak.py semhas          # PDF lain, tanpa ekstensi

Membutuhkan pypdf (`pip install pypdf`). Hasil ditulis ke folder
`siap_cetak_<nama>/`:

    00_sampul_luar.pdf          sampul oranye saja, untuk kertas sampul tebal
                                (hanya dibuat bila PDF memuat sampul luar)
    01_buku_utuh_duplex.pdf     seluruh halaman, untuk sekali cetak bolak-balik
    02_bagian_depan_1sisi.pdf   sampul s.d. halaman sebelum Bab I, satu sisi,
                                tanpa halaman "sengaja dikosongkan"
    03_isi_duplex.pdf           Bab I s.d. akhir lampiran, bolak-balik

Tanyakan ke percetakan atau program studi bagian mana yang dicetak satu sisi;
pilih berkas 01 atau pasangan 02 dan 03 sesuai jawabannya.
"""

import os
import sys

from pypdf import PdfReader, PdfWriter

FILLER_TEXTS = {
    "",
    "halaman ini sengaja dikosongkan",
    "this page is intentionally left blank",
}


def page_lines(page):
    text = page.extract_text() or ""
    return [line.strip() for line in text.splitlines() if line.strip()]


def is_filler(page):
    return " ".join(page_lines(page)).lower() in FILLER_TEXTS


def find_chapter_one(reader):
    """Index of the first page whose heading is "BAB I" or "CHAPTER I"."""
    for i, page in enumerate(reader.pages):
        lines = page_lines(page)
        if lines and lines[0] in ("BAB I", "CHAPTER I"):
            return i
    return None


def write(pages, path):
    writer = PdfWriter()
    for page in pages:
        writer.add_page(page)
    with open(path, "wb") as handle:
        writer.write(handle)
    print(f"[OK] {os.path.basename(path)} ({len(pages)} halaman)")


def main():
    name = sys.argv[1] if len(sys.argv) > 1 else "main-cetak"
    name = name[:-4] if name.endswith(".pdf") else name
    pdf = f"{name}.pdf"
    if not os.path.exists(pdf):
        sys.exit(f"{pdf} tidak ditemukan. Bangun dulu naskahnya, misalnya `build cetak`.")

    reader = PdfReader(pdf)
    pages = list(reader.pages)
    out_dir = f"siap_cetak_{name}"
    os.makedirs(out_dir, exist_ok=True)

    chapter_one = find_chapter_one(reader)
    if chapter_one is None:
        sys.exit("Halaman BAB I / CHAPTER I tidak ditemukan; periksa judul bab pertama.")
    print(f"{pdf}: {len(pages)} halaman, Bab I pada halaman PDF {chapter_one + 1}.")

    # Sampul luar dan sampul dalam memiliki teks yang sama persis.
    has_outer_cover = len(pages) > 1 and page_lines(pages[0]) == page_lines(pages[1])
    if has_outer_cover:
        write(pages[:1], os.path.join(out_dir, "00_sampul_luar.pdf"))

    write(pages, os.path.join(out_dir, "01_buku_utuh_duplex.pdf"))
    front = [p for p in pages[:chapter_one] if not is_filler(p)]
    write(front, os.path.join(out_dir, "02_bagian_depan_1sisi.pdf"))
    write(pages[chapter_one:], os.path.join(out_dir, "03_isi_duplex.pdf"))
    print(f"Selesai. Berkas ada di {out_dir}/")


if __name__ == "__main__":
    main()
