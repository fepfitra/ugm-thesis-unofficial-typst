#import "@preview/i-figured:0.2.4"
#import "@preview/acrostiche:0.5.2": *

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let title-case(string) = {
  return string.replace(
    regex("[A-Za-z]+('[A-Za-z]+)?"),
    word => upper(word.text.first()) + lower(word.text.slice(1)),
  )
}

#let sampul-luar(
  judul: "JUDUL BAHASA INDONESIA",
  judul-english: "JUDUL BAHASA INGGRIS",
  nama: "NAMA MAHASISWA",
  nim: "NIM",
  prodi: "PROGRAM STUDI",
  fakultas: "FAKULTAS",
  departemen: "DEPARTEMEN",
  tahun: "Tahun",
) = {
  align(center)[
    *SKRIPSI*\ \ \
    *#upper(judul)*\ \
    #emph[*#upper(judul-english)*]
    #v(3.5em)
    #image("media/image1.jpg", width: 5.5cm, height: 5.5cm)
    #v(3.5em)

    #upper(nama)

    #nim

    #v(3.5em)

    *PROGRAM STUDI #upper(prodi)*\
    *DEPARTEMEN #upper(departemen)*\
    *FAKULTAS #upper(fakultas)*\
    *UNIVERSITAS GADJAH MADA*\
    *YOGYAKARTA*
    #v(1em)
    *#tahun*
    #pagebreak()
  ]
}

#let halaman-judul(
  judul: "JUDUL BAHASA INDONESIA",
  judul-english: "JUDUL BAHASA INGGRIS",
  nama: "NAMA MAHASISWA",
  nim: "NIM",
  prodi: "PROGRAM STUDI",
  departemen: "DEPARTEMEN",
  fakultas: "FAKULTAS",
  tahun: "Tahun",
) = {
  align(center)[
    *SKRIPSI*\ \ \
    *#judul*\ \
    #emph[*#judul-english*]
    #v(2.5em)
    Diajukan untuk memenuhi salah satu syarat memperoleh derajat\
    Sarjana #title-case(prodi)
    #v(2.5em)
    #image("media/image1.jpg", width: 5.5cm, height: 5.5cm)
    #v(2.5em)

    #upper(nama)

    #nim

    #v(2.5em)

    *PROGRAM STUDI #upper(prodi)*\
    *DEPARTEMEN #upper(departemen)*\
    *FAKULTAS #upper(fakultas)*\
    *UNIVERSITAS GADJAH MADA*\
    *YOGYAKARTA*
    #v(1em)
    *#tahun*
    #pagebreak()
  ]
}

#let pengesahan(
  judul: "JUDUL BAHASA INDONESIA",
  nama: "NAMA MAHASISWA",
  nim: "NIM",
  tgl-pengesahan: "17 Agustus 1945",
) = {
  align(center)[
    = HALAMAN PENGESAHAN
    *SKRIPSI*\ \
    *#judul*\ \
    Telah dipersiapkan dan disusun oleh\
    #upper(nama)\
    #nim
    #v(2.5em)
    Telah dipertahankan di depan Tim Penguji\
    pada tanggal #tgl-pengesahan
    #v(2.5em)
    Susunan Tim Penguji:

    #let ttd-gap = [#v(6em)]
    #table(
      columns: (1fr, 1fr),
      stroke: none,
      [
        #ttd-gap
        Nama Pembimbing I\
        Pembimbing I/Penguji
      ],
      [
        #ttd-gap
        Nama Penguji I\
        Penguji
      ],

      [
        #ttd-gap
        Nama Pembimbing II\
        Pembimbing II/Penguji
      ],
      [
        #ttd-gap
        Nama Penguji II\
        Penguji
      ],

      [
        #ttd-gap
      ],
      [
        #ttd-gap
        Nama Penguji III\
        Penguji
      ],
    )
  ]
  pagebreak()
}

#let pernyataan(
  konten: [Dengan ini saya menyatakan bahwa tugas akhir ini tidak mengandung karya yang pernah diajukan untuk memperoleh gelar kesarjanaan di suatu perguruan tinggi, dan sepanjang pengetahuan saya juga tidak mengandung karya atau pendapat yang pernah ditulis atau diterbitkan oleh orang lain, kecuali yang secara tertulis diacu dalam naskah ini dan disebutkan dalam daftar pustaka.],
  tanggal: "17 Agustus 1945",
  nama: "NAMA MAHASISWA",
  ttd: none,
) = {
  align(center)[
    = PERNYATAAN
  ]
  konten
  v(2em)
  align(right)[
    Yogyakarta, #tanggal\
    #if ttd != none [
      #image(ttd, width: 2.5cm)
      #v(-1em)
    ] else {
      v(5em)
    }
    #title-case(nama)
  ]
  pagebreak()
}

#let prakata-gen(
  konten: [_Isi prakata belum diisi. Silakan tuliskan ucapan terima kasih kepada pembimbing, penguji, dan pihak-pihak yang terkait dalam penyelesaian tugas akhir._],
  tanggal: "17 Agustus 1945",
) = {
  align(center)[
    = PRAKATA
  ]
  konten
  // lorem(10)
  v(2em)
  align(right)[
    Yogyakarta, #tanggal\
    #v(3em)
    Penulis
  ]
  pagebreak()
}

#let daftar = [
  #set par(leading: 0.65em)
  = DAFTAR ISI

  #show outline.entry: it => {
    show linebreak: none
    it
  }
  #outline(title: none, indent: 1em, depth: 2)
  #pagebreak()

  = DAFTAR TABEL
  #i-figured.outline(target-kind: table, title: none)
  // #outline(target: figure.where(kind: table), title: none)
  #pagebreak()

  = DAFTAR GAMBAR
  #i-figured.outline(target-kind: image, title: none)
  // #outline(target: figure.where(kind: image), title: none)
  #pagebreak()

  = DAFTAR PERSAMAAN
  // #i-figured.outline(target-kind: math.equation, title: none)
  #outline(target: math.equation, title: none)
  #pagebreak()

  = DAFTAR PSEUDOCODE
  #i-figured.outline(target-kind: "pseudocode", title: none)
  #pagebreak()

  = DAFTAR KODE
  #i-figured.outline(target-kind: raw, title: none)
  #pagebreak()

  // = DAFTAR LAMBANG
  // #pagebreak()

  = DAFTAR SINGKATAN
  #print-index(title: none, delimiter: "", row-gutter: 1.065em)
  #pagebreak()
]

#let intisari-gen(
  judul: "Konsep dan Pemodelan Berorientasi-Aspek Menggunakan UML dalam AspectJ",
  nama: "Nama Mahasiswa",
  nim: "22/504395/PA/21696",
  konten: [
    #lorem(100)

    #lorem(100)],
) = [
  #align(center)[
    = INTISARI
    // #v(1em)
    *#judul*
    #v(1em)
    Oleh
    #v(1em)
    #nama #nim
    #v(1em)
  ]

  #set par(leading: 0.65em)
  #konten

  #set par(first-line-indent: 0pt, leading: 0.65em, spacing: 1.7em)
  *Kata kunci:* Optimasi Numerik, Nelder-Mead, Interpolasi Kuadratik Newton, Kontrol Parameter Adaptif, Kecepatan Konvergensi, Jaringan Saraf Tiruan.
  #pagebreak()
]

#let abstract-gen(
  title: "Aspect-Oriented Concepts and UML Modeling on AspectJ",
  name: "Nama Mahasiswa",
  nim: "22/504395/PA/21696",
  content: [
    #lorem(100)

    #lorem(100)],
) = [
  #align(center)[
    = #emph[ABSTRACT]
    // #v(1em)
    *#title*
    #v(1em)
    By
    #v(1em)
    #name #nim
    #v(1em)
  ]

  #set par(leading: 0.65em)
  #content

  #set par(first-line-indent: 0pt, leading: 0.65em, spacing: 1.7em)
  *Keywords:* Numerical Optimization, Nelder-Mead, Newton Quadratic Interpolation, Adaptive Parameter Control, Convergence Speed, Adaptive Nelder-Mead Simplex, Chebyshev Spacing Points Nelder-Mead.

  #pagebreak()
]


#let conf(
  judul: "JUDUL BAHASA INDONESIA",
  judul-english: "JUDUL BAHASA INGGRIS",
  nama: "NAMA MAHASISWA",
  nim: "NIM",
  prodi: "PROGRAM STUDI",
  departemen: "DEPARTEMEN",
  fakultas: "FAKULTAS",
  tahun: "Tahun",
  tgl-pengesahan: "17 Agustus 1945",
  tgl-pernyataan: "17 Agustus 1945",
  ttd-pernyataan: none,
  intisari: [
    #lorem(100)

    #lorem(100)
  ],
  abstract: [
    #lorem(100)

    #lorem(100)
  ],
  prakata: [
    #lorem(100)

    #lorem(100)
  ],
  doc,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 4cm,
      bottom: 3cm,
      left: 4cm,
      right: 3cm,
    ),
  )
  set text(font: "Times New Roman", size: 12pt, hyphenate: false)

  sampul-luar(
    judul: judul,
    judul-english: judul-english,
    nama: nama,
    nim: nim,
    prodi: prodi,
    departemen: departemen,
    fakultas: fakultas,
    tahun: tahun,
  )
  // #let leading = 1.5em
  // #let leading = leading - 0.75em // "Normalization"
  // #set block(spacing: leading)
  // #set par(leading: leading)

  set page(numbering: "i")
  set image(width: 8.84cm)
  set table(inset: 8pt)
  set math.equation(supplement: "Persamaan")
  show heading: set block(below: 1.13em)
  show heading.where(level: 1): set text(weight: "bold", size: 14pt)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set block(below: 1.5em)
  show heading.where(level: 1): it => {
    if it.numbering != none {
      [#counter(heading).display(it.numbering) \ #it.body]
    } else {
      it
    }
  }
  show heading.where(level: 2): set text(weight: "bold", size: 12pt)
  show figure.where(kind: image): set figure(supplement: "Gambar")
  show figure.where(kind: table): set figure(supplement: "Tabel")
  show heading: i-figured.reset-counters.with(extra-kinds: ("pseudocode",))
  show figure: i-figured.show-figure.with(extra-prefixes: ("pseudocode": "pseudocode:"))
  show math.equation: i-figured.show-equation
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure(supplement: "Kode")
  show figure.where(kind: "pseudocode"): set figure(supplement: [_Pseudocode_])

  show raw.where(block: true): it => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    set par(leading: 0.7em, spacing: 1.065em)
    block(
      width: 100%,
      stroke: 0.5pt,
      inset: 10pt,
      radius: 2pt,
      fill: white,
      align(left)[
        #it
      ],
    )
  }
  show raw.where(block: true): set text(size: 7pt)
  show figure.caption: c => [
    #set par(leading: 0.65em)
    #set text(weight: "bold")
    #show ":": ""
    #c
  ]
  show quote.where(block: true): set par(leading: 0.65em)

  counter(page).update(1)

  halaman-judul(
    judul: judul,
    judul-english: judul-english,
    nama: nama,
    nim: nim,
    prodi: prodi,
    departemen: departemen,
    fakultas: fakultas,
    tahun: tahun,
  )
  pengesahan(
    judul: judul,
    nama: nama,
    nim: nim,
    tgl-pengesahan: tgl-pengesahan,
  )

  set par(
    first-line-indent: (amount: 1.27cm, all: true),
    justify: true,
    leading: 1.065em,
    spacing: 1.065em,
  )

  pernyataan(
    tanggal: tgl-pernyataan,
    nama: nama,
    ttd: ttd-pernyataan,
  )

  prakata-gen(
    tanggal: tgl-pernyataan,
    konten: prakata,
  )

  daftar

  intisari-gen(
    judul: judul,
    nama: title-case(nama),
    nim: nim,
    konten: intisari,
  )
  abstract-gen(
    title: judul-english,
    name: title-case(nama),
    nim: nim,
    content: abstract,
  )
  counter(page).update(1)
  counter(heading).update(0)

  set page(
    numbering: "1",
    footer: context {
      let heading1s = query(heading.where(level: 1))
      let is-headingpage = heading1s.any(heading1 => heading1.location().page() == here().page())
      if is-headingpage {
        return align(center)[
          #counter(page).display()
        ]
      }
    },
    header: context {
      let heading1s = query(heading.where(level: 1))
      let is-headingpage = heading1s.any(heading1 => heading1.location().page() == here().page())
      if is-headingpage != true {
        return align(bottom + right)[
          #counter(page).display()
        ]
      }
    },
  )

  let bab(.., last) = "BAB " + numbering("I", last)

  set heading(
    numbering: (..numbers) => if numbers.pos().len() == 1 {
      return numbering(bab, ..numbers)
    } else if numbers.pos().len() == 2 {
      return numbering("1.1", ..numbers)
    } else {
      return none
    },
  )
  doc
}

#let cite_prose(..keys) = {
  let items = keys.pos().map(k => cite(k, form: "prose"))
  items.join("; ")
}

#let cite_year(..keys) = {
  let items = keys.pos().map(k => cite(k, form: "year"))
  [(#items.join(", "))]
}

#let noindent(content) = [
  #set par(first-line-indent: 0pt)
  #content
]
