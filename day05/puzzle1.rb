#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/5/input to download 'input.txt'.

FRESH_RANGE_REGEX = /(?<start>\d+)-(?<end>\d+)/
ID_REGEX = /^(?<id>\d+)$/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 3 # (in 39 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 505 # (in 63 ms)

fresh_ranges = lines
  .map { |line| line.match FRESH_RANGE_REGEX }
  .compact
  .map { |match| match[:start].to_i..match[:end].to_i }

puts 'Fresh Ranges'
puts '------------'
puts fresh_ranges.inspect
puts

ids = lines
  .map { |line| line.match ID_REGEX }
  .compact
  .map { |match| match[:id].to_i }

puts 'IDs'
puts '---'
puts ids.inspect
puts

fresh_ids = ids.select { |id| fresh_ranges.any? { |range| range.include? id } }

puts 'Fresh IDs'
puts '---------'
puts fresh_ids.inspect
puts

total = fresh_ids.size

puts "Total: #{total}"
puts "OK" if total == ANSWER
