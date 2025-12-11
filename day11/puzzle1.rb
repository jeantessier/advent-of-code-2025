#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/11/input to download 'input.txt'.

LINE_REGEX = /^(?<source>\w+): (?<outputs>.+)$/

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true)
# ANSWER = 5 # (in 49 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 571 # (in 51 ms)

graph = lines
  .map { |line| line.match LINE_REGEX }
  .select { |match| match }
  .reduce(Hash.new { |hash, key| hash[key] = [] }) do |graph, match|
    graph[match[:source]].concat(match[:outputs].split)
    graph
  end

puts 'Graph'
puts '-----'
puts graph.inspect
puts

def depth_first_search(graph, path_so_far)
  return [path_so_far] if path_so_far.last == 'out'

  graph[path_so_far.last].reduce([]) do |acc, child|
    acc.concat(depth_first_search(graph, path_so_far + [child])) unless path_so_far.include?(child)
    acc
  end
end

paths = depth_first_search(graph, ['you'])

puts 'Paths'
puts '-----'
puts paths.inspect
puts

total = paths.size

puts "Total: #{total}"
puts "OK" if total == ANSWER
