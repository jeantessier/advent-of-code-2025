require_relative 'constraint'
require_relative 'constraint_set'

class Machine2
  attr_reader :constraint_set

  LINE_REGEX = /^\[(?<lights>[.#]+)\] (?<buttons>.*) \{(?<joltages>.*)\}$/

  def initialize(line)
    match = line.match(LINE_REGEX)

    totals = match[:joltages].split(',').map(&:to_i)

    bottons = match[:buttons]
             .split
             .map { |wiring| wiring[1...-1] }
             .map { |wiring| wiring.split(',') }
             .map { |wiring| wiring.map(&:to_i) }


    constraints = totals
      .map.with_index do |total, i|
        Constraint.new(
          variables: buttons.map { |button| button.include?(i) ? 0..total : nil  },
          total: total,
        )
      end
      .uniq



    initial_ranges = rows.map do |row|
      top = row.zip(totals)
               .map { |a, b| a * b }
               .filter { |v| v > 0 }
               .min
      0..top
    end

    constraints = (0...num_cols)
      .map do |col|
        Constraint.new(
          variables: rows.map.with_index { | row, i | row[col] > 0 ? initial_ranges[i] : nil },
          total: totals[col],
        )
      end

    @constraint_set = ConstraintSet.new(*constraints)
  end

  def to_s
    [
      @constraint_set.to_s,
      "num_pos: #{@constraint_set.num_pos}",
      "valid?: #{@constraint_set.valid?}",
    ].join("\n")
  end
end
