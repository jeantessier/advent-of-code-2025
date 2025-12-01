#!/usr/bin/env ruby

# Login to https://adventofcode.com/2025/day/1/input to download 'input.txt'.

# lines = readlines
# lines = File.readlines('sample.txt', chomp: true) # Answer: 6 (in 38 ms)
lines = File.readlines('input.txt', chomp: true) # Answer: 6379 (in 63 ms)

rotations = lines
              .map { |line| line.split(//, 2) }
              .map do |pair|
                case pair[0]
                when 'R' then pair[1].to_i
                when 'L' then -pair[1].to_i
                end
              end

puts 'Rotations'
puts '---------'
puts rotations.inspect
puts

final_pair = rotations.reduce([50, 0]) do |pair, rotation|
  previous_position, previous_count = pair

  new_position = (previous_position + rotation) % 100

  count = rotation.abs / 100

  if rotation > 0
    delta = rotation - (count * 100)
    if new_position != (previous_position + delta)
      count += 1
    end
  end

  if rotation < 0
    delta = rotation + (count * 100)
    if previous_position != 0 && new_position != (previous_position + delta)
      count += 1
    end
    if new_position == 0 && (previous_position + delta) == 0
      count += 1
    end
  end

  new_count = previous_count + count

  puts "#{previous_position} + #{rotation} = #{previous_position + rotation} -> #{new_position} (#{count}) -> [#{new_position}, #{new_count}]"

  [new_position, new_count]
end

puts

puts 'Final Pair'
puts '----------'
puts final_pair.inspect
puts

total = final_pair[1]

puts "Total: #{total}"
