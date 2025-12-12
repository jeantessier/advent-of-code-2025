# [Day 12](https://adventofcode.com/2025/day/12)

## Puzzle 1

I have no clue.

I wrote code to parse the input, but I'm drawing a blank on how to solve it.  I
feel like I need to try each permutation of shapes, and for each shape, try each
orientation and flip (up to 8 variations).  Some geometries cut down on these
variations.  For example, an `H` shape is the same when flipped and when rotated
180&deg;, so it has only two variations.

A bit of preprocessing could help.  All shapes are 3x3.  I can easily detect if
a rotation or a flip has changed the shape at all.  I can store the variations
with a shape.  When I want to validate if I can add a "shape 2" to an area, I
can try each of its variations.  There are only six 3x3 shapes in the input, it
would be faster to hard-code the variations than to automate it.
