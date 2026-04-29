# Template Tugas Akhir UGM (Unofficial) - Typst

> Preview ada di bagian bawah README ihi.

Template tugas akhir (skripsi) tidak resmi Universitas Gadjah Mada (UGM) yang ditulis menggunakan [Typst](https://typst.app/). Template ini mengikuti pedoman penulisan tugas akhir UGM dengan format yang telah disesuaikan, termasuk margin, font Times New Roman, spasi, dan struktur halaman yang sesuai standar.

> **Disclaimer**: Template ini bersifat tidak resmi (unofficial). Penulis tidak bertanggung jawab jika terdapat ketidaksesuaian dengan pedoman terbaru dari fakultas/departemen masing-masing. Pastikan untuk menyesuaikan dengan pedoman resmi yang berlaku di program studi Anda.
>
> **Status Penggunaan**: Template ini telah digunakan penulis dari proposal hingga acc revisi skripsi.

---

## Fitur Utama

- **Halaman Sampul & Judul**: Sampul luar dan halaman judul dengan format UGM
- **Halaman Pengesahan**: Format tim penguji dengan tanda tangan
- **Halaman Pernyataan**: Pernyataan keaslian karya
- **Prakata**: Halaman ucapan terima kasih
- **Intisari & Abstract**: Ringkasan dalam Bahasa Indonesia dan Bahasa Inggris
- **Daftar Otomatis**:
  - Daftar Isi
  - Daftar Tabel
  - Daftar Gambar
  - Daftar Persamaan
  - Daftar Pseudocode
  - Daftar Kode (Source Code)
  - Daftar Singkatan (Acronym)
- **Penomoran**: Penomoran halaman romawi (i, ii, iii...) untuk bagian awal dan angka (1, 2, 3...) untuk isi
- **Heading**: Format BAB dengan huruf romawi besar (BAB I, BAB II, ...) dan subbab dengan angka (1.1, 1.2, ...)
- **Bibliografi**: Mendukung file `.bib` dengan format CSL (tersedia `dkk.csl` untuk format Diktat/Kuliah)
- **Gambar & Tabel**: Format caption tebal, penomoran otomatis per BAB
- **Pseudocode**: Mendukung penulisan algoritma/pseudocode
- **Persamaan Matematika**: Format persamaan dengan penomoran otomatis
- **Blok Kode**: Syntax highlighting dengan line numbers dan border
- **Akronim**: Manajemen singkatan otomatis via `acrostiche`
- **Plot/Chart**: Dukungan pembuatan grafik via CeTZ (native Typst plotting)

---

## Prasyarat

Pastikan Anda telah menginstall [Typst](https://github.com/typst/typst) terlebih dahulu. Typst akan otomatis mengunduh package yang dibutuhkan dari registry `@preview`.

Package yang digunakan:
- `@preview/acrostiche:0.5.2` — manajemen singkatan/akronim
- `@preview/cetz:0.4.0` — pembuatan diagram dan grafik
- `@preview/cetz-plot:0.1.2` — plotting data

---

## Struktur Proyek

```
.
├── main.typ              # File utama, tempat konfigurasi metadata dan include bab
├── conf.typ              # Konfigurasi template, styling, dan helper functions
├── bib.bib               # File bibliografi (BibTeX format)
├── dkk.csl               # Citation Style Language untuk format referensi
├── media/
│   ├── image1.jpg        # Logo UGM (untuk sampul)
│   └── ...               # Gambar lainnya
├── pages/
│   ├── bab1.typ          # BAB I - Pendahuluan
│   ├── bab2.typ          # BAB II - Tinjauan Pustaka
│   ├── bab3.typ          # BAB III - Metodologi
│   ├── bab4.typ          # BAB IV - Hasil dan Pembahasan
│   ├── bab5.typ          # BAB V - Kesimpulan
│   └── bab6.typ          # BAB VI - Penutup (opsional)
└── data/
    └── summary.json      # Data hasil eksperimen (opsional)
```

---

## Cara Penggunaan

### 1. Konfigurasi Metadata

Buka `main.typ` dan ubah parameter-parameter berikut sesuai data Anda:

```typst
#show: doc => conf(
  judul: [Judul Bahasa Indonesia],
  judul-english: [Judul Bahasa Inggris],
  nama: "Nama Mahasiswa",
  nim: "NIM Mahasiswa",
  prodi: "Ilmu Komputer",
  departemen: "Ilmu Komputer dan Elektronika",
  fakultas: "Matematika dan Ilmu Pengetahuan Alam",
  tahun: "2025",
  tgl-pengesahan: "16 Juli 2025",
  tgl-pernyataan: "22 Maret 2026",
  ttd-pernyataan: none,  // atau path ke file tanda tangan, e.g., "media/ttd.png"
  intisari: [Isi intisari...],
  abstract: [Isi abstract...],
  doc,
)
```

### 2. Menambahkan Akronim

Di `main.typ`, tambahkan singkatan yang Anda gunakan dalam daftar `init-acronyms`:

```typst
#init-acronyms((
  "ABC": ([_Artificial Bee Colony_],),
  "PSO": ([_Particle Swarm Optimization_],),
))
```

Gunakan di dalam teks dengan `#acr("ABC")` untuk singkatan pertama (dengan penjelasan), dan `#acs("ABC")` untuk singkatan selanjutnya.

### 3. Menulis Bab

Setiap bab ditulis di file terpisah dalam folder `pages/`:

- `bab1.typ` — Pendahuluan
- `bab2.typ` — Tinjauan Pustaka
- `bab3.typ` — Metodologi Penelitian
- `bab4.typ` — Hasil dan Pembahasan
- `bab5.typ` — Kesimpulan dan Saran
- `bab6.typ` — Bab tambahan jika diperlukan

Contoh struktur bab:

```typst
#import "../conf.typ": noindent, cite_year
#import "@preview/acrostiche:0.5.2": *

#reset-all-acronyms() // hanya untuk bab pertama, agar singkatan muncul dengan penjelasan

= PENDAHULUAN

== Latar Belakang
Isi latar belakang penelitian...

== Perumusan Masalah
Berdasarkan latar belakang...

== Batasan Penelitian
Penelitian ini dibatasi pada...

== Tujuan Penelitian
Tujuan dari penelitian ini adalah...

== Manfaat Penelitian
Manfaat dari penelitian ini adalah...

#pagebreak()
```

### 4. Referensi dan Kutipan

Gunakan `@key` untuk kutipan standar. Format tambahan:

```typst
// Kutipan standar — render: (Goodfellow et al., 2016)
@goodfellow2016deep

// Multi kutipan standar — cukup tambahkan @key berikutnya
@goodfellow2016deep @ruder2016overview
// render: (Goodfellow et al., 2016; Ruder, 2016)

// Kutipan dalam prosa — render: Goodfellow et al. (2016)
#cite_prose(<goodfellow2016deep>)

// Kutipan tahun saja — render: (2016)
#cite_year(<goodfellow2016deep>)

// Menerima banyak referensi sekaligus
#cite_prose(<goodfellow2016deep>, <ruder2016overview>)
// render: Goodfellow et al. (2016); Ruder (2016)

#cite_year(<goodfellow2016deep>, <ruder2016overview>)
// render: (2016, 2016)
```

Pastikan referensi sudah terdaftar di `bib.bib`.

### 5. Menambahkan Gambar, Tabel, dan Persamaan

**Gambar:**
```typst
#figure(
  image("media/gambar-saya.png", width: 8cm),
  caption: [Keterangan gambar],
) <label-gambar>
```

**Tabel:**
```typst
#figure(
  table(
    columns: (auto, auto),
    table.header([Kolom 1], [Kolom 2]),
    [Data 1], [Data 2],
  ),
  caption: [Keterangan tabel],
) <label-tabel>
```

**Persamaan:**
```typst
$ E = m c^2 $ <label-persamaan>
```

**Pseudocode:**
```typst
#figure(
  kind: "pseudocode",
  caption: "Nama Algoritma",
  block(...)
) <label-pseudocode>
```

**Blok Kode:**
````typst
#figure(
  kind: raw,
  caption: "Kode Program",
  ```python
  def hello():
      print("Hello, World!")
  ```
) <label-kode>
````

### 6. Merujuk Gambar, Tabel, dan Persamaan

Rujuk objek secara langsung menggunakan nama label yang telah ditentukan. Typst akan otomatis menampilkan jenis objek beserta nomornya (misalnya *Gambar 3.1*, *Tabel 2.4*, *Persamaan 4.2*).

```typst
// Merujuk gambar
Arsitektur jaringan ditunjukkan pada @arsitektur-mlp.

// Merujuk tabel
Ringkasan skenario disajikan pada @skenario-evaluasi.

// Merujuk persamaan
Nilai energi dihitung menggunakan @energi.

// Merujuk pseudocode
Algoritma dijelaskan pada @reduction.

// Merujuk kode program
Implementasi ditunjukkan pada @trait_problem.
```

Untuk menghindari penomoran pada kalimat tertentu, bungkus dengan tanda kurung siku:

```typst
// Menampilkan hanya nomor, tanpa kata "Gambar"
Perbandingan pada [@arsitektur-mlp] menunjukkan ...
```

### 7. Compile Dokumen

```bash
typst compile main.typ
typst watch main.typ    # untuk auto-recompile saat file berubah
```

Atau jika menggunakan VS Code, install ekstensi [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist).

---

## Customisasi

### Mengubah Margin

Edit bagian `set page` di `conf.typ`:

```typst
set page(
  paper: "a4",
  margin: (
    top: 4cm,
    bottom: 3cm,
    left: 4cm,
    right: 3cm,
  ),
)
```

### Mengubah Font

Default menggunakan Times New Roman. Ubah di `conf.typ`:

```typst
set text(font: "Times New Roman", size: 12pt, hyphenate: false)
```

### Menambahkan Bab Baru

1. Buat file baru di `pages/bab7.typ`
2. Tambahkan `#include "./pages/bab7.typ"` di `main.typ`

### Menonaktifkan Daftar Tertentu

Edit bagian `daftar` di `conf.typ` dan hapus atau komentari daftar yang tidak diperlukan.

---

## Fungsi Helper

File `conf.typ` menyediakan beberapa helper yang bisa digunakan di bab:

| Fungsi | Kegunaan |
|--------|----------|
| `#cite_prose(<key1>, <key2>, ...)` | Kutipan prosa — render: `Author et al. (2016)` |
| `#cite_year(<key1>, <key2>, ...)` | Kutipan tahun saja — render: `(2016)` |
| `#noindent[...]` | Blok teks tanpa indentasi pertama |
| `#title-case(string)` | Mengubah string menjadi Title Case |
| `#to-string(it)` | Mengkonversi content ke string |

---

## Catatan Penting

- **Logo UGM**: Pastikan file `media/image1.jpg` tersedia untuk sampul dan halaman judul. Ganti dengan logo resmi dari fakultas Anda jika diperlukan.
- **Tanda Tangan**: Untuk halaman pernyataan, Anda bisa mengganti `ttd-pernyataan: none` dengan path gambar tanda tangan, misalnya `"media/ttd.png"`.
- **Format Referensi**: File `dkk.csl` disediakan sebagai starting point. Sesuaikan dengan format referensi yang disyaratkan program studi Anda.
- **PDF Guidelines**: File `PEDOMAN TUGAS AKHIR PRODI SARJANA DIKE 2025.pdf` disertakan sebagai referensi pedoman. Pastikan untuk menyesuaikan template dengan pedoman terbaru.

---

## Kontribusi

Kontribusi sangat terbuka! Jika Anda menemukan bug, inkonsistensi format, atau ingin menambahkan fitur, silakan buat issue atau pull request.

## Lisensi

Template ini dirilis secara terbuka untuk digunakan, dimodifikasi, dan didistribusikan. Harap tetap menyertakan atribusi jika menggunakan template ini sebagai dasar karya Anda.

---

**Selamat menulis tugas akhir! Semoga lancar sampai wisuda.**

---

<!-- Generated PDF Preview -->
## Preview

<table style="border-collapse: collapse; border: none;">
<tr><td align="center" style="border: none;"><img src="./docs/page-01.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-02.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-03.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-04.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-05.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-06.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-07.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-08.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-09.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-10.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-11.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-12.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-13.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-14.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-15.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-16.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-17.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-18.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-19.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-20.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-21.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-22.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-23.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-24.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-25.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-26.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-27.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-28.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-29.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-30.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-31.png" width="100%" /></td><td align="center" style="border: none;"><img src="./docs/page-32.png" width="100%" /></td></tr>
<tr><td align="center" style="border: none;"><img src="./docs/page-33.png" width="100%" /></td><td align="center" style="border: none;"></td></tr>
</table>

