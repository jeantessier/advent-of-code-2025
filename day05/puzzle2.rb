#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/5/input to download 'input.txt'.

class Range
  def merge(other)
    range_begin = [self.begin, other.begin].min
    range_end = [self.exclude_end? ? self.end - 1 : self.end, other.exclude_end? ? other.end - 1 : other.end].max
    range_begin..range_end
  end
end

FRESH_RANGE_REGEX = /(?<start>\d+)-(?<end>\d+)/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 14 # 47 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 344423158480189 # (in 38 ms)

fresh_ranges = lines
  .map { |line| line.match FRESH_RANGE_REGEX }
  .select { |match| match }
  .map { |match| match[:start].to_i..match[:end].to_i }

puts "Fresh Ranges (#{fresh_ranges.size})"
puts '------------'
puts fresh_ranges.inspect
puts

merged_ranges = fresh_ranges
  .sort { |a, b| a.begin <=> b.begin }
  .reduce([]) do |merged, range|
    pos = merged.find_index { |r| r.overlap? range }
    if pos.nil?
      merged << range
    else
      merged[pos] = merged[pos].merge(range)
    end
    merged
  end

puts "Merged Ranges (#{merged_ranges.size})"
puts '-------------'
puts merged_ranges.inspect
puts

total = merged_ranges.map(&:size).sum

puts "Total: #{total}"
puts "OK" if total == ANSWER
