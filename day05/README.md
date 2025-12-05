# [Day 05](https://adventofcode.com/2025/day/5)

## Puzzle 1

Very simple brute force approach.  Parse Ruby ranges and integers, then use a
combination of `#select`, `#any?`, and `#include?` to find the answer.
