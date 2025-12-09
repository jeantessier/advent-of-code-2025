# [Day 09](https://adventofcode.com/2025/day/9)

## Puzzle 1

I used some of the structures very similar to those of Day 08.  A `RedTile`
struct for the coordinates of a red tile, a `Rectangle` struct for the rectangle
between two red tiles, and `#combination(2)` to get all possible pairs of tiles.
Sort by area and take the largest.

Sorting is O(n lg n).  I could find the maximum in O(n), but I would have to
write more code.  The `#sort` method is right there.

## Puzzle 2

My first intuition: for each possiblerectangle, see if any of its sides
intersects any segment of the perimeter.  See if any segment of the perimeter
goes inside it.

I spent a lot of time trying to determine if a segment intersects a rectangle.

```
             S1   S2      S3
             |    |       |
      /------+----+---\   |
      |      |    |   |   |
      |      |    S2  |   |
      |      |        |   |
      \------+--------/   |
        S4   |            |
        |    |            S3
        S4   S1
```

I was drafting some of the conditions, but after three hours of tinkering, I
still wasn't sure if I had them all.  Plus, I was getting tired.  I was messing
around with ranges, and it all got a bit confusing.  Until I switched strategy
and only worked with min/max of X and min/max of Y instead.  I ended up
consulting the Internet to check on
[overlapping rectangles](https://stackoverflow.com/questions/306316/determine-if-two-rectangles-overlap-each-other).
It reassured me that I was basically there.

I had written some tests to check the various possibilities of segments crossing
a rectangle or not.

I can sort the rectangles by area and work my way down from the largest, until I
find one that does not intersect the perimeter.  Of course, the first time I
tried it, I had forgotten to save the rectangle that I had found, and I used the
largest rectangle instead.  Silly me!
