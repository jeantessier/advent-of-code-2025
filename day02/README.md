# [Day 02](https://adventofcode.com/2025/day/2)

## Puzzle 1

I went with a brute force approach.  After parsing the ranges, I check every
value against a regex.  The sample has only 106 ids to validate, and the actual
input has 2,586,319 ids to validate.

## Puzzle 2

I was able to stay with a brute force approach.  The increase in complexity was
not some expnential factor, like sometimes happens in Advent of Code.  For each
id, I checked if it was some repetition of increasingly long prefixes.

I could rule out prefixes where the length of the id was not a multiple of the
length of the prefix.  For example, the id `11111` with length 5 would not be a
repetition of `11`, which has length 2, because 5 is not a multiple of 2.
