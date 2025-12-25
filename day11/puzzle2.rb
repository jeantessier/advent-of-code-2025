#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/11/input to download 'input.txt'.

LINE_REGEX = /^(?<source>\w+): (?<outputs>.+)$/

# lines = readlines
# lines = File.readlines('sample2.txt', chomp: true)
# ANSWER = 2 # (in 35 ms)
lines = File.readlines('input.txt', chomp: true)
ANSWER = -1 # (in ?? ms)

graph = lines
  .map { |line| line.match LINE_REGEX }
  .compact
  .reduce(Hash.new { |hash, key| hash[key] = [] }) do |graph, match|
    graph[match[:source]].concat(match[:outputs].split)
    graph
  end

puts 'Graph'
puts '-----'
puts graph.inspect
puts

def depth_first_search(graph, path_so_far, target = 'out', deadends = Set.new)
  puts "path_so_far: #{path_so_far.size} [#{path_so_far.join(',')}]"
  return [path_so_far] if path_so_far.last == target

  paths_from_children = (graph[path_so_far.last] - path_so_far).filter { |child| !deadends.include?(child) }.map do |child|
    [child, depth_first_search(graph, path_so_far + [child], target, deadends)]
  end

  deadends.merge(paths_from_children.select { |_, paths| paths.empty? }.select(&:first))

  paths_from_children.select { |_, paths| !paths.empty? }.select(&:last).reduce([], :concat)

  # (graph[path_so_far.last] - path_so_far).reduce([]) do |acc, child|
  #   acc.concat(depth_first_search(graph, path_so_far + [child], target))
  #   acc
  # end
end

puts '*** svr --> dac'
svr_to_dac = depth_first_search(graph, ['svr'], 'dac')
puts "    #{svr_to_dac.size}"
puts '*** svr --> dac --> fft'
dac_to_fft = depth_first_search(graph, ['dat'], 'fft')
puts "    #{dac_to_fft.size}"
puts '*** svr --> dac --> fft --> out'
fft_to_out = depth_first_search(graph, ['fft'], 'out')
puts "    #{fft_to_out.size}"
puts
puts '*** svr --> fft'
svr_to_fft = depth_first_search(graph, ['svr'], 'fft')
puts "    #{svr_to_fft.size}"
puts '*** svr --> fft --> dac'
fft_to_dac = depth_first_search(graph, ['fft'], 'dac')
puts "    #{fft_to_dac.size}"
puts '*** svr --> fft --> dac --> out'
dac_to_out = depth_first_search(graph, ['dac'], 'out')
puts "    #{dac_to_out.size}"

puts 'Paths'
puts '-----'
puts "svr --#{svr_to_dac.size}--> dac --#{dac_to_fft.size}--> fft --#{fft_to_out.size}--> out: #{svr_to_dac.size * dac_to_fft.size * fft_to_out.size}"
puts "svr --#{svr_to_fft.size}--> fft --#{fft_to_dac.size}--> dac --#{dac_to_out.size}--> out: #{svr_to_fft.size * fft_to_dac.size * dac_to_out.size}"
puts

total = (svr_to_dac.size * dac_to_fft.size * fft_to_out.size) + (svr_to_fft.size * fft_to_dac.size * dac_to_out.size)

puts "Total: #{total}"
puts "OK" if total == ANSWER
