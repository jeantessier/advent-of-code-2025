#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/12/input to download 'input.txt'.

SHAPE_REGEX = /^[#.]+$/
REGION_REGEX = /^(?<width>\d+)x(?<length>\d+): (?<quantities>.+)$/

class Region
  attr_reader :width, :length, :quantities

  def initialize(width, length, quantities)
     @width = width.to_i
     @length = length.to_i
     @quantities = quantities.split.map(&:to_i)
  end
end

# lines = readlines
lines = File.readlines('sample.txt', chomp: true)
ANSWER = 2 # (in ?? ms)
# lines = File.readlines('input.txt', chomp: true)
# ANSWER = -1 # (in ?? ms)

shapes = []
current_shape = []

lines.each do |line|
  case line
  when SHAPE_REGEX
    current_shape << line
  when ''
    shapes << current_shape
    current_shape = []
  end
end

puts "Shapes (#{shapes.size})"
puts '------'
puts shapes.map { |shape| shape.join("\n") }.join("\n\n")
puts

regions = lines
  .map { |line| line.match REGION_REGEX }
  .compact
  .map { |match| Region.new(match[:width], match[:length], match[:quantities]) }

puts "Regions (#{regions.size})"
puts '-------'
puts regions.map(&:inspect)
puts

# total = paths.size
#
# puts "Total: #{total}"
# puts "OK" if total == ANSWER
