# [Day 09](https://adventofcode.com/2025/day/9)

## Puzzle 1

I used some of the structures very similar to those of Day 08.  A `RedTile`
struct for the coordinates of a red tile, a `Rectangle` struct for the rectangle
between two red tiles, and `#combination(2)` to get all possible pairs of tiles.
Sort by area and take the largest.

Sorting is O(n lg n).  I could find the maximum in O(n), but I would have to
write more code.  The `#sort` method is right there.
