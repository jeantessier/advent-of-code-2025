#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/11/input to download 'input.txt'.

LINE_REGEX = /^(?<source>\w+): (?<outputs>.+)$/

# lines = readlines
# lines = File.readlines('sample1.txt', chomp: true)
# ANSWER = 5 # (in 35 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = 571 # (in 40 ms)

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

def depth_first_search(graph, path_so_far, target = 'out')
  return [path_so_far] if path_so_far.last == target

  (graph[path_so_far.last] - path_so_far).reduce([]) do |acc, child|
    acc.concat(depth_first_search(graph, path_so_far + [child], target))
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
