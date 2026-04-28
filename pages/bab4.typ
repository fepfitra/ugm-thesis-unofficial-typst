#import "../conf.typ": noindent
#import "@preview/acrostiche:0.5.2": *
#import "@preview/cetz:0.4.0"
#import "@preview/cetz:0.4.0": canvas, draw

= IMPLEMENTASI


== Lingkungan Implementasi


=== Perangkat keras

=== Perangkat lunak

== Arsitektur Program


=== Modul algoritma inti (`optimization`)

=== Modul masalah (`problem`)
=== _Suite_ pengujian dan analisis (`runners` dan `results`)

== Kerangka Implementasi Eksperimen

=== Abstraksi masalah (`Problem` _trait_)

Modul `problem` mendefinisikan Trait `Problem` yang harus dipenuhi oleh setiap fungsi objektif. Seluruh fungsi uji MGH dari pustaka `mgh` serta model Jaringan Saraf Tiruan diimplementasikan sebagai tipe data yang memenuhi struktur ini, seperti yang ditunjukkan pada @lst:trait_problem. Modul ini berperan sebagai lapisan abstraksi agar algoritma optimasi dapat bekerja pada berbagai jenis masalah tanpa terikat pada detail implementasi fungsi objektif tertentu.

#figure(
  caption: "Definisi trait Problem untuk injeksi masalah",
  ```rust
  pub trait Problem: Sync + Send {
      fn evaluate(&self, params: &Array1<f64>) -> f64;
      fn get_initial_params(&self) -> Array1<f64>;
      fn get_param_dimension(&self) -> usize;
      fn get_minimum_params(&self) -> Option<Array1<f64>>;
      fn get_minimum_value(&self) -> Option<f64>;
  }
  ```,
)<trait_problem>

=== Abstraksi algoritma inti (`OptimizerDF` dan `OptimizerG`)

=== Abstraksi konfigurasi eksperimen


==== 1. Strategi parameter

==== 2. Kriteria penghentian

==== 3. Inisialisasi simpleks

=== Jaringan saraf tiruan (JST)

== Implementasi Algoritma Usulan (Nganu)


#pagebreak()
