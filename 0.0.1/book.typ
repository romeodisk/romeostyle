#import "common/callouts-examples.typ": *
#import "common/palettes.typ": palette
#import "common/daterenderer.typ": datecoloursquare
#import "common/icons.typ": *
#import "common/headings.typ": callHeading
#import "common/pagesizes.typ": pagesizes, margins
#import "common/tables.typ": tables

#let book(
  // METADATA
  author: "",
  title: "",
  code: "",
  date: datetime.today(),
  flags: (),

  // STYLING OPTIONS
  paper: "shortbond",
  margin-mode: "standard",
  doc-columns: 1,
  colour-scheme: "default",
  font-family: "RomeosevkaQP",
  font-size: 12pt,
  line-spacing: 1,
  par-spacing: 1,
  raw-font-scale: 1,
  math-font-scale: 6 / 5,
  bib-font-scale: 5 / 6,
  background-desaturate: false,

  // ELEMENT OPTIONS
  heading-numbering: "1.1.1",
  heading-prefix: none,
  heading-style: "book",
  heading-supplement: "Chapter",
  heading-scales: (1.5, 1.25, 1.125),
  outline-title: "Table of Contents",
  outline-columns: 1,
  bib-title: "References",
  bib-style: "ieee",
  bib-columns: 2,
  body,
) = [

  // DEFAULT COLSC PROTECTION
  #{
    colour-scheme = if (colour-scheme not in palette.keys()) { "default" } else { colour-scheme }
  }
  #let colsc = palette.at(colour-scheme)

  // DATA PROCESSING
  // TEXT
  #set text(
    font: (font-family, "RomeosevkaQP", "Iosevka SS04"),
    size: font-size,
    fill: colsc.tx,
  )

  // FONT
  #show raw: set text(
    font: ("Romeosevka", "Iosevka SS04", "DejaVu Sans Mono"),
    size: font-size * raw-font-scale,
  )
  //// RAW TEXT
  #show raw.where(block: false): rawtext => box(
    fill: gradient.linear(angle: 90deg, colsc.it.transparentize(50%), colsc.it),
    inset: (x: 1em / 3),
    outset: (y: 1em / 4),
    radius: 1em / 4,
    stroke: 5pt / 6 + colsc.la.transparentize(100% / 3),
    text(5em / 6, rawtext),
  )
  #show raw.where(block: true): rawblock => {
    show raw.line: rl => {
      block(radius: 1em, spacing: -0.75em / 2, width: 100%, inset: 0em, grid(
        columns: (if(not flags.contains("no-raw-linenumbers")){2em}else{0em}, 1fr),
        rows: 4em / 3,
        inset: (y: 0em, x: 0.5em),
        align: (horizon + right, horizon + left),
        fill: if (calc.even(rl.number)) { colsc.bg } else { colsc.it.mix(colsc.bg).mix(colsc.bg) },
        [#if(not flags.contains("no-raw-linenumbers")){[#text(fill: colsc.ac, size: 2em / 3)[#rl.number]]}], rl.body,
      ))
    }
    rawblock
  }
  #show raw.where(block: true): rawblock => align(center, block(
    stroke: 1pt + colsc.la,
    inset: -0.125em,
    outset: (par.leading / 2) + 0.5pt,
    radius: 0.25em,
    spacing: 2em,
    width: if (flags.contains("reduced-codeblocks")) {
      200% / 3
    } else {
      95%
    },
    rawblock,
  ))

  // MATH TEXT
  #show math.equation: set text(
    font: "New Computer Modern Math",
    size: font-size * 1.125 ,
  )
  #show math.equation.where(block: true): set text(
    size: font-size * math-font-scale,
  )

  // HIGHLIGHTS
  #set highlight(
    fill: gradient.linear(angle: 90deg, colsc.it, colsc.la),
    radius: 1em / 3,
    extent: (1em / 4),
  )

  #let exhl(fill, body) = box(
    fill: fill,
    inset: (x: 1em / 3),
    outset: (y: 1em / 3),
    radius: 1em / 4,
    body,
  )

  #show ref: set text(fill: colsc.ac)

  // PARAGRAPHS
  #set par(
    justify: true,
    leading: 0.75em * line-spacing,
    spacing: 2em * par-spacing,
  )

  #{colsc.bg = if(background-desaturate) {
    color.mix((colsc.bg, 100%/3), (white, 200%/3))
  } else {colsc.bg}}

  #set page(
    fill: colsc.bg,
    columns: doc-columns,
    width: if(not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(0)
    } else {paper.at(0)},
    height: if(not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(1)
    } else {paper.at(1)},
    margin: margins.at(margin-mode),
  )

  // potentially saved hundreds of lines by offloading heading styling to a different file
  #set heading(numbering: heading-numbering, supplement: heading-supplement)
  #show heading: it => callHeading(
    scales: heading-scales,
    style: heading-style,
    supplement: heading-supplement,
    heading-prefix,
    counter(heading).display(),
    heading-numbering,
    palette.at(colour-scheme),
    it.level,
    it.body,
  )

  // LISTS, ENUMS, and TERM LISTS
  #set list(marker: ("•", "‣", "▪"))

  #set enum(full: true, numbering: (..nums) => [
    #strong[#numbering("1.1.1.", ..nums)]
  ])

  #set terms( hanging-indent: 1em,)

  #show terms.item: ti => [
    - *#highlight(ti.term)* #ti.description
  ]

  // TABLE OF CONTENTS
  #set outline(
    indent: 1em,
    title: outline-title,
  )

  #show outline: out => {
    show heading: none
    callHeading(none, text(2em * 0.75, icon(offset: 5em/12, "toc")), none, palette.at(colour-scheme), 1, align(center, text(
      size: 1.5em,
      outline.title,
    )))
    out
  }

  #show outline.entry: oleg => {
    if (str(repr(oleg.inner())).contains("[" + bib-title + "]")) {
      link(oleg.element.location(), oleg.indented(text(baseline: 2pt, icon("book")) + oleg.prefix(), oleg.inner()))
    } else {
      link(oleg.element.location(), oleg.indented(heading-prefix + oleg.prefix(), oleg.inner()))
    }
  }
  #show outline.entry.where(level: 1): strong
  #show outline.entry.where(level: 2): text.with(colsc.da)
  #show outline.entry.where(level: 3): text.with(colsc.ac)
  #show outline.entry.where(level: 4): text.with(colsc.tx)
  #show outline.entry.where(level: 5): text.with(colsc.da)
  #show outline.entry.where(level: 6): text.with(colsc.ac)
  #show outline.entry.where(level: 7): text.with(colsc.la)

  // BIBLIOGRAPHIES
  #set bibliography(full: true, style: bib-style, title: bib-title)

  #show bibliography: bib => {
    show heading: none
    show link: set text(fill: colsc.ac)
    callHeading(
      scales: heading-scales,
      style: heading-style,
      none,
      text(size: 2em * 0.75, (icon(offset: 5em/12, "book"))),
      none,
      palette.at(colour-scheme),
      1,
      align(center, text(size: 1.5em, bib.title)),
    )
    set text(1em * bib-font-scale)
    columns(bib-columns, bib)
  }

  // SHAPES AND STROKES
  #set square(stroke: 1pt + colsc.tx)
  #set line(stroke: 1pt + colsc.tx)

  // TABLES all handled by common/tables.typ

  // DOCUMENT METADATA
  #let document-authors = ()
  #if(type(author) == array){
    for aut in author {document-authors.push(aut)}
  }else{document-authors.push(author)}
  #set document(
    author: if(type(author) == array){author.join("; ")}else{author},
    date: date,
    title: code + " - " + " - " + title,
    keywords: (
      ..document-authors,
      code,
      title,
    )
  )

  #body
]