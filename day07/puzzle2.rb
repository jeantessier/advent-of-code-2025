#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/7/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 40 # (in 48 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 80158285728929 # (in 67 ms)

map = lines.map { |line| line.split('') }

puts "Map"
puts "---"
puts map.map(&:join)
puts

map.each_with_index do |row, y|
  next if y.zero?
  row.each_with_index do |cell, x|
    case
    when cell == '.' && map[y-1][x] == 'S'
      map[y][x] = '|'
    when cell == '.' && map[y-1][x] == '|'
      map[y][x] = '|'
    when cell == '^' && map[y-1][x] == '|'
      map[y][x-1] = '|' if map[y][x-1] == '.'
      map[y][x+1] = '|' if map[y][x+1] == '.'
    end
  end
end

puts "Map"
puts "---"
puts map.map(&:join)
puts

y_range = 0...map.size
x_range = 0...map[0].size

map << Array.new(map[0].size, 1)

y_range.reverse_each do |y|
  x_range.each do |x|
    map[y][x] = map[y+1][x] if map[y][x] == '|'
  end
  x_range.each do |x|
    map[y][x] = map[y][x-1] + map[y][x+1] if map[y][x] == '^'
  end
end

puts "Timelines"
puts "---------"
puts map.map(&:join)
puts

S_pos = map[0].index('S')

total = map[1][S_pos]

puts "Total: #{total}"
puts "OK" if total == ANSWER
