#import "palettes.typ": palette

#let tables(
  colour-scheme: "red",
  mode: "none",
  alternating: "none",
  columns: (),
  rows: (),
  gutter: (),
  column-gutter: (),
  row-gutter: (),
  alignment: auto,
  stroke: auto,
  border: false,
  inset: 0% + 5pt,
  ..children,
) = {
  show: align.with(center)

  colour-scheme = if (colour-scheme not in palette.keys()) { "default" } else { colour-scheme }
  let colsc = palette.at(colour-scheme)

  show table.cell: tc => if (mode == "h") {
    if (tc.x == 0) {
      set text(fill: colsc.bg, weight: "bold")
      tc
    } else { tc }
  } else if (mode == "v") {
    if (tc.y == 0) {
      set text(fill: colsc.bg, weight: "bold")
      tc
    } else { tc }
  } else if (mode == "hv") {
    if (tc.x == 0 or tc.y == 0) {
      set text(fill: colsc.bg, weight: "bold")
      tc
    } else { tc }
  } else { tc }

  let alternator(x, y) = (
    if (alternating) == "h" {
      if (calc.even(y)) { return colsc.it } else { return colsc.bg }
    } else if (alternating == "v") {
      if (calc.even(x)) { return colsc.it } else { return colsc.bg }
    } else if (alternating == "hv") {
      if (calc.even(x + y)) { return colsc.it } else { return colsc.bg }
    } else {
      return colsc.bg
    }
  )

  block(
    spacing: 1in/2,
    stroke: if (border) { 2pt + colsc.tx } else { none },
    table(
      fill: (x, y) => if (mode == "hv") {
        if (x == 0 or y == 0) {
          if (calc.odd(x + y + 1)) { colsc.tx } else { colsc.da.mix(colsc.tx) }
        } else {
          alternator(x, y)
        }
      } else if (mode == "h") {
        if (x == 0) {
          if (calc.odd(x + y + 1)) { colsc.tx } else { colsc.da.mix(colsc.tx) }
        } else {
          alternator(x, y)
        }
      } else if (mode == "v") {
        if (y == 0) {
          if (calc.odd(x + y + 1)) { colsc.tx } else { colsc.da.mix(colsc.tx) }
        } else {
          alternator(x, y)
        }
      },
      columns: columns,
      rows: rows,
      gutter: gutter,
      column-gutter: column-gutter,
      row-gutter: row-gutter,
      align: alignment,
      stroke: if (stroke == auto) {
        1pt + colsc.tx
      } else { stroke },
      inset: inset,
      ..children
    ),
  )
}
