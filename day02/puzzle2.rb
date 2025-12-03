#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/2/input to download 'input.txt'.

class Integer
  def multiple_of?(number)
    self % number == 0
  end
end

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 4174379265 # (in 40 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 58961152806 # (in 10,293 ms)

ranges = lines
  .map { |line| line.split(',') }
  .flatten
  .map { |range| range.split('-').map(&:to_i) }
  .map { |pair| pair[0]..pair[1] }

puts 'Ranges'
puts '------'
puts ranges.inspect
puts

invalid_ids = ranges
  .map do |range|
    range
      .select do |id|
        digits = id.to_s
        (1..(digits.size >> 1))
          .select { |n| digits.size.multiple_of?(n) }
          .map { |n| digits[0...n] }
          .any? { |prefix| digits =~ /^(#{prefix})+$/ }
      end
  end
  .flatten

puts 'Invalid IDs'
puts '-----------'
puts invalid_ids.inspect
puts

total = invalid_ids.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER