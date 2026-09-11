#import "common/callouts-examples.typ": *
#import "common/palettes.typ": palette
#import "common/daterenderer.typ": datecoloursquare
#import "common/icons.typ": *
#import "common/headings.typ": callHeading
#import "common/pagesizes.typ": margins, pagesizes
#import "common/tables.typ": *

#let st = super[st]
#let nd = super[nd]
#let th = super[th]

#let schooldoc(
  // METADATA
  author: "",
  title: "",
  subject: "",
  section: "",
  code: "",
  date: datetime.today(),
  flags: (),
  printing-info: "",
  // STYLING OPTIONS
  subject-icon: none,
  paper: "a4",
  margin-mode: "standard",
  doc-columns: 1,
  colour-scheme: "default",
  font-family: "Romeosevka",
  font-size: 12pt,
  line-spacing: 1,
  par-spacing: 1,
  raw-font-scale: 1,
  math-font-scale: 6 / 5,
  bib-font-scale: 5 / 6,
  background-desaturate: false,
  border-radii: (1em / 8),
  author-columns: 4,
  // ELEMENT OPTIONS
  heading-numbering: "1.1.1",
  heading-prefix: none,
  heading-style: "block",
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
  #let authorhl = gradient.linear(angle: 90deg, colsc.da, colsc.tx)
  #let authorhl1 = gradient.linear(angle: 90deg, colsc.ac, colsc.da)
  #let authorhl2 = gradient.linear(angle: 90deg, colsc.la, colsc.ac)
  #let authorhl3 = gradient.linear(angle: 90deg, colsc.it, colsc.la)

  // DATA PROCESSING
  // TEXT
  #set text(
    font: (font-family, "Romeosevka", "RomeosevkaQP", "Iosevka", "Iosevka SS04"),
    size: font-size,
    fill: colsc.tx,
    stretch: if(flags.contains("condensed-font")){50%}else if(flags.contains("semicondensed-font")){90%}else{100%},
  )

  // FONT
  #show raw: set text(
    font: ("Romeosevka", "Iosevka", "Iosevka SS04", "DejaVu Sans Mono"),
  )
  //// RAW TEXT
  #show raw.where(block: false): rawtext => box(
    fill: gradient.linear(angle: 90deg, colsc.it.transparentize(50%), colsc.it),
    inset: (x: 1em / 3),
    outset: (y: 1em / 4),
    radius: 1em / 4,
    stroke: 5pt / 6 + colsc.la.transparentize(100% / 3),
    text(rawtext),
  )
  #show raw.where(block: true): rawblock => {
    show raw.line: rl => {
      block(radius: 1em, spacing: -0.75em / 2, width: 100%, inset: 0em, grid(
        columns: (if (not flags.contains("no-raw-linenumbers")) { 2em } else { 0em }, 1fr),
        rows: auto,
        inset: (y: 1em / 3, x: 0.5em),
        align: (horizon + right, horizon + left),
        fill: if (calc.even(rl.number)) { colsc.bg } else { color.mix(
          (colsc.it, 20%),
          (colsc.bg, 80%)
        ) },
        [#if (not flags.contains("no-raw-linenumbers")) { [#text(fill: colsc.ac, size: 2em / 3)[#rl.number]] }], rl.body,
      ))
    }
    set par(leading: 1em / 2)
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
    size: font-size * 1.125,
  )
  #show math.equation.where(block: true): set text(
    size: font-size * math-font-scale,
  )

  // HIGHLIGHTS
  #set highlight(
    fill: gradient.linear(angle: 90deg, colsc.it.transparentize(50%), colsc.la.transparentize(50%)),
    radius: 1em / 3,
    extent: (1em / 4),
  )

  #let exhl(fill, body, strokemul: 1) = box(
    fill: none,
    inset: (x: 2pt),
    outset: (y: (1pt + 1em / 3)),
    radius: border-radii + 2pt,
    stroke: (strokemul * 1pt) + fill,
    box(
      fill: fill,
      inset: (x: -1pt + 1em / 3),
      outset: (y: -1pt + 1em / 3),
      radius: border-radii,
      stroke: none,
      body,
    ),
  )

  #show ref: set text(fill: colsc.ac)

  // PARAGRAPHS
  #set par(
    justify: if(flags.contains("unjustify")){false}else{true},
    leading: 5em/6 * line-spacing,
    spacing: 2*5em/6 * par-spacing,
  )

  #{
    colsc.bg = if (background-desaturate) {
      color.mix((colsc.bg, 100% / 3), (white, 200% / 3))
    } else { colsc.bg }
  }

  // PAGE
  #let marginval = 0.5in
  #set page(
    fill: if(colsc.at("bg2", default: none) != none){gradient.linear(colsc.bg, colsc.bg2, angle: 45deg)}else{colsc.bg},
    columns: doc-columns,
    width: if (not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(0)
    } else { paper.at(0) },
    height: if (not (type(paper) == array and paper.len() == 2)) {
      pagesizes.at(paper, default: pagesizes.shortbond).at(1)
    } else { paper.at(1) },
    margin: margins.at(margin-mode),
    header: [
      #line(length: 100%, stroke: (
        paint: colsc.da,
        dash: "solid",
      ))
    ],
    footer: if (not flags.contains("nofoot")) {
      align(bottom, move(
        dx: margins.at(margin-mode).left * -1,

        block(
          inset: (x: 0.5em,),
          width: 100% + margins.at(margin-mode).right * 2,
          height: 0.25in,
          fill: gradient.linear(angle: 0deg, colsc.la, colsc.ac),
        )[
          #show: align.with(horizon)
          #set text(size: 12pt, fill: colsc.bg)

            #text(size: font-size)[
              #rd-icon
              #if (code != "") {
                [#box(
                  fill: colsc.bg.transparentize(80%),
                  inset: (x: 1em / 6),
                  outset: (top: 1em / 4 + 1em / 12, bottom: 1pt + 1em/12),
                  radius: 1em / 4,
                  stroke: 2pt/3 + colsc.bg.transparentize(50%),
                  text(
                    4em / 6,
                    font: "Romeosevka",
                    code,
                    baseline: -1pt
                  ),
                )]
              } #strong(title)
              #h(1fr) #text(size: font-size, weight: 900, context counter(page).display())
            ]
          ]

        
      ))
    },
  )

  // potentially saved hundreds of lines by offloading heading styling to a different file
  #set heading(numbering: heading-numbering, supplement: heading-supplement)
  #show heading: it => callHeading(
    scales: heading-scales,
    style: heading-style,
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

  #set terms(hanging-indent: 1em)

  #show terms.item: ti => [
    - *#highlight(ti.term)*#h(0.5em) #ti.description
  ]

  // TABLE OF CONTENTS
  #set outline(
    indent: 1em,
    title: outline-title,
  )

  #show outline: out => {
    show heading: none
    callHeading(none, text(2em * 0.75, icon(offset: 5em / 12, "toc")), none, palette.at(colour-scheme), 1, align(center, text(
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
      text(size: 2em * 0.75, (icon(offset: if (heading-style == "plain") { 0em } else { 5em / 12 }, "book"))),
      none,
      palette.at(colour-scheme),
      1,
      box(align(center, text(size: 1.5em, bib.title))),
    )
    set text(1em * bib-font-scale)
    columns(bib-columns, bib)
  }

  // SHAPES AND STROKES
  #set square(stroke: 1pt + colsc.tx)
  #set line(stroke: 1pt + colsc.tx)
  #set strong(delta: 500)

  // TABLES all handled by common/tables.typ

  // DOCUMENT IDENTIFICATION

  #if(author.contains("Carlos Romeo") and type(author) == str){place(top + left, dx: margins.at(margin-mode).left * -1, dy: 1pt/2 + margins.at(margin-mode).top * -1)[
        #text(fill: authorhl2, size: 24pt, baseline: -1pt, font: "Romeosymbols", "s", )

  ]}

  // DOCUMENT HEADER
  #if (not flags.contains("noheader")) {
    [
      #set par(justify: if(not flags.contains("centre-head")){true}else{false})
      #show: align.with(if(not flags.contains("centre-head")){left}else{center})
      #[
        #if (type(author) == array and flags.contains("author-columns")) {
          let coltype = (auto,)
          coltype.push(..(1fr,) * (author-columns - 1))
          table(
            stroke: none,
            inset: (y: 1em / 3),
            columns: (auto,) * author-columns,
            ..author.map(aut => [#icon("person") #strong[#aut] #if (section != "" and flags.contains("showsection")) { emph[#"- "#section] }])
          )
          v(-1em)
        } else if (type(author) == array){
          for aut in author {box[#icon("person") #strong[#aut] #if (section != "" and flags.contains("showsection")) { emph[#"- "#section ] }]; h(1em, weak: true)}
          v(-0.8em)
        
        } else {
          [
            #if (author.contains("Carlos Romeo")) {
              rd-icon
            } else { icon("person") }
            #strong[#author]
            #if (section != "" and flags.contains("showsection")) { emph[#"· "#section] }
          ]
          linebreak()
        }
      ]
      #if (subject != "") {
        exhl(authorhl)[#set text(colsc.bg, weight: 900);#strong[#icon(
              if (subject-icon == none) {} else {
                subject-icon
              },
            ) #smallcaps[#subject]]]
      } #if (title != "") { exhl(authorhl1)[#text(colsc.bg, weight: 600)[#emph[#title]]] }
      #if ((subject != "" or title != "") and not flags.contains("compact-header")) { linebreak() } else if (flags.contains("compact-header")) { "•" }
      #if (code != "") { [#raw(code) •] }
      #icon("calendar_month") #date.display("[day padding:zero] [month repr:short]. [year repr:full]") #datecoloursquare(date, font-size * 1.125)
      #if(printing-info != ""){[• #icon("print") #printing-info]}
      #v(-0.5em)
      #line(length: 100%, stroke: (
        paint: colsc.tx,
        dash: "solid",
      ))
    ]
  }

  // DOCUMENT METADATA
  #let document-authors = ()
  #if (type(author) == array) {
    for aut in author { document-authors.push(aut) }
  } else { document-authors.push(author) }
  #set document(
    author: if (type(author) == array) { author.join("; ") } else { author },
    title: code + " - " + subject + " - " + title,
    keywords: (
      ..document-authors,
      repr(code),
      repr(subject),
      repr(title),
    ),
  )

  #body
]
