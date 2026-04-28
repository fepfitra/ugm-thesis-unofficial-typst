#import "../conf.typ": noindent
#import "@preview/acrostiche:0.5.2": *
#import "@preview/cetz:0.4.0": canvas, draw
#import "../plots.typ": *

= HASIL DAN PEMBAHASAN

== Skenario Eksperimen

=== _Hyperparameter_ algoritma

== Hasil Pengujian #acr("JST")

#lorem(100)



== Pembahasan

== Hasil Validasi Moré-Garbow-Hillstrom


=== Akurasi

Akurasi diukur berdasarkan jarak absolut antara nilai _loss_ akhir yang ditemukan algoritma dengan nilai minimum global yang diketahui, yaitu $|f(x) - f^*|$. @tbl:mgh-akurasi menyajikan ringkasan akurasi pada 13 fungsi MGH. Sel berwarna merah menandakan kegagalan konvergensi (mencapai batas 10.000 iterasi).

// bikin tabel tapi ngoding boss wkwkwkwkwk

#let fail = red.lighten(80%)
#let best = green.lighten(80%)
#let max_iter = 10000
#let data = json("../data/summary.json").summary
#let optimizers = (
  "Adaptive Nelder-Mead (ANMS)",
  "Chebyshev Nelder-Mead (CSPNM)",
  "Two-Stages Interpolated Nelder-Mead (TSINM)",
  "Two-Stages Interpolated Nelder-Mead - Chebyshev (TSINM-Cheb)",
)

#let problem_names = ()
#for row in data {
  if row.problem not in problem_names {
    problem_names.push(row.problem)
  }
}

#let format-sci(val) = {
  if type(val) != float { val = float(val) }
  if val == 0.0 [ $0$ ] else {
    let exponent = calc.floor(calc.log(val, base: 10))
    if exponent < -2 or exponent >= 4 {
      let mantissa = val / calc.pow(10.0, float(exponent))
      let m_val = calc.round(mantissa, digits: 2)
      let m_str = str(m_val).replace(".", ",")
      if not "," in m_str { m_str = m_str + ",00" } else if m_str.split(",").at(1).len() == 1 { m_str = m_str + "0" }
      [$#m_str times 10^(#exponent)$]
    } else {
      let v_val = calc.round(val, digits: 2)
      let v_str = str(v_val).replace(".", ",")
      if not "," in v_str { v_str = v_str + ",00" } else if v_str.split(",").at(1).len() == 1 { v_str = v_str + "0" }
      [$#v_str$]
    }
  }
}

#let format-ms(t_ms) = {
  if t_ms < 0.1 {
    let r_ms = calc.round(t_ms * 100)
    let r_ms_str = str(r_ms)
    if r_ms < 10 { r_ms_str = "0" + r_ms_str }
    "0," + r_ms_str
  } else {
    let val = calc.round(t_ms, digits: 2)
    let s = str(val).replace(".", ",")
    if not "," in s {
      s + ",00"
    } else if s.split(",").at(1).len() == 1 {
      s + "0"
    } else {
      s
    }
  }
}

#let akurasi_rows = ()
#let konv_rows = ()

#for p in problem_names {
  let p_data = data.filter(d => d.problem == p)
  let known_min = p_data.at(0).known_minimum
  let dim = p_data.at(0).dimension
  let min_val_str = format-sci(known_min)

  if p == "Brown and Dennis" {
    min_val_str = [$approx 8","58 times 10^4$]
  } else if p == "Gaussian" {
    min_val_str = [$approx 1","13 times 10^(-8)$]
  }

  // Akurasi Row
  let p_name_str = p
  if p == "Brown and Dennis" { p_name_str = "Brown dan Dennis" } else if p == "Extended Powell Singular" {
    p_name_str = "Ext. Powell Sing."
  } else if p == "Extended Rosenbrock" { p_name_str = "Ext. Rosenbrock" } else if p == "Powell Badly Scaled" {
    p_name_str = "Powell Bad. Sc."
  } else if p == "Variably Dimensioned" { p_name_str = "Variably Dim." }

  let acc_row = ([ #p_name_str ], min_val_str)
  let accs = ()
  let acc_iters = ()
  for opt in optimizers {
    let opt_data = p_data.find(d => d.optimizer == opt)
    if opt_data != none {
      let loss = opt_data.loss
      let acc = calc.abs(loss - known_min)
      accs.push(acc)
      acc_iters.push(opt_data.iterations)
    } else {
      accs.push(999999.0)
      acc_iters.push(0)
    }
  }

  // Find best accuracy among converged methods
  let best_acc = 999999.0
  for i in range(accs.len()) {
    if acc_iters.at(i) < max_iter and accs.at(i) < best_acc {
      best_acc = accs.at(i)
    }
  }
  for i in range(accs.len()) {
    let acc = accs.at(i)
    let iter = acc_iters.at(i)
    let cell_content = format-sci(acc)

    if iter >= max_iter {
      acc_row.push(table.cell(fill: fail)[#cell_content])
    } else if acc == best_acc {
      acc_row.push(table.cell(fill: best)[#cell_content])
    } else {
      acc_row.push(cell_content)
    }
  }
  akurasi_rows.push(acc_row)

  // Konvergensi Row
  let konv_row = ([ #p (#dim) ],)
  let iters_list = ()
  let times_list = ()
  for opt in optimizers {
    let opt_data = p_data.find(d => d.optimizer == opt)
    if opt_data != none {
      iters_list.push(opt_data.iterations)
      times_list.push(opt_data.time_mean_ms)
    } else {
      iters_list.push(999999)
      times_list.push(999999.0)
    }
  }
  // Find best time (only among converged methods)
  let converged_times_rounded = ()
  for i in range(iters_list.len()) {
    if iters_list.at(i) < max_iter {
      converged_times_rounded.push(calc.round(times_list.at(i), digits: 2))
    } else {
      converged_times_rounded.push(999999.0)
    }
  }
  let best_time_rounded = calc.min(..converged_times_rounded)

  for i in range(optimizers.len()) {
    let opt = optimizers.at(i)
    let opt_data = p_data.find(d => d.optimizer == opt)
    if opt_data != none {
      let iters = opt_data.iterations
      let t_ms = opt_data.time_mean_ms
      let t_str = format-ms(t_ms)

      if iters >= max_iter {
        konv_row.push(table.cell(fill: fail)[#t_str])
      } else {
        if calc.round(t_ms, digits: 2) == best_time_rounded {
          konv_row.push(table.cell(fill: best)[#t_str])
        } else {
          konv_row.push(t_str)
        }
      }
    } else {
      konv_row.push("-")
    }
  }
  konv_rows.push(konv_row)
}

#figure(
  text(size: 9pt, table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 6pt,
    align: (left, right, right, right, right, right),
    stroke: 0.5pt,
    table.header([*Fungsi*], [*$f^*$*], [*ANMS*], [*CSP-NM*], [*MyMethod-A*], [*MyMethod-C*]),
    ..akurasi_rows.flatten(),
  )),
  caption: [Perbandingan akurasi ($|f(x) - f^*|$) pada 13 fungsi MGH. Kolom $f^*$ menunjukkan nilai minimum global yang diketahui. Sel merah menandakan kegagalan konvergensi. Sel hijau menandakan akurasi terbaik],
) <mgh-akurasi>


=== Analisis visual konvergensi


== Sintesis Hasil Pengujian

#pagebreak()
