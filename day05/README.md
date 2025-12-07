# [Day 05](https://adventofcode.com/2025/day/5)

## Puzzle 1

Very simple brute force approach.  Parse Ruby ranges and integers, then use a
combination of `#select`, `#any?`, and `#include?` to find the answer.

## Puzzle 2

### Approach 1

For my first attempt, I monkey patched a `#merge` method into `Range`, then
sorted the ranges by their beginning value.  In a single pass, I look at each
range to see if it overlaps with any of the ranges seen so far.  If yes, I merge
it with the overlapping range.  If not, I add it to the list of ranges seen so
far.  This consolidates the 174 ranges with overlaps into 91 larger ranges with
no overlap.

### Approach 2

After thinking about it a little more, I realized I only needed to look at the
last range seen, since I analyze them in order of their beginning value.  If the
last range covers the new range, then I can just skip it.  If the new range
overlaps with the last range but extends past the end of it, I can create a
range for the extension and add it to the list of ranges seen so far.  In all
other cases, I just add the new range to the list.  Nil-checking method calls
take care of the initial case where there are no ranges seen yet.

One tricky situation occurs if an extension range begins after the start of the
next range to analyze.  Suppose ranges `X`, `Y`, and `Z` shown below, sorted by
their beginning values.

```
XXXXXXXXXXXX
   YYYYYYYYYYYYYYYY
      ZZZZZZZZZ
```

When analyzing `Y`, it overlaps with `X`.  We compute an extension `E` and add
_that_ to the list.

Next, we compare `Z` with `E`.

```
XXXXXXXXXXXX
            EEEEEEE
      ZZZZZZZZZ
```

There is no gap between `X` and `E`, and `Z` begins either at the beginning of
`X` or later.  If it overlaps with `E` but does not extend past the end of `E`,
then `Z` is covered by `X` and `E` together.  If `Z` does not overlaps with `E`
and does not extend past the end of `E`, then `Z` is covered by `X` alone.  If
`Z` does not overlap with `E` and extends past the end of `E`, then `Z` is
after `E` and becomes the last range seen.

This new approach requires no monkey patching, no searching the list of ranges
seen so far, and no removing from that list.  I ran each version repeatedly and
both averaged ~50 milliseconds.
