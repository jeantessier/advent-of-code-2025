# [Day 06](https://adventofcode.com/2025/day/6)

## Puzzle 1

Straightforward.  After splitting the lines on spaces (the default), I used
Ruby's `Array#transpose` to flip the matrix so each problem is on its own row.
I then used `Enumerable#reduce` to apply the operator to the numbers in each
row.  The `#reduce` method can take a symbol of the operator to use, and will
convert a string to a symbol for you.  So, I just gave it the last element of
the row, and it figured out the rest.

## Puzzle 2

Transposing the initial input gave me one number per row, with the problems
separated by blank lines.  The first line of each problem also contained the
symbol for the operation as the last character.  The other rows had a space
there instead, so I could use `row[..-2].join.to_i` to read each number.

I could then group "lines" into problems, one per row, with the symbol for the
operation as the first element this time.  The numbers were in reverse order,
but addition and multiplication are commutative, so I didn't have to worry about
that.

One problem I had was that my editor trimmed spaces at the end of lines, which
tripped Ruby's `#transpose` method.  I had to use `vi` to save the raw input
without trimming spaces.
