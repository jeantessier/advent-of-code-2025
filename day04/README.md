# [Day 04](https://adventofcode.com/2025/day/4)

## Puzzle 1

I applied brute force.  Loaded the map into a 2D array and iterated over all
positions.  For each position, I collected the surrounding cells in a 3x3 grid
centered on that position.  I tried to skip the position itself, but Ruby was
getting in the way.  Since I only run the logic for a cell that has a roll of
paper, I can just subtract 1 from the roll count for the 3x3 grid.

The solution is not elegant, but it works.
