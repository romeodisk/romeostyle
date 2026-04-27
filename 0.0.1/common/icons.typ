#let icon(offset: 0em, name) = text(
  font: "Material Symbols Outlined Filled",
  size: 5em/6,
  baseline: 5em/72 + offset,
  features: (("FILL": 1)),
  top-edge: "baseline",
  bottom-edge: "baseline",
  name)
#let rd-icon =  text(size: 0.95em, baseline: -1pt, font: "Romeosymbols", "a")
#let uc-logo =  box(height: 0.85em, {text(size: 1.4em,baseline: -0.05em, font: "Romeosymbols", "A"); h(-1em)})
#let romeo-sig =  text(font: "Romeosymbols", "j")