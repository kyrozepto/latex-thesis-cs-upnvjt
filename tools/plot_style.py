"""plot_style.py -- gaya matplotlib yang menyatu dengan naskah.

Grafik dari Python yang memakai font, ukuran huruf, dan lebar berbeda dengan
naskah terlihat seperti tempelan. Modul ini menyamakan ketiganya:

  - font serif Times, sama dengan newtxtext pada template.cls;
  - huruf 10 pt dan label sumbu 9 pt, sedikit di bawah teks 12 pt naskah;
  - lebar gambar sama dengan lebar teks (A4, margin kiri 4 cm, kanan 2,5 cm),
    sehingga gambar disisipkan dengan width=\\linewidth tanpa diperkecil dan
    8 pt di gambar tetap 8 pt di halaman.

Pemakaian:

    import sys; sys.path.insert(0, "tools")
    from plot_style import apply_style, figure, save

    apply_style()
    fig, ax = figure(height_ratio=0.6)
    ax.plot(x, y, color=ACCENT)
    save(fig, "figures/ch4_kurva_latih.pdf")

Simpan sebagai PDF agar grafik tetap vektor.
"""

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

# Lebar teks halaman isi: 21 cm - 4 cm - 2,5 cm = 14,5 cm.
TEXT_WIDTH_IN = 14.5 / 2.54

# Palet netral yang tetap terbaca saat dicetak hitam-putih: bedakan seri lebih
# dahulu dengan kecerahan, baru dengan warna.
INK = "#1a1a1a"
GREY = "#7d7d7d"
PALE = "#bfbfbf"
ACCENT = "#2f5d8a"
ACCENT_2 = "#c0602a"

STYLE = {
    "font.family": "serif",
    "font.serif": ["Times New Roman", "Nimbus Roman", "STIXGeneral", "DejaVu Serif"],
    "mathtext.fontset": "stix",
    "font.size": 10.0,
    "axes.labelsize": 10.0,
    "axes.titlesize": 10.0,
    "xtick.labelsize": 9.0,
    "ytick.labelsize": 9.0,
    "legend.fontsize": 9.0,
    "axes.edgecolor": INK,
    "axes.linewidth": 0.6,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.grid": True,
    "grid.color": "#e6e6e6",
    "grid.linewidth": 0.5,
    "lines.linewidth": 1.2,
    "legend.frameon": False,
    "savefig.bbox": "tight",
    "savefig.pad_inches": 0.02,
    "pdf.fonttype": 42,
}


def apply_style():
    plt.rcParams.update(STYLE)


def figure(width_ratio=1.0, height_ratio=0.62, **kwargs):
    """Figure selebar `width_ratio` x lebar teks, tinggi `height_ratio` x lebarnya."""
    width = TEXT_WIDTH_IN * width_ratio
    return plt.subplots(figsize=(width, width * height_ratio), **kwargs)


def save(fig, path):
    fig.savefig(path)
    plt.close(fig)
