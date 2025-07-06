#import "basecolours.typ": tailwind
#let daterender(date) = {}
#let weekdays = ("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun");
#let daycolours = (
  gradient.linear(angle: 90deg, tailwind.blue-300.transparentize(70%), tailwind.blue-300.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.red-300.transparentize(70%), tailwind.red-300.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.green-300.transparentize(70%), tailwind.green-300.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.yellow-200.transparentize(70%), tailwind.yellow-200.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.cyan-200.transparentize(70%), tailwind.cyan-200.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.fuchsia-200.transparentize(70%), tailwind.fuchsia-200.transparentize(30%)),
  gradient.linear(angle: 90deg, tailwind.gray-300.transparentize(70%), tailwind.gray-300.transparentize(30%)),
)

#let datecoloursquare(date, font-size) = {
  return box(inset: (y: -1em / 6), rect(
    inset: 1em / 6,
    height: font-size,
    width: auto,
    fill: daycolours.at(date.weekday() - 1),
    radius: 1em / 12,
    stroke: none,
  )[
    #show: align.with(horizon + center)
    #set text(5em / 6, weight: 900)
    #smallcaps(weekdays.at(date.weekday() - 1))
  ])
}
