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
