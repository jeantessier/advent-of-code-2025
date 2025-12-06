#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/5/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 4277556 # (in 35 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 4364617236318 # (in 56 ms)

problems = lines.map(&:split).transpose

puts 'Problems'
puts '--------'
problems.each { |problem| puts problem.inspect }
puts

answers = problems.map do |problem|
  problem[0..-2]
    .map(&:to_i)
    .reduce(problem[-1])
end

puts 'Answers'
puts '-------'
puts answers.inspect
puts

total = answers.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER
