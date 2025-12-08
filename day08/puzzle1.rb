#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/8/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# NUMBER_OF_PAIRS = 10
# ANSWER = 40 # (in 49 ms)
lines = File.readlines('input.txt', chomp: true)
NUMBER_OF_PAIRS = 1000
ANSWER = 72150 # (in 579 ms)

JunctionBox = Struct.new(:x, :y, :z) do
  def distance_to(other)
    # Math.sqrt((x - other.x)**2 + (y - other.y)**2 + (z - other.z)**2)
    # We only use distance in sorting, so we don't need exact distance.
    (x - other.x)**2 + (y - other.y)**2 + (z - other.z)**2
  end

  def to_s
    "(#{x}, #{y}, #{z})"
  end
end

JunctionBoxPair = Struct.new(:a, :b) do
  def distance
    @distance ||= a.distance_to(b)
  end

  def to_s
    "#{distance}: #{a} - #{b}"
  end
end

junction_boxes = lines
  .map { |line| line.split(',') }
  .map { |coords| coords.map(&:to_i) }
  .map { |coords| JunctionBox.new(*coords) }

puts 'Junction Boxes'
puts '--------------'
puts junction_boxes
puts

junction_box_pairs = junction_boxes
  .combination(2)
  .map { |pair| JunctionBoxPair.new(*pair) }
  .sort_by(&:distance)
  .take(NUMBER_OF_PAIRS)

puts 'Junction Box Pairs'
puts '------------------'
puts junction_box_pairs
puts

circuits = junction_boxes
  .map { |junction_box| [junction_box] }

junction_box_pairs.each do |junction_box_pair|
  circuit_a = circuits.index { |circuit| circuit.include?(junction_box_pair.a) }
  circuit_b = circuits.index { |circuit| circuit.include?(junction_box_pair.b) }

  if circuit_a != circuit_b
    circuits[circuit_a].concat(circuits[circuit_b])
    circuits.delete_at(circuit_b)
  end
end

puts 'Circuits'
puts '--------'
circuits.each do |circuit|
  puts "(#{circuit.size}) #{circuit.join(',')}"
end
puts

top_sizes = circuits
  .map(&:size)
  .sort
  .reverse
  .take(3)

puts 'Top 3 Largest Circuit Sizes'
puts '---------------------------'
puts top_sizes.inspect
puts

total = top_sizes.reduce(:*)

puts "Total: #{total}"
puts "OK" if total == ANSWER
