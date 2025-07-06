#import "@romeo/romeostyle:0.0.1": *

#let colour-scheme = "crossgreen"
#let colsc = palette.at(colour-scheme)

#show: schooldoc.with(
  author: ("Dr. Ivo Robotnik"),
  section: "CC13-1J",
  subject: "Pingas",
  title: "Snooping As Usual, I See?",
  colour-scheme: colour-scheme,
  font-family: "TeX Gyre Adventor",
  flags: ("showsection"),
  paper: "longbond",
  background-desaturate: true,
  code: "32RS-TESTER"
)

#[
  #set text(size: 48pt)
#tables(
  colour-scheme: colour-scheme,
  border: true,
  columns: 5,
  stroke: none,
  mode: "h",
  alternating: "h",
  ..([#icon("eco") a],)*25
)]


#callout(
  colour-scheme: colour-scheme,
  icon: "piano",
  title: "Instructions",

)[#lorem(50)]

#example(
  colour-scheme: colour-scheme,
  icon: "lock",
)[#lorem(50)]

#definition(
  colour-scheme: colour-scheme,

)[#lorem(50)]