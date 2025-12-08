#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/8/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 25272 # 50 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 3926518899 # (in 830 ms)

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

puts 'Junction Box Pairs'
puts '------------------'
puts junction_box_pairs.take(10)
puts "..."
puts

circuits = junction_boxes
  .map { |junction_box| [junction_box] }

final_pair = junction_box_pairs.find do |junction_box_pair|
  circuit_a = circuits.index { |circuit| circuit.include?(junction_box_pair.a) }
  circuit_b = circuits.index { |circuit| circuit.include?(junction_box_pair.b) }

  if circuit_a != circuit_b
    circuits[circuit_a].concat(circuits[circuit_b])
    circuits.delete_at(circuit_b)
  end

  circuits.size == 1
end

puts 'Final Pair'
puts '----------'
puts final_pair
puts

total = final_pair.a.x * final_pair.b.x

puts "Total: #{total}"
puts "OK" if total == ANSWER
