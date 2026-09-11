#import "common/palettes.typ": palette
#import "common/icons.typ": *
#import "common/pagesizes.typ": pagesizes
#let schooldoc(
  title: "",
  description: none,
  author: "Romeo",
  section: "",
  code: "",
  course: "",
  colour-scheme: "blue",
    subject-icon: none,
    paper: "a4",
    font: "Romeosevka",
    font-size: 12,
    bib-columns: 2,
    doc-columns: 1,
    flags: (),
  body,
) = [

  // COLOUR SCHEME DECODING
  #{
    colour-scheme = if (colour-scheme not in palette.keys()) { "default" } else { colour-scheme }
  }
  #let colsc = palette.at(colour-scheme)



  // PAGE STYLING
  #set page(
    width: if (not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(0)
    } else { paper.at(0) },
    height: if (not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(1)
    } else { paper.at(1) },
    margin: (x: 1in, y: 1in),
    columns: doc-columns,
    fill: colsc.bg,
    header-ascent: 0in,
    footer-descent: 0in,
    header: [
      #place(dx: -1in, block(width: 1in / 3, height: 1in / 3, fill: colsc.m2, inset: 1in / 12, block(
        inset: 1in / 24,
        width: 1in / 6,
        height: 1in / 6,
        fill: colsc.bg,
      )))
      #place(dx: -1in + 1in / 3, block(fill: colsc.fg, width: 100% + 2in, height: 1in / 3))
    ],
    footer: [
      #place(bottom, dx: -1in, block(fill: colsc.fg, width: 100% + 5in / 3, height: 1in / 3, inset: (x: font-size * 1pt / 2))[
        #show: align.with(horizon)
        #set text(fill: colsc.bg)
        #rd-icon
        #strong(course)
        #emph(title)
      ])
      #place(bottom + right, dx: 1in)[
        #block(fill: colsc.m2, width: 1in / 3, height: 1in / 3, inset: 0pt)[
          #set text(
            size: font-size * 1.5pt,
            weight: 900,
            fill: colsc.bg,
          )
          #show: align.with(horizon + center)
          #context counter(page).display()
        ]
      ]

    ],
  )

  // ****************************************************
  // TEXT STYLING
  // ****************************************************
  #set text(
    font: (font, "Romeosevka"),
    size: font-size * 1pt,
    stretch: 50%,
    fill: colsc.fg,
  )
  #set strong(delta: 500)

  // RAW INLINE TEXT
  #show raw.where(block: false): rawtext => box(
    fill: colsc.m1.transparentize(50%),
    inset: (x: 1em / 3),
    outset: (y: 1em / 4),
    text(
      font: "Romeosevka",
      size: font-size * 5pt / 6,
      stretch: 100%,
      fill: color.mix((colsc.fg, 80%), (colsc.m2, 20%)),
      rawtext,
    ),
  )

  // RAW BLOCK TEXT
  #show raw.where(block: true): rawblock => {
    set text(
      font: "Romeosevka",
      stretch: 100%,
      fill: color.mix((colsc.fg, 80%), (colsc.m2, 20%)),
    )
    show raw.line: rl => {
      block(radius: 1em, spacing: -0.75em / 2, width: 100%, inset: 0em, grid(
        columns: (if (not false) { 2em } else { 0em }, 1fr),
        rows: auto,
        inset: (y: 1em / 3, x: 0.5em),
        align: (horizon + right, horizon + left),
        fill: if (calc.even(rl.number)) { none } else { colsc.m1.transparentize(90%) },
        [#if (not false) { [#text(fill: colsc.m2, size: 2em / 3)[#rl.number]] }], rl.body,
      ))
    }
    set par(leading: 1em / 2)
    rawblock
  }

  #show raw.where(block: true): rawblock => [
    #text(fill: colsc.m2, font: "Romeosevka", stretch: 100%)[[#rawblock.lang]]
    #block(
      stroke: (left: 2pt + colsc.fg),
      [#rawblock],
    )]

  // LINK TEXT
  #show link: set text(fill: colsc.m2)
  #show ref: set text(fill: colsc.m2)

  // HIGHLIGHTS
  #set highlight(fill: colsc.m1.transparentize(50%), extent: (1em / 6))
  #show <--forcehl>: it => box(fill: colsc.m1.transparentize(50%), outset: (y: 1em/2), it)

  // MATH TEXT
  #show math.equation: set text(
    font: "New Computer Modern Math",
    size: font-size * 1.125pt,
  )
  #show math.equation.where(block: true): set text(
    size: font-size * 1.5pt,
  )

  // LISTS
  #set list(marker: ("•", "‣", "▪"))

  #set enum(full: true, numbering: (..nums) => [
    #strong[#numbering("1.1.1.", ..nums)]
  ])

  // PARAGRAPHS
  #set par(
    leading: font-size * 1pt * 0.8,
    spacing: font-size * 1pt * 1.5,
  )

  // OUTLINES
  #set outline(
    indent: 1em,
    title: "Table of Contents",
  )
  #show outline: out => {
    show heading: none
    block(
      fill: colsc.fg,
      width: 100%,
      stroke: (bottom: 1pt + colsc.fg),
      inset: (y: font-size * 1pt / 2, left: { font-size * 1pt / 2 }),
    )[
      #set text(fill: colsc.bg, size: font-size * 1.5pt, weight: 900)
      #icon("toc")
      #out.title]
    out
  }

  #show outline.entry: oleg => {
    show link: text.with(fill: colsc.fg)
    if (str(repr(oleg.inner())).contains("[" + "References" + "]")) {
      link(oleg.element.location(), oleg.indented(text(baseline: 2pt, icon("book")) + oleg.prefix(), oleg.inner()))
    } else {
      link(oleg.element.location(), oleg.indented(oleg.prefix(), oleg.inner()))
    }
  }
  #show outline.entry.where(level: 1): strong

  // ****************************************************
  // TABLES
  // ****************************************************
  // #show table: block.with(stroke: 1pt+colsc.fg)
  #show table: align.with(center)
  #show table.header: strong
  #show table.cell: tc => if tc.y == 0 { strong(tc) } else { tc }
  #set table(
    fill: (_, y) => if (y == 0) { colsc.m1.transparentize(50%) },
    stroke: (x, y) => if (y == 0) { (y: 1pt + colsc.fg) },
    inset: (y: font-size * 1pt / 2),
    align: (x, y) => if y == 0 { center } else if x == 0 { left } else { center },
  )
  #show <--border>: it => block(stroke: 1pt + colsc.fg, it)
  #set grid(stroke: 1pt+colsc.fg)

  // ****************************************************
  // CALLOUTS
  // ****************************************************
  #show <--callouttitle>: it => {
    block(
      inset: font-size * 1pt / 2,
      fill: colsc.m1.transparentize(50%),
      stroke: (left: 2pt + colsc.fg),
      width: 100%,
      align(left, text(strong(it))),
    )
  }
  #show <--calloutbody>: it => {
    block(
      inset: font-size * 1pt / 2,
      // fill: colsc.m1.transparentize(75%),
      stroke: (left: 2pt + colsc.fg),
      width: 100%,
      align(left, text((it))),
    )
  }

  // ****************************************************
  // HEADINGS
  // ****************************************************
  #set heading(numbering: "[1.1]", supplement: "Pingas")
  #let headingblock(hf, fill: colsc.fg, bg: none) = block(
    fill: bg,
    width: 100%,
    stroke: (bottom: 1pt + fill),
    inset: (y: font-size * 1pt / 2, left: if (bg == none) { 0pt } else { font-size * 1pt / 2 }),
  )[
    #set text(fill: fill)
    #context counter(heading).display() #hf.body]

  #show heading.where(level: 1): h1 => {
    set text(size: font-size * 1.5pt, weight: 900)
    headingblock(h1, fill: colsc.bg, bg: colsc.fg)
  }

  #show heading.where(level: 2): h2 => {
    set text(size: font-size * 1.33pt, weight: 900)
    headingblock(h2)
  }

  #show heading.where(level: 3): h3 => {
    set text(size: font-size * 1.1pt, weight: 900)
    headingblock(h3)
  }

  #show heading.where(level: 4): h4 => {
    set text(size: font-size * 1pt, weight: 900)
    [#context counter(heading).display() #h4.body]
  }

  #show heading.where(level: 5): h5 => {
    set text(size: font-size * 1pt, weight: 900)
    [#context counter(heading).display() #h5.body]
  }

  #show heading.where(level: 6): h6 => {
    set text(size: font-size * 1pt, weight: 900)
    [#context counter(heading).display() #h6.body]
  }

  // BIBLIGRAPHY
  #set bibliography(title: "References", full: true)
  #show bibliography: bib => {
    show heading: none
    block(
      fill: colsc.fg,
      width: 100%,
      stroke: (bottom: 1pt + colsc.fg),
      inset: (y: font-size * 1pt / 2, left: { font-size * 1pt / 2 }),
    )[
      #set text(fill: colsc.bg, size: font-size * 1.5pt, weight: 900)
      #icon("format_quote")
      #bib.title]
    columns(bib-columns, bib)
  }

  #show "“": "« "
  #show "”": " »"
  //-----------------------------------
  // SCHOOLDOC HEADER
  #block(
    width: 100%,
    inset: (y: 1em, x: 1em/2),
    stroke: (y: 1pt+ colsc.fg)
  )[
    #icon("code") #raw(code)\
  #text(
    size: font-size * 2pt,
    weight: 900,
    title,
  )\
  #if (description != none) { [#emph(description)\ ] }
  #icon("person") #strong(if (type(author) == str) { author } else if (type(author) == array) { author.join(",") }) #if(section not in (none, "")){[-- #emph(section)]}\
  #icon("book_ribbon") #course\
  #icon("calendar_today") #datetime.today().display("[day padding:zero] [month repr:short]. [year repr:full]")
  ]

  // DOCUMENT METADATA
  #let document-authors = ()
  #if (type(author) == array) {
    for aut in author { document-authors.push(aut) }
  } else { document-authors.push(author) }
  #set document(
    author: if (type(author) == array) { author.join("; ") } else { author },
    title: code + " - " + course + " - " + title,
    keywords: (
      ..document-authors,
      code,
      course,
      title,
    ),
  )
  // END OF STYLE DEFINITION
  #body

  #line(length: 100%, stroke: 1pt+colsc.fg)
  #[
    #set text(0.8em); #set par(leading: 0.5em); _Document compiled with Typst #sys.version.\ No generative AI was used to write any part of this document or the code behind it._]
]

#let callout(title: "Title", width: 75%, body) = align(center, block(breakable:false,width: width, grid(
  stroke: none,
  columns: 100%, rows: 2,
  [#title<--callouttitle>],
  [#body<--calloutbody>]
)))