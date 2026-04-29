#import "../conf.typ": cite_year, noindent
#import "@preview/acrostiche:0.5.2": *

= TINJAUAN PUSTAKA

#lorem(80)

#lorem(80)

#align(center)[
  #set text(size: 0.8em)
  #figure(
    table(
      inset: 5pt,
      columns: (auto, auto, auto, auto, auto, auto, auto),
      align: (
        horizon,
        left + horizon,
        right + horizon,
        right + horizon,
        right + horizon,
        right + horizon,
        right + horizon,
      ),
      table.header([*Fungsi Objektif*], [*Algoritma*], [*Best*], [*Mean*], [*Worst*], [*SD*], [*NFE*]),
      table.cell(rowspan: 3)[COWBR],
      [HINFO-NM],
      [3.48159],
      [3.50205],
      [3.51963],
      [0.01752],
      [5000],
      [BOA #cite_year(<yildiz2022enhanced>)],
      [3.48159],
      [3.84077],
      [4.54158],
      [0.23283],
      [5000],
      [GA #cite_year(<gupta2021comparison>)],
      [3.8797],
      [-],
      [-],
      [0.0183],
      [5000],

      table.cell(
        rowspan: 5,
      )[BS],
      [HINFO-NM],
      [1.97967475],
      [1.9721369],
      [1.98236584],
      [1.1348E-02],
      [10,000],
      [ALO #cite_year(<yildiz2022new>)],
      [1.9835765],
      [2.1045097],
      [2.36855735],
      [9.4178E-02],
      [15,000],
      [ABC #cite_year(<yildiz2022new>)],
      [2.0334551],
      [2.16769704],
      [2.4028495],
      [7.5329E-02],
      [15,000],
      [CHHO #cite_year(<yildiz2020comparative>)],
      [1.9813],
      [-],
      [-],
      [-],
      [15,000],
      [HHO #cite_year(<yildiz2020comparative>)],
      [1.9801],
      [-],
      [-],
      [-],
      [15,000],

      table.cell(
        rowspan: 6,
      )[PV],
      [HINFO-NM],
      [6059.7143350],
      [6359.9863],
      [6561.5896],
      [126.532],
      [10,000],
      [MVO #cite_year(<yildiz2022new>)],
      [6068.5114941],
      [6465.6159],
      [7335.9735],
      [341.336],
      [25,000],
      [SSA #cite_year(<yildiz2022new>)],
      [6059.7144371],
      [6406.3755],
      [7433.30951],
      [330.746],
      [25,000],
      [ASO #cite_year(<yildiz2022new>)],
      [6084.4534265],
      [6713.6637],
      [7438.65159],
      [320.651],
      [25,000],
      [MFO #cite_year(<yildiz2022new>)],
      [6059.7143350],
      [6434.5021],
      [7544.49251],
      [424.968],
      [25,000],
      [GA #cite_year(<gupta2021comparison>)],
      [6059.9463],
      [6177.2533],
      [6469.3220],
      [130.9297],
      [80,000],

      table.cell(
        rowspan: 7,
      )[WB],
      [HINFO-NM],
      [1.724852],
      [1.726326],
      [1.728852],
      [0.010236],
      [10,000],
      [SSA #cite_year(<karen2006hybrid>)],
      [1.727190],
      [1.821670],
      [2.183687],
      [0.10062],
      [18,000],
      [MVO #cite_year(<karen2006hybrid>)],
      [1.726651],
      [1.750465],
      [1.852376],
      [0.02355],
      [18,000],
      [MFO #cite_year(<karen2006hybrid>)],
      [1.724852],
      [1.981122],
      [2.954716],
      [0.32587],
      [18,000],
      [ASO #cite_year(<karen2006hybrid>)],
      [1.727968],
      [1.940260],
      [2.319885],
      [0.14046],
      [18,000],
      [EBO #cite_year(<karen2006hybrid>)],
      [1.725096],
      [2.034738],
      [2.915366],
      [0.21245],
      [18,000],
      [EO #cite_year(<karen2006hybrid>)],
      [1.724852],
      [1.7299321],
      [1.787483],
      [0.011922],
      [18,000],

      table.cell(
        rowspan: 6,
      )[ASA],
      [Salp swarm optimizer],
      [2095],
      [2100],
      [2116],
      [18],
      [100],
      [Equilibrium optimizer],
      [2085],
      [2095],
      [2116],
      [16],
      [100],
      [Harris hawks optimizer],
      [2075],
      [2085],
      [2116],
      [12],
      [100],
      [Slime mould optimizer],
      [2085],
      [2090],
      [2116],
      [14],
      [100],
      [Marine predator optimizer],
      [2005],
      [2075],
      [2116],
      [9],
      [100],
      [HINFO-NM],
      [1900],
      [1910],
      [1925],
      [5],
      [100],
    ),
    caption: "Hasil perbandingan HINFO-NM dengan algoritma lain pada fungsi objektif COWBR, BS, PV, WB, dan ASA",
  )<hinfo-nm>
]

Pada @hinfo-nm #lorem(40)

$
  alpha = 1 + cos frac((n_c - 1)pi, 2n_c), wide beta = 1 + cos frac((n_c-3)pi, 2n_c)\
  gamma = 1 + cos frac((n_c+5)pi, 2n_c), wide delta = 1 + cos frac((n_c+3)pi, 2n_c)
$

#noindent[
  #lorem(40)
]

#lorem(40)

#align(center)[
    #set text(size: 0.8em)
    #figure(
    table(
      //       inset: 5pt,
      columns: (1.5fr, 2fr, 2fr, 3fr, 2fr),
      align: (horizon + left, left + horizon, left + horizon, left + horizon, left + horizon),
      // Urutan header diubah di sini
      table.header(
        [*Penulis*], [*Algoritma*], [*Algoritma Pembanding*], [*Hasil*], [*Perbedaan dengan Penelitian ini*]
      ),

      [Musafer et al. #cite_year(<musafer2018dynamic>)],
      [DHNM],
      [ANMS, GNM],
      [Lebih akurat, namun membutuhkan evaluasi fungsi yang lebih banyak.],
      [Mengubah langkah NMS secara garis besar],

      [Mehta #cite_year(<mehta2022nelder>)],
      [HINFO-NM],
      [Berbagai algoritma metaheuristik (BOA, GA, ALO, SSA, dll.)],
      [Secara konsisten menghasilkan solusi terbaik di setiap metrik pada fungsi yang diuji.],
      [Mengintegrasikan INFO dengan NMS],

      [Mehta #cite_year(<mehta2020improved>)],
      [NMS dengan skema _Chebyshev spacing points_ (CSP-NM)],
      [SNMS, DHNM, skema Kumar-Suri],
      [Sangat kompetitif, tingkat keberhasilan tinggi (75-85%), dan lebih jarang menggunakan langkah refleksi.],
      [Mengganti parameter tetap dengan parameter adaptif],

      [Liu #cite_year(<liu2024enhanced>)],
      [NMQI-POSTA],
      [Varian POSTA, ABC, GWO, SaDE, CLPSO],
      [Paling unggul dalam akurasi, konsistensi, efisiensi, dan kecepatan konvergensi.],
      [Mengintegrasikan POSTA dengan NMS dan QI],

      [Topalov dan Radović #cite_year(<topalov2025modification>)],
      [PSO-NMS],
      [PSO standar, PSO yang dimodifikasi],
      [Performa terbaik dengan keseimbangan antara akurasi dan jumlah evaluasi fungsi.],
      [Hibridisasi PSO dengan NMS],

      [Salimans et al. #cite_year(<salimans2017evolution>)],
      [_Evolution Strategies_],
      [_Reinforcement Learning_ (TRPO, A3C)],
      [Metode _derivative-free_ kompetitif dan skalabel untuk optimasi parameter dimensi tinggi.],
      [Aplikasi metode _black-box_ pada Jaringan Saraf Tiruan],
    ),
    caption: [Perbandingan metode penelitian],
  ) <perbandingan-metode>
]

Pada @perbandingan-metode #lorem(20)


#pagebreak()
