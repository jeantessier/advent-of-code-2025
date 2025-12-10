#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/10/input to download 'input.txt'.

require './machine'

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 7 # (in 44 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 396 # (in 153 ms)

machines = lines.map { |line| Machine.new(line) }

puts "Machines (#{machines.size})"
puts '--------'
puts machines
puts

# machines[0].press_buttons 0, 1, 2
# machines[0].press_buttons 4, 5
# machines[1].press_buttons 2, 3, 4
# machines[2].press_buttons 1, 2

# puts "Machines (#{machines.size})"
# puts '--------'
# puts machines
# puts

sequence_lengths = machines.map(&:find_shortest_initialization_sequence)

puts 'Sequence lengths'
puts '----------------'
puts sequence_lengths.inspect
puts

total = sequence_lengths.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER
