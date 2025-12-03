#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/3/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 357 # 45 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 16946 # (in 57 ms)

banks = lines.map { |line| line.split('').map(&:to_i) }

puts 'Banks'
puts '-----'
banks.each { |bank| puts bank.inspect }
puts

joltages = banks
  .map do |bank|
    left_battery = bank[...-1].max
    left_pos = bank.find_index(left_battery)
    right_battery = bank[(left_pos+1)..].max
    left_battery * 10 + right_battery
  end

puts 'Joltages'
puts '--------'
joltages.each { |joltage| puts joltage }
puts

total = joltages.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER