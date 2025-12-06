# [Day 06](https://adventofcode.com/2025/day/6)

## Puzzle 1

Straightforward.  After splitting the lines on spaces (the default), I used
Ruby's `Array#transpose` to flip the matrix so each problem is on its own row.
I then used `Enumerable#reduce` to apply the operator to the numbers in each
row.  The `#reduce` method can take a symbol of the operator to use, and will
convert a string to a symbol for you.  So, I just gave it the last element of
the row, and it figured out the rest.
