#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/5/input to download 'input.txt'.

FRESH_RANGE_REGEX = /(?<start>\d+)-(?<end>\d+)/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 14 # 47 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 344423158480189 # (in 50 ms)

fresh_ranges = lines
  .map { |line| line.match FRESH_RANGE_REGEX }
  .compact
  .map { |match| match[:start].to_i..match[:end].to_i }

puts "Fresh Ranges (#{fresh_ranges.size})"
puts '------------'
puts fresh_ranges.inspect
puts

merged_ranges = fresh_ranges
  .sort { |a, b| a.begin <=> b.begin }
  .reduce([]) do |merged, range|
    case
    when merged[-1]&.cover?(range) then # Nothing to do
    when merged[-1]&.overlap?(range) then merged << ((merged[-1].end + 1)..range.end) if merged[-1].end < range.end
    else merged << range
    end
    merged
  end

puts "Merged Ranges (#{merged_ranges.size})"
puts '-------------'
puts merged_ranges.inspect
puts

total = merged_ranges.sum(&:size)

puts "Total: #{total}"
puts "OK" if total == ANSWER
