# [Day 05](https://adventofcode.com/2025/day/5)

## Puzzle 1

Very simple brute force approach.  Parse Ruby ranges and integers, then use a
combination of `#select`, `#any?`, and `#include?` to find the answer.

## Puzzle 2

I monkey patched a `#merge` method into `Range`, then sorted the ranges by their
beginning value.  In a single pass, look at each range to see if it overlaps
with any of the ranges seen so far.  If yes, I merge it with the overlapping
range.  If no, I add it to the list of seen ranges.  This consolidates the 174
ranges with overlaps into 91 larger ranges with no overlap.
