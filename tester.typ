#import "@romeo/romeostyle:0.0.1": *

#let colour-scheme = "red"
#let colsc = palette.at(colour-scheme, default: palette.at("default"))

#show: schooldoc.with(
  author: ("Dr. Ivo Robotnik"),
  section: "CC13-1J",
  subject: "Pingas",
  title: "Snooping As Usual, I See?",
  colour-scheme: colour-scheme,
  font-family: "TeX GYre Pagella",
  flags: ("showsection"),
  paper: "longbond",
  background-desaturate: true,
  code: "32RS-TESTER"
)

#callout(
  colour-scheme: colour-scheme,
  icon: "piano",
  title: "Instructions",
)[#lorem(50)]

#example(
  colour-scheme: colour-scheme,
  icon: "graph_3",
)[#lorem(50)]

#definition(
  colour-scheme: colour-scheme,

)[#lorem(50)]