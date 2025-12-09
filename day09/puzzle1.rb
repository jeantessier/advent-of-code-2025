#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/9/input to download 'input.txt'.

require './red_tile'
require './rectangle'

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 50 # (in 39 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 4750176210 # (in 95 ms)

red_tiles = lines.map { |line| RedTile.new(*line.split(',').map(&:to_i)) }

puts 'Red Tiles'
puts '---------'
puts red_tiles.take(10)
puts "..."
puts

rectangles = red_tiles
  .combination(2)
  .map { |pair| Rectangle.new(*pair) }
  .sort_by(&:area)
  .reverse

puts 'Rectangles'
puts '----------'
puts rectangles.take(10)
puts "..."
puts

total = rectangles.first.area

puts "Total: #{total}"
puts "OK" if total == ANSWER
