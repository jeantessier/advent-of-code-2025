# [Day 08](https://adventofcode.com/2025/day/8)

## Puzzle 1

The input file has 1,000 junction boxes.  That makes for 1,000,000 possible
paths.

Sort 1,000,000 paths by straight line distance, take the shortest `N` (10 for
the sample, 1,000 for the input), then start building circuits.

I started with a bunch of circuits, each of size 1, then went through the
selected shortest paths.  If the two ends are in different circuits, merge the
circuits.

Sort the circuits by size, take the top 3, and multiply their sizes together.

## Puzzle 2

Remove the reins and use `Enumerable#find` to combine the circuits, stopping
when we have only one giant circuit.  `#find` returns the pair that combined the
last two circuits.

Multiply the `X` coordinate of the two junction boxes in the pair to get the
answer.
