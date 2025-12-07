# [Day 07](https://adventofcode.com/2025/day/7)

## Puzzle 1

A beam is split when it reaches a splitter.  I can trace the beam through the
manifold, then count the number of splitters with a beam just above them.

I can do the tracing in one pass, moving down the manifold.  If a location is
empty and the location directly above it is a beam (or `S`), then the location
becomes a beam.  If a location is a splitter and the location directly above it
is a beam (or `S`), then the locations to the left and right if the splitter
become beams, if they were empty.

In a second pass, I can count the number of splitters with a beam directly above
them.

## Puzzle 2

Once I have the map of the paths through the manifold from Puzzle 1, I can work
backwards from the exit of the manifold.

Rather than treating the exit row of the manifold as a special case, I added a
virtual row to my map with `1` in all locations.

Now, looking at each row from the bottom up, if a location is a beam `|`, I
replace it with the value directly below it.  After replacing all the beams, I
go through the row a second time and if a location is a splitter `^`, I replace
it with the sum of the values directly to the left and the right of it.

By the time I'm done, the location just below the entrance `S` has the total
number of ~~paths~~ timelines through the manifold.

I feel there is a depth-first traversal algorithm that could be used here.  It
could use recursion to follow each path and add them up when it backtracks.
