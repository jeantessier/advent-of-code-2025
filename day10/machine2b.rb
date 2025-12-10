class Machine2b
  attr_reader :buttons, :joltages

  LINE_REGEX = /^\[(?<lights>[.#]+)\] (?<buttons>.*) \{(?<joltages>.*)\}$/

  def initialize(line)
    match = line.match(LINE_REGEX)

    num_cols = match[:lights].split('').length

    @rows = match[:buttons]
      .split
      .map do |wiring|
        wiring[1..-1]
          .split(',')
          .map(&:to_i)
          .each_with_object(Array.new(num_cols, 0)) { |i, acc| acc[i] = 1; acc }
      end

    @results = match[:joltages].split(',').map(&:to_i)

    @constraints = @rows.map do |row|
      0..row.zip(@results)
         .map { |a, b| a * b }
         .filter { |v| v > 0 }
         .min
    end
  end

  def to_s
    [
      @rows.map.with_index { |row, i| "#{row.inspect}  *  n#{i+1}" },
      "",
      @results.inspect,
      "",
      @constraints.map.with_index { |constraint, i| "n#{i+1} in #{constraint}" },
      "",
      "#{@constraints.map(&:size).reduce(&:*)} possibilities"
    ].join("\n")
  end
end
