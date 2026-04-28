#import "../conf.typ": noindent
#import "@preview/acrostiche:0.5.2": *
#import "@preview/cetz:0.4.0"
#import "@preview/cetz-plot:0.1.2"

#let ebody(content) = [
  #let indent = 1.066em
  #set par(first-line-indent: (amount: indent, all: true), hanging-indent: indent)
  #content
]

#let iebody(content) = [
  #let indent = 1.066em
  #set par(first-line-indent: (amount: indent + 3em, all: true), hanging-indent: indent)
  #content
]

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

= Metodologi Penelitian

== Tahapan Penelitian

#noindent[Penelitian ini dilaksanakan dalam tiga tahapan utama:]

1. *Pengumpulan Data*: #lorem(20)

2. *Rancangan Metode*: #lorem(20)

3. *Evaluasi*: #lorem(20)

  Ringkasan kedua skenario disajikan pada @tbl:skenario-evaluasi.

  #figure(
    text(size: 9pt, table(
      columns: (auto, auto, auto),
      inset: 6pt,
      align: (left, left, left),
      stroke: 0.5pt,
      table.header([*Aspek*], [*Skenario 1 (Validasi Numerik)*], [*Skenario 2 (Pelatihan JST)*]),
      [Fungsi uji], [13 fungsi MGH ($n = 2$ s.d. $20$)], [California Housing ($n = 161$)],
      [Algoritma], [...], [...],
      [Kriteria henti], [$|f(x) - f^*| < 10^(-6)$ atau 10.000 iterasi], [Jumlah iterasi tetap (2.000)],
      [Jumlah _seed_], [30], [30],
      [Metrik], [Akurasi ($|f(x) - f^*|$), waktu konvergensi], [_Loss_ akhir (MSE), standar deviasi],
    )),
    caption: [Ringkasan skenario evaluasi],
  ) <skenario-evaluasi>

Fungsi Reduction (@pseudocode:reduction) merupakan operasi _shrink_ yang menyusutkan seluruh simplex ke arah titik terbaik $x_1$. Operasi ini dipanggil sebagai _fallback_ terakhir ketika kontraksi gagal memperbaiki simplex, di mana seluruh verteks kecuali $x_1$ dipindahkan mendekati $x_1$ dengan faktor $delta$.

#figure(
  kind: "pseudocode",
  caption: "Fungsi Reduction",
  block(fill: luma(245), stroke: 0.5pt, inset: 10pt, radius: 4pt, width: 100%)[
    #set align(left)
    #set text(size: 10pt)
    #table(
      columns: (auto, 1fr),
      stroke: none,
      inset: (x: 0.3em, y: 0.4em),
      [], [*function* Reduction$(S)$],
      [1:], [#h(1em) *for* $i = 2$ *to* $D+1$ *do*],
      [2:], [#h(2em) $x_i arrow.l x_1 + delta(x_i - x_1)$],
      [3:], [#h(1em) *end for*],
      [4:], [*end function*],
    )
  ],
)<reduction>

=== Langkah inisialisasi
Pada langkah inisialisasi, simpleks awal dibentuk dengan memilih $n+1$ titik awal $x_1, x_2, ..., x_(n+1)$ yang tersebar di ruang solusi. Sebagai contoh, tiga titik dibuat di ruang dua dimensi membentuk simpleks segitiga seperti pada gambar @fig:initiation. Titik-titik ini dapat dipilih secara acak atau berdasarkan aturan tertentu. Semua titik dievaluasi dengan fungsi objektif $f$ untuk mendapatkan nilai $f(x_1), f(x_2), ..., f(x_(n+1))$. Titik-titik ini digunakan sebagai titik awal untuk iterasi algoritma.

#align(center)[
  #figure(
    caption: "Inisiasi simpleks di dua dimensi",
    cetz.canvas({
      import cetz.draw: *

      circle((4, 0), radius: 0.1, fill: blue)
      circle((4, 4), radius: 0.1, fill: blue)
      circle((1, 2), radius: 0.1, fill: blue)

      line((4, 0), (4, 4))
      line((4, 4), (1, 2))
      line((1, 2), (4, 0))
    }),
  )<initiation>
]


#noindent[
  di mana $f_(x_r, x_e) = frac(f_e-f_r, beta_e-beta_r)$. Pembatasan nilai $beta_"ex"$ dilakukan agar simpleks tidak bergerak secara liar: jika $beta_"ex"$ tidak finit, digunakan $beta$ sebagai _fallback_; kemudian nilainya dibatasi ke rentang $[beta, b_"max"]$ dengan $b_"max"$ adalah batas atas yang ditentukan sebelumnya, sehingga
]
$
  beta_"ex" & = cases(
                beta & "jika" beta_"ex" "tidak finit",
                beta_"ex" & "jika" beta <= beta_"ex" <= b_"max",
                beta & "jika" beta_"ex" < beta,
                b_"max" & "jika" beta_"ex" > b_"max"
              ) \
$

== Data


== Rancangan Pengujian dan Analisis


=== Metrik pengujian

=== Fungsi uji


#noindent[
  Berikut adalah fungsi-fungsi yang digunakan dalam pengujian:
]

+ *Fungsi Beale @beale1958iterative*
  // (unconstrained)

  Fungsi ini adalah tolok ukur klasik untuk optimasi yang _unconstrained_. Tantangan utamanya terletak pada "lembah melengkung yang sempit" dengan "ketajaman ekstrem." Algoritma optimasi umumnya dapat dengan mudah memasuki lembah tersebut tetapi mungkin kesulitan menemukan nilai minimum karena non-linearitas yang signifikan. Strukturnya adalah jumlah dari tiga suku kuadrat.

  - *Formula*:
  $
    f(x) = & (1.5 - x_1 (1 - x_2))^2 \
           & + (2.25 - x_1 (1 - x_2^2))^2 \
           & + (2.625 - x_1(1-x_2^3))^2
  $
  - *Aproksimasi awal*: $x_0 = (1,1)$
  - *Global minimal*: $f(x) = 0 "pada" x=(3 ; 0","5)$


== Skenario Pengujian: Pelatihan #acr("JST")

Selain fungsi matematika, algoritma diuji untuk mengoptimasi bobot #acr("JST") pada masalah regresi.

=== Arsitektur jaringan
Arsitektur jaringan yang digunakan dalam pengujian ditunjukkan pada @fig:arsitektur-mlp, dengan rincian sebagai berikut:
- *Input Layer*: 8 neuron (sesuai fitur California Housing: Longitude, Latitude, dll).
- *Hidden Layer*: 16 neuron (Aktivasi Sigmoid).
- *Output Layer*: 1 neuron (Prediksi harga rumah).
- *Total Parameter (Dimensi)*: $(8 times 16) + 16 ("bias") + (16 times 1) + 1 ("bias") = 161$ dimensi.

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let layer-gap = 3.5
    let input-n = 8
    let hidden-n = 16
    let output-n = 1

    // Posisi vertikal untuk setiap layer (dicentering)
    let input-ys = range(input-n).map(i => (input-n - 1) / 2 - i)
    let hidden-ys = range(hidden-n).map(i => (hidden-n - 1) / 2 - i)
    let output-ys = range(output-n).map(i => (output-n - 1) / 2 - i)

    // Scale vertikal agar hidden layer tidak terlalu besar
    let input-scale = 0.7
    let hidden-scale = 0.42
    let output-scale = 1.0

    let input-x = 0
    let hidden-x = layer-gap
    let output-x = 2 * layer-gap

    let r = 0.22

    // Koneksi input → hidden (warna abu-abu tipis)
    for i in range(input-n) {
      for j in range(hidden-n) {
        line(
          (input-x + r, input-ys.at(i) * input-scale),
          (hidden-x - r, hidden-ys.at(j) * hidden-scale),
          stroke: rgb("#cccccc") + 0.3pt,
        )
      }
    }

    // Koneksi hidden → output
    for j in range(hidden-n) {
      line(
        (hidden-x + r, hidden-ys.at(j) * hidden-scale),
        (output-x - r, output-ys.at(0) * output-scale),
        stroke: rgb("#cccccc") + 0.3pt,
      )
    }

    // Input neurons
    for i in range(input-n) {
      circle((input-x, input-ys.at(i) * input-scale), radius: r, fill: rgb("#4A90D9"), stroke: 0.6pt)
    }

    // Hidden neurons
    for j in range(hidden-n) {
      circle((hidden-x, hidden-ys.at(j) * hidden-scale), radius: r, fill: rgb("#F5A623"), stroke: 0.6pt)
    }

    // Output neuron
    circle((output-x, 0), radius: r, fill: rgb("#7ED321"), stroke: 0.6pt)

    // Bias indicators (panah ke layer)
    let bias-offset = 1.2
    // Bias → hidden
    line(
      (hidden-x, (hidden-n - 1) / 2 * hidden-scale + bias-offset),
      (hidden-x, (hidden-n - 1) / 2 * hidden-scale + r + 0.15),
      mark: (end: "stealth", fill: black, scale: 0.5),
      stroke: 0.8pt,
    )
    content((hidden-x, (hidden-n - 1) / 2 * hidden-scale + bias-offset + 0.25), text(size: 7pt)[+bias])
    // Bias → output
    line(
      (output-x, bias-offset),
      (output-x, r + 0.15),
      mark: (end: "stealth", fill: black, scale: 0.5),
      stroke: 0.8pt,
    )
    content((output-x, bias-offset + 0.25), text(size: 7pt)[+bias])

    // Labels
    content((input-x, -(input-n - 1) / 2 * input-scale - 0.7), text(size: 8pt)[*Input* (8)])
    content((hidden-x, -(hidden-n - 1) / 2 * hidden-scale - 0.7), text(size: 8pt)[*Hidden* (16)])
    content((output-x, -0.7 - 0.3), text(size: 8pt)[*Output* (1)])
  }),
  caption: [Arsitektur _Multi-Layer Perceptron_ (MLP) dengan struktur $8 arrow 16 arrow 1$ dan total 161 parameter yang dioptimasi],
) <arsitektur-mlp>

=== _Dataset_
Pengujian menggunakan *California Housing _Dataset_* @pace1997sparse yang memuat 20.640 sampel data sensus. Data dinormalisasi menggunakan teknik Min-Max Scaling untuk mempercepat konvergensi.

=== Algoritma pembanding
+ #lorem(30)
+ #lorem(30)
+ #lorem(30)
+ #lorem(30)

#pagebreak()
