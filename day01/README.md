# [Day 01](https://adventofcode.com/2025/day/1)

## Puzzle 1

I used simple modulo arithmetic to calculate the position after each rotation.
Modulo arithmetic in Ruby did the proper rotation when subtracting into negative
values.

## Puzzle 2

I got stuck on the special cases when landing on zero and rotating left, but not
a full rotation.  I couldn't get the special cases to work properly.

## JavaScript

The JavaScript solution is somewhat straightforward, but modulo arithmetic is
different in JavaScript.  It does not do the proper rotation when subtracting
into negative values.
