#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/2/input to download 'input.txt'.

INVALID_ID_REGEX = /^(\d+)\1$/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 4174379265 # (in 41 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 58961152806 # (in 11,606 ms)

ranges = lines
  .map { |line| line.split(',') }
  .flatten
  .map { |range| range.split('-').map(&:to_i) }
  .map { |pair| pair[0]..pair[1] }

puts 'Ranges'
puts '------'
puts ranges.inspect
puts

ids = ranges
        .map(&:to_a)
        .flatten
        .map(&:to_s)

puts 'IDs'
puts '---'
puts ids.inspect
puts

invalid_ids = ids
  .select do |id|
    (1..(id.size >> 1))
      .select { |n| (id.size / n) == (id.size / (n.to_f)) }
      .map { |n| id[0...n] }
      .any? { |prefix| id =~ /^(#{prefix})+$/ }
  end
  .map(&:to_i)

puts 'Invalid IDs'
puts '-----------'
puts invalid_ids.inspect
puts

total = invalid_ids.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER