#!/usr/bin/env ruby

require './red_tile'
require './rectangle'

# Login to https://adventofcode.com/2025/day/9/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 24 # (in 44 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 1574684850 # (in 2,086 ms)

red_tiles = lines.map { |line| RedTile.new(*line.split(',').map(&:to_i)) }

puts "Red Tiles (#{red_tiles.size})"
puts '---------'
puts red_tiles.take(10)
puts "..."
puts

perimeter = red_tiles
  .each_cons(2)
  .map { |pair| Rectangle.new(*pair) }

perimeter << Rectangle.new(red_tiles.last, red_tiles.first)

puts "Perimeter (#{perimeter.size})"
puts '---------'
puts perimeter.take(10)
puts "..."
puts

rectangles = red_tiles
  .combination(2)
  .map { |pair| Rectangle.new(*pair) }
  .sort_by(&:area)
  .reverse

puts "Rectangles (#{rectangles.size})"
puts '----------'
puts rectangles.take(10)
puts "..."
puts

largest_rectangle = rectangles.find do |rectangle|
  perimeter.none? { |segment| rectangle.intersects?(segment) }
end

puts 'Largest Rectangle'
puts '-----------------'
puts largest_rectangle
puts

total = largest_rectangle.area

puts "Total: #{total}"
puts "OK" if total == ANSWER
