#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/1/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true) # Answer: 3 (in 42 ms)
lines = File.readlines('input.txt', chomp: true) # Answer: 1076 (in 71 ms)

rotations = lines
              .map { |line| line.split(//, 2) }
              .map do |pair|
                case pair[0]
                when 'R' then pair[1].to_i
                when 'L' then -pair[1].to_i
                end
              end

puts 'Rotations'
puts '---------'
puts rotations.inspect
puts

positions = rotations
  .reduce([50]) do |acc, rotation|
    acc << (acc.last + rotation) % 100
    acc
  end

puts 'Positions'
puts '---------'
puts positions.inspect
puts

total = positions.select { |pos| pos == 0 }.size

puts "Total: #{total}"
