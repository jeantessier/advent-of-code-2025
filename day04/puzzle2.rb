#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/4/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 43 # 55 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 9194 # (in 1,595 ms)

map = lines.map do |line|
  line.split('')
end

puts "Map"
puts "---"
map.each { |row| puts row.join }
puts

X_RANGE = 0...map.size
Y_RANGE = 0...map[0].size

def is_valid_position?(x, y)
  X_RANGE.include?(x) && Y_RANGE.include?(y)
end

def remove_accessible_rolls(map)
  map.map.with_index do |row, x|
    row.map.with_index do |cell, y|
      next cell unless cell == '@'

      neighbors = []
      [-1, 0, 1].each do |dx|
        [-1, 0, 1].each do |dy|
          neighbors << map[x + dx][y + dy] if (dx || dy) && is_valid_position?(x + dx, y + dy)
        end
      end

      num_neighbors = neighbors.count { |n| n == '@' } - 1 # Remove self from count

      puts "Neighbors of @#{x},#{y}: (#{num_neighbors}) #{neighbors.inspect}"

      next 'x' if num_neighbors < 4

      next cell
    end
  end
end

def score(map)
  map.sum { |row| row.count('x') }
end

old_score = -1
new_score = score(map)

while old_score != new_score
  map = remove_accessible_rolls(map)
  old_score = new_score
  new_score = score(map)

  puts "Map"
  puts "---"
  map.each { |row| puts row.join }
  puts
end

total = new_score

puts "Total: #{total}"
puts "OK" if total == ANSWER
