#!/usr/bin/env ruby

#
# Prints my stats as a CSV.
#
#     ./stats.rb > stats.csv
# or
#     ./stats.rb | tee stats.csv
#
# It can fetch the overall stats from adventofcode.com, since they are public
# data.  But getting personal times requires authentication.  I don't know how
# to do that, so I copy my stats in this script as they become available.
#

require 'net/http'

STATS_REGEX = %r{<a href="/\d+/day/\d+">\s*(?<day>\d+)\s+<span class="stats-both">\s*(?<both>\d+)</span>\s*<span class="stats-firstonly">\s*(?<firstonly>\d+)</span>}

uri = URI.parse('https://adventofcode.com/2025/stats')
response = Net::HTTP.get_response(uri)
overall_stats = response.body
                        .lines
                        .map { |line| STATS_REGEX.match(line) }.compact
                        .map { |match| match[1..] }
                        .map { |row| row.map(&:to_i) }
                        .reduce([]) do |memo, row|
                          day = row[0]
                          first_and_second_puzzles = row[1]
                          first_puzzle_only = row[2]
                          memo[day] = {
                            finished_first_puzzle: first_and_second_puzzles + first_puzzle_only,
                            finished_second_puzzle: first_and_second_puzzles,
                          }
                          memo
                        end

# https://adventofcode.com/2025/leaderboard/self
personal_times = '''
  1   21:55:06  104725      0   22:04:35  98763      0
'''.lines
   .map(&:chomp)
   .reject { |line| line.empty? }
   .map(&:split)
   .map { |row| [row[0], row[2], row[5]] }
   .map { |row| row.map(&:to_i) }
   .map do |day, my_first_puzzle_rank, my_second_puzzle_rank|
     total_first_puzzle = overall_stats[day][:finished_first_puzzle]
     total_second_puzzle = overall_stats[day][:finished_second_puzzle]
     [
       day,
       '',
       my_first_puzzle_rank.positive? ? my_first_puzzle_rank : '',
       total_first_puzzle,
       my_first_puzzle_rank.positive? ? ((1.0 - (my_first_puzzle_rank.to_f / total_first_puzzle)) * 100).to_i : '0',
       '',
       my_second_puzzle_rank.positive? ? my_second_puzzle_rank : '',
       total_second_puzzle,
       my_second_puzzle_rank.positive? ? ((1.0 - (my_second_puzzle_rank.to_f / total_second_puzzle)) * 100).to_i : '0',
     ]
   end

File.open('stats.csv', 'w', 0644) do |f|
  f.puts 'Day,,Part 1 Rank,Part 1 Total,Part 1 Percentile,,Part 2 Rank,Part 2 Total,Part 2 Percentile'
  personal_times.each do |row|
    f.puts row.join(',')
  end
end

File.open('stats.md', 'w', 0644) do |f|
  f.puts '| Day |  | Part 1 Rank | Part 1 Total | Part 1 Percentile |  | Part 2 Rank | Part 2 Total | Part 2 Percentile |'
  f.puts '|:---:|--|:-----------:|:------------:|:-----------------:|--|:-----------:|:------------:|:-----------------:|'
  personal_times.each do |row|
    row[0] = format('[%d](day%02d)', row[0], row[0])
    f.puts '| ' + row.join(' | ') + ' |'
  end
end
