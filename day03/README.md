# [Day 03](https://adventofcode.com/2025/day/3)

## Puzzle 1

A somewhat simple solution, using array slices and `#max`.  The tricky part was
getting the left boundary of the second slice to pick the second battery.

## Puzzle 2

I used the same approach as Puzzle 1, but with a sliding window into the battery
bank.  I shifted the sliding window 12 times, each time moving it closer and
closer to the end of the battery bank.
