#let icon(offset: 0em, name) = text(
  font: "Material Symbols Outlined Filled",
  size: 5em/6,
  baseline: 5em/72 + offset,
  features: (("FILL": 1)),
  top-edge: "baseline",
  bottom-edge: "baseline",
  name)
#let rd-icon = text(size: 1em, baseline: -1pt, font: "Romeosymbols", "s", )
#let uc-logo =  box(height: 0.85em, {text(size: 1.4em,baseline: -0.05em, font: "Romeosymbols", "a"); h(-1em)})
#let romeo-sig =  text(size: 3em,font: "Romeosymbols", "p")