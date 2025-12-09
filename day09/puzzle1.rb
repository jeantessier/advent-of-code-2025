#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/9/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 50 # (in 39 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 4750176210 # (in 361 ms)

RedTile = Struct.new(:x, :y) do
  def area_between(other) = ((x - other.x).abs + 1) * ((y - other.y).abs + 1)
  def to_s = "(#{x}, #{y})"
end

Rectangle = Struct.new(:a, :b) do
  def area = @area ||= a.area_between(b)
  def to_s = "#{area}: #{a} - #{b}"
end

red_tiles = lines.map { |line| RedTile.new(*line.split(',').map(&:to_i)) }

puts 'Red Tiles'
puts '---------'
puts red_tiles
puts

rectangles = red_tiles
  .combination(2)
  .map { |pair| Rectangle.new(*pair) }
  .sort_by(&:area)
  .reverse

puts 'Rectangles'
puts '----------'
puts rectangles
puts

total = rectangles.first.area

puts "Total: #{total}"
puts "OK" if total == ANSWER
