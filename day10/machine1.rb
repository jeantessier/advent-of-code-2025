class Machine1
  LINE_REGEX = /^\[(?<lights>[.#]+)\] (?<buttons>.*) \{(?<joltages>.*)\}$/

  def initialize(line)
    match = line.match(LINE_REGEX)

    @indicator_light_diagram = match[:lights]
      .split('')
      .map { |c| c == '#' }

    @target_lights = @indicator_light_diagram
      .map.with_index { |e, i| e ? 2**i : 0 }
      .sum

    @buttons = match[:buttons]
      .split
      .map do |wiring|
      wiring[1..-1]
        .split(',')
        .map(&:to_i)
        .map { |i| 2**i }
        .sum
      end
  end

  def find_shortest_initialization_sequence
    (1..@buttons.size).find do |i|
      @buttons.permutation(i).any? do |sequence|
        sequence.reduce(0) { |acc, button| acc ^ button } == @target_lights
      end
    end
  end

  def to_s
    "machine with #{@indicator_light_diagram.size} indicator lights => #{@target_lights} and #{@buttons.size} button wirings #{@buttons.inspect}"
  end
end
