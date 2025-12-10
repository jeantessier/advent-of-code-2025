# [Day 10](https://adventofcode.com/2025/day/10)

## Puzzle 1

I created a class `Machine` to represent the machine.  Its constructor takes
care of parsing the input line.  The indicator lights and the indicator light
diagram are bitmasks, so I use an integer as my working copy.  The pattern
`[.##.]` is the binary number `b0110`, or decimal `6`.  Each button wiring
schematic is also a bitmask.  I also convert them to integers.  I then try
increasingly long permutations of the buttons to see if any permutation of
length `N` can yield the indicator light diagram by XORing the bitmasks
together.  I use Ruby's `Array#permutation`, `Enumerable#find`, and
`Enumerable#any?` to drive the search.  I use Ruby's `Enumerable#reduce` to XOR
values together.

## Puzzle 2

I first, I thought I could treat it like the making change problem: find the
smallest number of coins that add up to a given target.  The buttons gave me the
coins and the joltages gave me the target.  But that didn't work.

I went down a rabbit hole of seeing which button contributes to which joltage
and trying successive combinations of buttons.  It eventually found the
solutions to the sample problems, but it timed out on the real input.  The
samples consider a few thousands of combinations, the first real input has to
consider over 500 billion of them.

I wrote the first sample problem on paper.  Pressing the first button `n1`
times, then the second button `n2` times, etc.

```
[0, 0, 0, 1]  *  n1
[0, 1, 0, 1]  *  n2
[0, 0, 1, 0]  *  n3
[0, 0, 1, 1]  *  n4
[1, 0, 1, 0]  *  n5
[1, 1, 0, 0]  *  n6

[3, 5, 4, 7]
```

I had a quick chat with ClaudeAI to confirm that I could not easily compute the
inverse vector-matrix multiplication.  But I can infer constraints on `n1`
through `n6`.

```
n1 in 0..7
n2 in 0..5
n3 in 0..4
n4 in 0..4
n5 in 0..3
n6 in 0..3
```

That's 19,200 combinations for this machine.  The first real machine had
655,720,301,808 combinations.  ClaudeAI referenced _Backtracking search with
constraint propagation_ as a way to solve this problem.  It requires
reconsidering the constraints as we try different combinations.  I'm not sure
how to track that.

It's been 7 hours since I started this puzzle.  I'm going to go get some sleep.

## Tests

I wrote some tests to help me nail down the logic.  You can run them with:

```bash
./bin/rspec specs
```

Or see the full list of tests with:

```bash
./bin/rspec --format documentation specs

> You may need to install RSpec with:
>
> ```bash
> bundle install
> bundle binstubs --all
> ```
