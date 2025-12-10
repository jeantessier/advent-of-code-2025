# [Day 10](https://adventofcode.com/2025/day/10)

## Puzzle 1

I created a class `Machine` to represent the machine.  Its constructor takes
care of parsing the input line.  The indicator lights and the indicator light
diagram are bitmasks, so I use an integer as my working copy.  The pattern
`[.##.]` is the binary number `b0110`, or decimal `6`.  Each button wiring
schematic is also a bitmask.  I also convert them to integers.  I then try
increasingly long permutations of the buttons to see if any permutation of
length `N` can yield the indicator light diagram by XORing the bitmasks
together.  I use Ruby's `Array#permutation`, `Enumerable#find`, and
`Enumerable#any?` to drive the search.  I use Ruby's `Enumerable#reduce` to XOR
values together.
