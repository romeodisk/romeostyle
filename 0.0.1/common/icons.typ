#let icon(offset: 0em, name) = text(
  font: "Material Symbols Outlined Filled",
  size: 5em/6,
  baseline: 5em/72 + offset,
  features: (("FILL": 1)),
  top-edge: "baseline",
  bottom-edge: "baseline",
  name)
#let rd-icon =  text(baseline: -1pt, font: "Romeosymbols", "a")
#let uc-logo() =  text.with(font: "Romeosymbols", "A")
#let romeo-sig() =  text.with(font: "Romeosymbols", "j")