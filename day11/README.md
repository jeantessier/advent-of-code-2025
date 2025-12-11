# [Day 11](https://adventofcode.com/2025/day/11)

## Puzzle 1

A simple depth-first traversal, building a path as I go.  My IDE kept bugging me
to add a check for loops, so I did.

## Puzzle 2

I killed the direct approach after a few seconds.  We're looking for paths
`svr --> out` that pass through `dac` and `fft`.  At first, I looked for all
paths `svr --> out` and then selected those that contained both `dac` and `fft`.

There are two cases here:

    svr --> dac --> fft --> out
    svr --> fft --> dac --> out

I could look for each segment separately and just multiply their cardinalities.
But my depth-first traversal function chokes of even `svr --> dac`.

I printed the paths as it traversed them, and it seems to cross over and over
areas that don't connect to the target node, from ever slightly different path
prefixes.  I tried to maintain a set of _deadends_, but I can't seem to get it
right.
