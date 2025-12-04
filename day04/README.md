# [Day 04](https://adventofcode.com/2025/day/4)

## Puzzle 1

I applied brute force.  Loaded the map into a 2D array and iterated over all
positions.  For each position, I collected the surrounding cells in a 3x3 grid
centered on that position.  I tried to skip the position itself, but Ruby was
getting in the way.  Since I only run the logic for a cell that has a roll of
paper, I can just subtract 1 from the roll count for the 3x3 grid.

The solution is not elegant, but it works.

## Puzzle 2

The decision to focus on `@` characters and ignore everything else paid off.  By
replacing "accessible" `@`s with `x`s, it effectively removes them from the
board.  I can keep running the logic on successive boards until I am not
removing any more rolls of paper.  This is either because all the remaining
rolls are inacessible, or there are not more rolls left.  Either way, I'm
guaranteed to stop.

I left copious traces and printed the entire board after each iteration.  The
script took over 1,500 milliseconds to run.  It cuts down to ~700 milliseconds
with the traces removed.
