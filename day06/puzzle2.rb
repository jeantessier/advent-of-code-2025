#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/6/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 3263827 # (in 50 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 9077004354241 # (in 71 ms)

worksheet = lines
  .map { |line| line.split '' }
  .transpose

puts 'Worksheet'
puts '---------'
puts worksheet.map(&:inspect)
puts

problems = worksheet
  .chunk { |row| row.all? { |c| c == ' ' } } # group into "paragraphs" separated by blank lines
  .filter { |pair| !pair[0] } # remove separators
  .map { |pair| pair[1] } # keep only the paragraphs themselves
  .map do |problem| # convert each paragraph into a problem: operation and numbers
    [problem[0].last] + problem.map { |number| number[..-2] }.map(&:join).map(&:to_i)
  end

puts 'Problems'
puts '--------'
puts problems.map(&:inspect)
puts

answers = problems.map do |problem|
  problem[1..].reduce(problem[0])
end

puts 'Answers'
puts '-------'
puts answers.inspect
puts

total = answers.sum

puts "Total: #{total}"
puts "OK" if total == ANSWER
