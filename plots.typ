#import "@preview/cetz:0.4.0"

#let color_map = (
  "Gradient Descent": red,
  "Adam": orange,
  "Gradient Descent - Adam": orange,
  "Nelder-Mead (NM)": gray,
  "ANMS": gray,
  "Adaptive Nelder-Mead (ANMS)": gray,
  "Adaptive NM (ANMS)": gray,
  "Chebyshev Nelder-Mead (CSP-NM)": purple,
  "CSP-NM": purple,
  "Chebyshev NM (CSP-NM)": purple,
  "Interpolated Nelder-Mead (INMS)": blue,
  "INMS": blue,
  "Refined INM (RINM)": green,
  "TS-INM": green,
  "Two-Stages Interpolated Nelder-Mead (TSINM) - Adaptive": green,
  "TS-INM-A": green,
  "Two-Stages Interpolated Nelder-Mead (TSINM) - Chebyshev": green.darken(20%),
  "TS-INM-C": green.darken(20%),
  "Interpolated Chebyshev NM (ICSPNM)": teal,
  "Refined Chebyshev NM (RCSPNM)": olive,
)

// Helper function to format small numbers in scientific notation
#let fmt-sci(val) = {
  if val == 0 {
    "0"
  } else if val < 0.0001 {
    let exp = calc.floor(calc.log(val, base: 10))
    let mant = val / calc.pow(10, exp)
    str(calc.round(mant, digits: 2)) + "e" + str(exp)
  } else {
    str(calc.round(val, digits: 4))
  }
}

#let create-benchmark-plot(title, file-path) = {
  let results = csv(file-path)
  let methods = (
    "Adaptive Nelder-Mead (ANMS)": "ANMS",
    "Chebyshev Nelder-Mead (CSP-NM)": "CSP-NM",
    "Gradient Descent": "GD",
    "Gradient Descent - Adam": "Adam",
    "Two-Stages Interpolated Nelder-Mead (TSINM) - Adaptive": "TSINM-A",
    "Two-Stages Interpolated Nelder-Mead (TSINM) - Chebyshev": "TSINM-C",
  )

  let data = results
    .slice(1)
    .filter(row => row.at(0) in methods)
    .map(row => {
      let raw-name = row.at(0)
      let name = methods.at(raw-name)
      let loss = float(row.at(1))
      (name: name, loss: loss, raw-name: raw-name)
    })
    .sorted(key: r => r.loss)

  [
    #align(center, text(weight: "bold", title))
    #v(0.5em)
    #cetz.canvas({
      import cetz.draw: *

      let chart-width = 10
      let chart-height = 4

      let max-loss = calc.max(..data.map(d => d.loss))
      let min-loss = calc.max(1e-15, calc.min(..data.filter(d => d.loss > 0).map(d => d.loss)))

      let use-log = (max-loss / min-loss) > 100

      let y-max = if use-log { calc.log(max-loss * 2.0) } else { max-loss * 1.2 }
      let y-min = if use-log { calc.log(min-loss * 0.1) } else { 0 }

      // Axes
      line((0, 0), (0, chart-height), mark: (end: "stealth"))
      line((0, 0), (chart-width + 0.5, 0), mark: (end: "stealth"))

      // Y-axis label
      content((-0.8, chart-height / 2), [Loss (MSE)], anchor: "center", size: 0.8em, angle: 90deg)

      // Y-ticks
      if use-log {
        let start-pow = calc.floor(calc.log(min-loss, base: 10))
        let end-pow = calc.ceil(calc.log(max-loss, base: 10))
        for p in range(start-pow, end-pow + 1) {
          let val = calc.pow(10, p)
          let y-pos = ((calc.log(val) - y-min) / (y-max - y-min)) * chart-height
          if y-pos >= 0 and y-pos <= chart-height {
            line((-0.1, y-pos), (0.1, y-pos))
            content((-0.2, y-pos), [#text(size: 7pt)[10#super(str(p))]], anchor: "east")
          }
        }
      } else {
        let num-ticks = 4
        for i in range(num-ticks + 1) {
          let val = i * max-loss * 1.2 / num-ticks
          let y-pos = i * chart-height / num-ticks
          line((-0.1, y-pos), (0.1, y-pos))
          let label = if val < 0.001 { fmt-sci(val) } else { str(calc.round(val, digits: 3)) }
          content((-0.2, y-pos), [#text(size: 7pt)[#label]], anchor: "east")
        }
      }

      // Bars
      let n = data.len()
      let bar-width = 0.8
      let gap = (chart-width - (n * bar-width)) / (n + 1)

      for (i, d) in data.enumerate() {
        let x-pos = gap + i * (bar-width + gap)
        let loss-val = calc.max(d.loss, 1e-15)

        let bar-h = if use-log {
          ((calc.log(loss-val) - y-min) / (y-max - y-min)) * chart-height
        } else {
          (loss-val / y-max) * chart-height
        }
        let bar-h = calc.max(bar-h, 0.05)

        let color = color_map.at(d.raw-name, default: blue.lighten(40%))
        rect((x-pos, 0), (x-pos + bar-width, bar-h), fill: color, stroke: 0.5pt)

        content((x-pos + bar-width / 2, -0.2), [#text(size: 8pt)[#d.name]], anchor: "north")
        content((x-pos + bar-width / 2, bar-h + 0.1), [#text(size: 7pt)[#fmt-sci(d.loss)]], anchor: "south")
      }
    })
  ]
}

#let create-problem-plot(file-path) = {
  let json-data = json(file-path)
  let problem-name = json-data.problem_name
  let dimension = json-data.dimension
  let results = json-data.results

  // Filter out INMS and sort by loss
  let filtered-results = results.filter(r => not r.optimizer.contains("INMS"))
  let sorted-results = filtered-results.sorted(key: r => r.loss)

  [
    #align(center, text(weight: "bold", [#problem-name (dim = #dimension)]))
    #v(0.3em)
    #cetz.canvas({
      import cetz.draw: *

      let chart-width = 10
      let chart-height = 4

      let max-loss = calc.max(..sorted-results.map(r => r.loss))
      let min-loss = calc.max(1e-15, calc.min(..sorted-results.filter(r => r.loss > 0).map(r => r.loss)))

      let use-log = (max-loss / min-loss) > 10

      let y-max = if use-log { calc.log(max-loss * 5.0) } else { max-loss * 1.5 }
      let y-min = if use-log { calc.log(min-loss * 0.1) } else { 0 }

      // Axes
      line((0, 0), (0, chart-height), mark: (end: "stealth"))
      line((0, 0), (chart-width + 0.5, 0), mark: (end: "stealth"))
      content((-0.8, chart-height / 2), [Loss], anchor: "center", size: 0.8em, angle: 90deg)

      // Y-ticks
      if use-log {
        let start-pow = calc.floor(calc.log(min-loss, base: 10))
        let end-pow = calc.ceil(calc.log(max-loss, base: 10))
        for p in range(start-pow, end-pow + 1) {
          let val = calc.pow(10, p)
          let y-pos = ((calc.log(val) - y-min) / (y-max - y-min)) * chart-height
          if y-pos >= 0 and y-pos <= chart-height {
            line((-0.1, y-pos), (0.1, y-pos))
            content((-0.2, y-pos), [#text(size: 7pt)[10#super(str(p))]], anchor: "east")
          }
        }
      }

      // Bars
      let n = sorted-results.len()
      let bar-width = 0.7
      let gap = (chart-width - (n * bar-width)) / (n + 1)

      for (i, r) in sorted-results.enumerate() {
        let x-pos = gap + i * (bar-width + gap)
        let loss-val = calc.max(r.loss, 1e-15)

        let bar-h = if use-log {
          ((calc.log(loss-val) - y-min) / (y-max - y-min)) * chart-height
        } else {
          (loss-val / y-max) * chart-height
        }
        let bar-h = calc.max(0.1, calc.min(bar-h, chart-height))

        let opt-name = r.optimizer
        let is-max-iter = r.iterations >= 10000
        let color = if is-max-iter { red.lighten(30%) } else { color_map.at(opt-name, default: blue.lighten(40%)) }

        rect((x-pos, 0), (x-pos + bar-width, bar-h), fill: color, stroke: 0.5pt)

        // Labels
        let label = if opt-name.contains("TSINM") {
          if opt-name.contains("Chebyshev") [TSINM-C] else [TSINM-A]
        } else if opt-name.contains("CSP") [CSP] else [ANM]

        content((x-pos + bar-width / 2, -0.3), [#text(size: 0.7em)[#label]], anchor: "north")

        let iter-text = if is-max-iter [10k (MAX)] else [#r.iterations it]
        content(
          (x-pos + bar-width / 2, -0.65),
          [#text(size: 0.6em, fill: if is-max-iter { red } else { gray.darken(30%) })[#iter-text]],
          anchor: "north",
        )

        content((x-pos + bar-width / 2, bar-h + 0.1), [#text(size: 0.6em)[#fmt-sci(r.loss)]], anchor: "south")
      }
    })
    #v(-0.5em)
    #align(center, text(
      size: 0.7em,
      [ANM = Adaptive NM, CSP = Chebyshev NM, TSINM-A = TSINM Adaptive, TSINM-C = TSINM Chebyshev],
    ))
  ]
}
