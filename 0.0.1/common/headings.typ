#import "palettes.typ": palette

#let headingGrad(col1, col2) = gradient.linear(angle: 90deg, col1, col2)

#let blockHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  col1: palette.grey.tx,
  col2: palette.grey.da,
  tcol: palette.grey.bg,
  scale: 1,
) = [
  #block(
    above: 3em/2, below: 1em,
    stroke: (y: 1pt + col1),
    inset: (y: 2pt),
  )[
    #set text(1em * scale, weight: 900, fill: tcol)
    #grid(
      inset: (x: 1em / 2, y: 1em / 3),
      columns: (auto, 1fr),
      align: horizon,
      grid.cell(fill: col1)[#prefix#number],
      grid.cell(fill: headingGrad(col2, col1))[#body],
    )
  ]
]

#let inlineBlockHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  col1: palette.grey.tx,
  col2: palette.grey.da,
  tcol: palette.grey.bg,
) = {
  parbreak()
  box(
    stroke: (y: 1pt + col1),
    outset: (y: 1em / 3),
  )[
    #set text(1em * 0.9, weight: 900, fill: tcol)
    #stack(dir: ltr, spacing: 0em)[
      #box(
        fill: col1,
        inset: (x: 1em / 2),
        outset: (y: (1em / 4)),
      )[#prefix#number]
    ][
      #box(
        fill: headingGrad(col2, col1),
        inset: (x: 1em / 2),
        outset: (y: (1em / 4)),
      )[#body]
    ]
  ]
  h(1em / 3)
}

#let roundHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  col1: palette.grey.tx,
  col2: palette.grey.da,
  tcol: palette.grey.bg,
  rad: 12pt,
  scale: 1,
) = [
  #block(
    above: 3em/2, below: 1em,
  )[
    #set text(1em * scale, weight: 900, fill: tcol)
    #grid(
      inset: (x: 1em / 2, y: 1em / 3),
      columns: (auto, 1fr),
      align: horizon,
      grid.cell(inset: 0em)[#block(radius: (left: rad), fill: col1)[#prefix#number]],
      grid.cell(inset: 0em)[#block(width: 100%, radius: (right: rad), fill: headingGrad(col2, col1))[#body]],
    )
  ]
]

#let inlineRoundHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  rad: 12pt,
  col1: palette.grey.tx,
  col2: palette.grey.da,
  tcol: palette.grey.bg,
) = {
  parbreak()
  box()[
    #set text(1em * 0.9, weight: 900, fill: tcol)
    #stack(dir: ltr, spacing: 0em)[
      #box(
        radius: (left: rad),
        fill: col1,
        inset: (x: 1em / 2),
        outset: (y: (1em / 3)),
      )[#prefix#number]
    ][
      #box(
        radius: (right: rad),
        fill: headingGrad(col2, col1),
        inset: (x: 1em / 2),
        outset: (y: (1em / 3)),
      )[#body]
    ]
  ]
  h(1em / 3)
}

#let lineHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  tcol: palette.grey.tx,
  scale: 1,
) = [

  #block(
    above: 3em/2, below: 1em,
    stroke: (bottom: 2pt + tcol),
    inset: (y: 2pt),
  )[
    #set text(1em * scale, weight: 900, fill: tcol)
    #grid(
      inset: (x: 1em / 2, y: 1em / 3),
      columns: (auto, 1fr),
      align: horizon,
      grid.cell(fill: none)[#prefix#number],
      grid.cell(fill: none)[#body],
    )
  ]
]

#let inlineLineHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  tcol: palette.grey.tx,
) = {
  parbreak()
  box(
    stroke: (bottom: 1pt + tcol, right: 1pt + tcol),
    outset: (y: 1em / 3),
  )[
    #set text(1em * 0.9, weight: 900, fill: tcol)
    #stack(dir: ltr, spacing: 0em)[
      #box(
        fill: none,
        inset: (x: 1em / 2),
        outset: (y: (1em / 4)),
      )[#prefix#number]
    ][
      #box(
        fill: none,
        inset: (x: 1em / 2),
        outset: (y: (1em / 4)),
      )[#body]
    ]
  ]
  h(1em / 3)
}

#let bookHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
  col1: palette.grey.ac,
  tcol: palette.grey.tx,
  scale: 2,
) = block(
  stroke: (y: 1pt + col1),
  inset: (y: 3pt),
)[

  #show: align.with(horizon);
  #block(
    above: 3em/2, below: 1em,
    stroke: (y: 1pt + tcol),
    inset: (y: 2pt),
  )[
    #grid(
      inset: (1em / 2),
      columns: (auto, 1fr),
      align: horizon,
      grid.cell(fill: none, stroke: (right: stroke(dash: "dotted", thickness: 1pt, paint: tcol)))[#prefix#number],
      grid.cell(fill: none)[#body],
    )
  ]
]

#let plainHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  scale: 1,
  body,
) = {
  block(spacing: 1em)[
    #set text(size: 1em * scale, weight: 700);
    #prefix#number #body
  ]
}

#let inlinePlainHeading(
  number: context counter(heading).display(),
  format: "1.1.1",
  prefix: none,
  body,
) = {
  parbreak()
  strong[#prefix#number #body]
}


#let callHeading(
  style: "block",
  scales: (1.5, 1.25, 1.125),
  prefix,
  num,
  numformat,
  colsc,
  level,
  body,
) = {
  if (style == "book" and level == 1) {
    return bookHeading(body, col1: colsc.ac, tcol: colsc.tx, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat)
  } else if (style in ("block", "book")) {
    if (level == 1) {
      return blockHeading(
        body,
        col1: colsc.tx,
        col2: colsc.da,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 2) {
      return blockHeading(
        body,
        col1: colsc.da,
        col2: colsc.ac,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 3) {
      return blockHeading(
        body,
        col1: colsc.ac,
        col2: colsc.la,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 3 + 1) {
      return inlineBlockHeading(body, col1: colsc.tx, col2: colsc.da, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level == 3 + 2) {
      return inlineBlockHeading(body, col1: colsc.da, col2: colsc.ac, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level == 3 + 3) {
      return inlineBlockHeading(body, col1: colsc.ac, col2: colsc.la, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level >= 3 + 4) {
      return inlineBlockHeading(body, col1: colsc.la, col2: colsc.it, tcol: colsc.tx, prefix: prefix, number: num, format: numformat)
    }
  } else if (style == "round") {
    if (level == 1) {
      return roundHeading(
        body,
        col1: colsc.tx,
        col2: colsc.da,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 2) {
      return roundHeading(
        body,
        col1: colsc.da,
        col2: colsc.ac,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 3) {
      return roundHeading(
        body,
        col1: colsc.ac,
        col2: colsc.la,
        tcol: colsc.bg,
        prefix: prefix,
        scale: scales.at(level - 1),
        number: num,
        format: numformat,
      )
    } else if (level == 3 + 1) {
      return inlineRoundHeading(body, col1: colsc.tx, col2: colsc.da, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level == 3 + 2) {
      return inlineRoundHeading(body, col1: colsc.da, col2: colsc.ac, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level == 3 + 3) {
      return inlineRoundHeading(body, col1: colsc.ac, col2: colsc.la, tcol: colsc.bg, prefix: prefix, number: num, format: numformat)
    } else if (level >= 3 + 4) {
      return inlineRoundHeading(body, col1: colsc.la, col2: colsc.it, tcol: colsc.tx, prefix: prefix, number: num, format: numformat)
    }
  } else if (style == "lines") {
    if (level == 1) {
      return lineHeading(body, tcol: colsc.tx, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat)
    } else if (level == 2) {
      return lineHeading(body, tcol: colsc.tx, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat)
    } else if (level == 3) {
      return lineHeading(body, tcol: colsc.tx, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat)
    } else if (level == 3 + 1) { return inlineLineHeading(body, tcol: colsc.tx, prefix: prefix, number: num, format: numformat) } else if (
      level == 3 + 2
    ) { return inlineLineHeading(body, tcol: colsc.tx, prefix: prefix, number: num, format: numformat) } else if (level == 3 + 3) {
      return inlineLineHeading(body, tcol: colsc.tx, prefix: prefix, number: num, format: numformat)
    } else if (level >= 3 + 4) { return inlineLineHeading(body, tcol: colsc.tx, prefix: prefix, number: num, format: numformat) }
  } else {
    if (level == 1) { return plainHeading(body, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat) } else if (level == 2) {
      return plainHeading(body, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat)
    } else if (level == 3) { return plainHeading(body, prefix: prefix, scale: scales.at(level - 1), number: num, format: numformat) } else if (
      level == 3 + 1
    ) { return inlinePlainHeading(body, prefix: prefix, number: num, format: numformat) } else if (level == 3 + 2) {
      return inlinePlainHeading(body, prefix: prefix, number: num, format: numformat)
    } else if (level == 3 + 3) { return inlinePlainHeading(body, prefix: prefix, number: num, format: numformat) } else if (level >= 3 + 4) {
      return inlinePlainHeading(body, prefix: prefix, number: num, format: numformat)
    }
  }
}
