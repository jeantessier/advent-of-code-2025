#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/3/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 3121910778619 # 49 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 168627047606506 # (in 69 ms)

banks = lines.map { |line| line.split('').map(&:to_i) }

puts 'Banks'
puts '-----'
banks.each { |bank| puts bank.inspect }
puts

joltages = banks
  .map do |bank|
    batteries = []
    left_pos = -1
    (1..12).reverse_each do |i|
      sub_bank = bank[(left_pos+1)..(bank.size - i)]
      battery = sub_bank.max
      batteries << battery
      left_pos += sub_bank.find_index(battery) + 1
      puts "#{i}: #{sub_bank} => #{battery} (#{left_pos})"
    end
    puts batteries.inspect
    puts
    batteries
  end
  .map(&:join)
  .map(&:to_i)

puts 'Joltages'
puts '--------'
joltages.each { |joltage| puts joltage }
puts

total = joltages.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER