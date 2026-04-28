#import "conf.typ": conf
#import "@preview/acrostiche:0.5.2": *

#init-acronyms((
  "ABC": ([_Artificial Bee Colony_],),
  "Adam": ([_Adaptive Moment Estimation_],),
  "ANMS": ([_Adaptive Nelder-Mead Simplex_],),
  "ASA": ([_Automatic Suspension Arm_],),
  "BS": ([_Belleville Spring_],),
  "CLPSO": ([_Comprehensive Learning Particle Swarm Optimization_],),
  "COWBR": ([_Coupling with Bolted Rim_],),
  "CSP-NM": ([_Chebyshev Spacing Points Nelder Mead_],),
  "DHNM": ([_Dynamic Hasan Nelder-Mead_],),
  "GD": ([_Gradient Descent_],),
  "GNM": ([_Genetic Nelder-Mead_],),
  "GWO": ([_Grey Wolf Optimizer_],),
  "HINFO-NM": ([_Hybrid In-Formed Optimizer - Nelder-Mead_],),
  "INFO": ([_In-Formed Optimizer_],),
  "TSINM": ([_Two-Stage Interpolated Nelder-Mead_],),
  "NM-POSTA": ([_Nelder Mead - Parameter Optimal State Transition Algorithm_],),
  "JST": ([_Jaringan Saraf Tiruan_],),
  "NMQI-POSTA": ([_Nelder Mead Quadratic Interpolation - Parameter Optimal State Transition Algorithm_],),
  "NQI": ([_Newton Quadratic Interpolation_],),
  "POSTA": ([_Parameter Optimal State Transition Algorithm_],),
  "PSO": ([_Particle Swarm Optimization_],),
  "PSO-NMS": ([_Particle Swarm Optimization-Nelder Mead Simplex_],),
  "PV": ([_Pressure Vessel_],),
  "QI": ([_Quadratic Interpolation_],),
  "QI-POSTA": ([_Quadratic Interpolation - Parameter Optimal State Transition Algorithm_],),
  "SNMS": ([_Standard Nelder-Mead Simplex_],),
  "SaDE": ([_Self-adaptive Differential Evolution_],),
  "WB": ([_Welded Beam_],),
  "AODM": ([_Aspect Oriented Design Model_],),
  "AOP": ([_Aspect Oriented Programming_],),
  "UML": ([_Unified Modeling Language_],),
))

#show: doc => conf(
  judul: [Judul Bahasa Indonesia],
  judul-english: [Juidul Bahasa Inggris],
  nama: "Nama Mahasiswa",
  nim: "NIM Mahasiswa",
  prodi: "Ilmu Komputer",
  departemen: "Ilmu Komputer dan Elektronika",
  fakultas: "Matematika dan Ilmu Pengetahuan Alam",
  tahun: "2025",
  tgl-pengesahan: "16 Juli 2025",
  tgl-pernyataan: "22 Maret 2026",
  ttd-pernyataan: none,
  intisari: [
    Pada umumnya sistem perangkat lunak terdiri dari beberapa concern, premis dari masalah ini adalah sebaran concern, di mana kebutuhan rancangan tertentu cenderung memotong- melintasi grup inti fungsional modul. Teknik orientasi-objek yang menerapkan concern tersebut cenderung menghasilkan kode yang tersebar, daya baca yang sulit, serta susah untuk dikembangkan. Metodologi baru, #acr("AOP"), memberikan fasilitas modularisasi pemotong-lintasan/cross-cutting concern. Dengan menggunakan AOP, terdapat cara untuk membuat penerapan sistem yang lebih mudah untuk dirancang, dipahami, dan dipelihara. Lebih jauh lagi, AOP menjanjikan produktivitas yang lebih tinggi, peningkatan kualitas, dan kemampuan lebih baik untuk menambahkan feature baru.

    AspectJ adalah bahasa pemrograman yang digunakan secara luas untuk menerapkan program-program berorientasi aspek di Java. Namun demikian, AspectJ masih belum memiliki bahasa pemodelan yang dapat memenuhi perancangan program berorientasi aspek. #acr("AODM"), sebagai sebuah model perancangan baru pada pengembangan program dalam AspectJ, hanya memperluas konsep-konsep #acr("UML") yang telah ada dengan menggunakan mekanisme perluasan #acr("UML") untuk memberikan konsep orientasi-aspek yang ada di dalam AspectJ. AODM menyediakan spesikasi model rancangan orientasi-aspek untuk ditransformasikan menjadi model rancangan #acr("UML") biasa.
  ],
  abstract: [
    Most software systems consist several concerns, the premise of such thing is separation of concerns, where certain design requirements tend to cut across group of core functional modules. Object-oriented techniques for implementing such concerns result in systems that are invasive to implement, tough to understand, and difficult to evolve. The new aspect-oriented programming (AOP) methodology facilities modularization of crosscutting concerns. Using AOP, there is a way to create implementations that are easier to design, understand, and maintain. Further, AOP promises higher productivity, improved quality, and better ability to implement newer features.

    AspectJ is a well-established programming language that is widely used to implement aspect-oriented programs in Java. However, there is no modeling language available for the design aspect oriented programs in AspectJ. Aspect Oriented Design Model (AODM), as a new design model for development of AspectJ programs, extends existing UML (Unified Modeling Language) concepts using standard UML extension mechanisms to provide aspect-oriented concepts as in AspectJ. The AODM species how an aspect-oriented design model maybe transformed into an ordinary UML design model.
  ],
  prakata: [
    Segala puji dan syukur penulis panjatkan ke hadirat Allah SWT atas segala rahmat dan karunia-Nya sehingga penulis dapat menyelesaikan tugas akhir ini. Shalawat serta salam senantiasa tercurahkan kepada Nabi Muhammad SAW yang telah membimbing umat menuju jalan kebenaran.

    Penulis menyadari bahwa penyelesaian tugas akhir ini tidak terlepas dari dukungan dan bantuan berbagai pihak. Oleh karena itu, dengan segala kerendahan hati, penulis menyampaikan ucapan terima kasih kepada:

    + #lorem(20)
    + #lorem(20)
    + #lorem(20)
    + #lorem(20)
    + #lorem(20)

    Penulis menyadari bahwa tugas akhir ini masih jauh dari sempurna. Oleh karena itu, kritik dan saran yang membangun sangat penulis harapkan demi perbaikan di masa mendatang. Semoga tugas akhir ini dapat memberikan manfaat bagi perkembangan ilmu pengetahuan.
  ],
  doc,
)

//Citation hack
// #show " and ": " dan "

#include "./pages/bab1.typ"
#include "./pages/bab2.typ"
#include "./pages/bab3.typ"
#include "./pages/bab4.typ"
#include "./pages/bab5.typ"
#include "./pages/bab6.typ"

#set par(spacing: 1.565em, hanging-indent: 8em, leading: 0.65em)
#bibliography(
  "./bib.bib",
  title: "DAFTAR PUSTAKA",
  // style: "harvard-cite-them-right",
  style: "./dkk.csl",
  // full: true,
)


