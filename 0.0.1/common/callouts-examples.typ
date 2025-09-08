#import "palettes.typ": palette
#import "icons.typ": icon as iconloader
#set text(font: "Romeosevka")
#set page(width: 7in, height: auto, margin: 0.25in)



#let callout(
  colour-scheme: "grey",
  title: "",
  icon: "info",
  alignment: center,
  width: 500% / 6,
  border: true,
  body,
) = [
  
  #set par(justify: true)
  #let colsc = if (colour-scheme in palette.keys()) { palette.at(colour-scheme) } else { palette.at("default") }
  #let laacgrad = gradient.linear(angle: 90deg, colsc.la, colsc.ac)
  #grid(
    columns: 1 * 100%,
    align: center,
    inset: 0em,
    grid.cell(block(
      breakable: false,
      height: auto,
      stroke: if(border){(bottom: none, rest: 1pt + laacgrad)} else {none},
      fill: laacgrad,
      inset: 2em/3,
      width: width,
      [
        #show: align.with(alignment)
        #set text(fill: colsc.bg, weight: "bold", size: 1.25em)
        #iconloader(icon) #smallcaps[#title]
      ],
    )),
    grid.cell(block(
      breakable: false,
      fill: gradient.linear(angle: 90deg, colsc.it.mix(colsc.bg), colsc.it),
      stroke: if(border){(top: none, rest: 1pt + laacgrad)} else {none},
      inset: 2em/3,
      width: width,
      [
        #show: align.with(alignment)
        #body],
    ))
  )
]

#let examplecounter = counter("example")
#show heading: hi => {examplecounter.update(0); hi }
#set heading(numbering: "1.1.1")
#let example(
  colour-scheme: "grey",
  icon: "asterisk",
  alignment: horizon + left,
  width: 500% / 6,
  body,
) = [
  #let colsc = if (colour-scheme in palette.keys()) { palette.at(colour-scheme) } else { palette.at("default") }
    #let laacgrad = gradient.linear(angle: 90deg, colsc.la, colsc.ac)
  #examplecounter.step()
  #show: align.with(center)
  #block(
    width: width,
    stroke: stroke(
      paint: laacgrad,
      thickness: 1.5pt,
      dash: "dashed"
    )
  )[

    
    #grid(
      columns: (2em/3, 100% - 2em/3),
      inset: (0pt, 2em/3),
      align: alignment,
      rows: 1,
      grid.cell(
        fill: laacgrad,
        none,
      ),
      grid.cell(fill: gradient.linear(angle: 90deg, colsc.it.mix(colsc.bg), colsc.it))[
        #text(1.25em)[#iconloader(icon) #smallcaps[#strong[Example #context counter(heading).get().at(0)-#context examplecounter.display()]]] \
        #body
      ],
    )
  ]]


#let defcounter = counter("definition")
#show heading: hi => {defcounter.update(0); hi }
#set heading(numbering: "1.1.1")
#let definition(
  title: "Definition",
  numbered: true,
  colour-scheme: "grey",
  icon: "dictionary",
  alignment: horizon + left,
  width: 500% / 6,
  body,
) = [
  #let colsc = if (colour-scheme in palette.keys()) { palette.at(colour-scheme) } else { palette.at("default") }
  #let laacgrad = gradient.linear(angle: 90deg, colsc.la, colsc.ac)
  #if(numbered){defcounter.step()}
  #show: align.with(center)
  #block(
    width: width - 1.5pt,
    stroke: stroke(
      paint: laacgrad,
      thickness: 1.5pt,
      dash: "dotted"
    )
  )[

  
    #grid(
      columns: (2.5em/9, 1em/9, 2.5em/9, 100% - 2em/3),
      inset: (..(0pt,)*3, 2em/3),
      align: alignment,
      rows: 1,
      grid.cell(
        fill: laacgrad,
        none,
      ),
      grid.cell(
        fill: gradient.linear(angle: 90deg, colsc.bg, colsc.it.mix(colsc.bg)), none,
      ),
      grid.cell(
        fill: laacgrad,
        none,
      ),
      grid.cell(fill: gradient.linear(angle: 90deg, colsc.bg, colsc.it.mix(colsc.bg)))[
        #text(1.25em)[#iconloader(icon) #smallcaps[#strong[#title #if(numbered){[#context counter(heading).get().at(0)-#context defcounter.display()]}]]] \
        #body
      ],
    )
  ]]

