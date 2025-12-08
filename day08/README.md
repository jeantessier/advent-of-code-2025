# [Day 08](https://adventofcode.com/2025/day/8)

## Puzzle 1

Minimum spanning tree,
[Kruskal's algorithm](https://en.wikipedia.org/wiki/Kruskal%27s_algorithm).

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
when we have only one giant circuit.  The block I pass to `#find` can manage the
circuits as a side effect, and `#find` will return the pair that combined the
last two circuits.

Multiply the `X` coordinate of the two junction boxes in the pair to get the
answer.

## Trying to Optimize

I was looking at other people's solutions and noticed we never need the precise
distance between two junction boxes.  We only need to sort them by their
distance, so maybe there is a proxy that can preserve the order but is faster to
compute.  Most people simply remove the square root calculation.

I wondered if I could remove the exponentiation as well.  With the expression
`(x - other.x)**2`, I don't have to worry about whether `x - other.x` is
negative or positive.  Could I just use the absolute value instead?

| Method                                                              | Puzzle 1 | Puzzle 2 |
|---------------------------------------------------------------------|---------:|---------:|
| `Math.sqrt((x - other.x)**2 + (y - other.y)**2 + (z - other.z)**2)` |    579ms |    830ms |
| `[x - other.x, y - other.y, z - other.z].map { it**2 }.sum`         |    624ms |    947ms |
| `[x - other.x, y - other.y, z - other.z].map(&:abs).sum`            |    630ms |  1,082ms |
| `(x - other.x)**2 + (y - other.y)**2 + (z - other.z)**2`            |    493ms |    765ms |
| `(x - other.x).abs + (y - other.y).abs + (z - other.z).abs`         |    471ms |    894ms |

The overhead of an array with `#map` and `#sum` makes things significantly
slower.

Using `#abs` is not only slower than `#**`, it doesn't even find the expected
answer.  I haven't dug into why, but I suspect it's because of some ordering
when distances are close to one another.
