#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/10/input to download 'input.txt'.

require './machine2b'

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 33 # (in 105 ms)
lines = File.readlines('input1.txt', chomp: true)
ANSWER = -1 # (in ?? ms)

machines = lines.map { |line| Machine2b.new(line) }

puts "Machines (#{machines.size})"
puts '--------'
machines.each do |machine|
  puts machine
  puts
  puts
end
puts

# total = changes.sum
#
# puts "Total: #{total}"
# puts "OK" if total == ANSWER
