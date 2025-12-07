#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/7/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 21 # (in 46 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 1541 # (in 63 ms)

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

active_splitters = map.map.with_index do |row, y|
  if y.zero?
    0
  else
    row
      .map.with_index do |cell, x|
        (cell == '^' && map[y-1][x] == '|') ? 1 : 0
      end
      .sum
  end
end

puts "Active Splitters"
puts "----------------"
puts active_splitters.inspect
puts

total = active_splitters.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER
