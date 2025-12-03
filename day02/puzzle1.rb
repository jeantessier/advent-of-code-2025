#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/2/input to download 'input.txt'.

INVALID_ID_REGEX = /^(\d+)\1$/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 1227775554 # (in 49 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 38310256125 # (in 930 ms)

ranges = lines
  .map { |line| line.split(',') }
  .flatten
  .map { |range| range.split('-').map(&:to_i) }
  .map { |pair| pair[0]..pair[1] }

puts 'Ranges'
puts '------'
puts ranges.inspect
puts

invalid_ids = ranges
  .map { |range| range.select { |id| id.to_s =~ INVALID_ID_REGEX } }
  .flatten

puts 'Invalid IDs'
puts '-----------'
puts invalid_ids.inspect
puts

total = invalid_ids.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER