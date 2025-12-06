#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/6/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 3263827 # (in 50 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 9077004354241 # (in 66 ms)

worksheet = lines
  .map { |line| line.split '' }
  .transpose

puts 'Worksheet'
puts '---------'
puts worksheet.map(&:inspect)
puts

problems = []
current_problem = []

worksheet.each do |row|
  if row.all? { |c| c == ' ' }
    problems << current_problem
    current_problem = []
  else
    current_problem << row[-1] if row[-1] != ' '
    current_problem << row[..-2].join.to_i
  end
end
problems << current_problem

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
