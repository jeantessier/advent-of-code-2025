class Machine
  LINE_REGEX = /^\[(?<lights>[.#]+)\] (?<buttons>.*) \{(?<joltages>.*)\}$/

  def initialize(line)
    match = line.match(LINE_REGEX)

    @indicator_lights = Array.new(match[:lights].size, false)
    @indicator_light_diagram = match[:lights].split('').map { |c| c == '#' }

    @working_lights = 0
    @target_lights = @indicator_light_diagram.map.with_index { |e, i| e ? 2**i : 0 }.sum

    @button_wirings = match[:buttons]
                        .split
                        .map { |wiring| wiring[1..-1].split(',').map(&:to_i) }

    @buttons = @button_wirings
                 .map { |wiring| wiring.map { |i| 2**i }.sum }

    @joltages = match[:joltages].split(',').map(&:to_i)
  end

  def find_shortest_initialization_sequence
    (1..@buttons.size).find do |i|
      (0...@buttons.size).to_a.permutation(i).any? do |sequence|
        reset!
        # puts "Trying sequence #{sequence.inspect}"
        press_buttons *sequence
        done?
      end
    end
  end

  def press_buttons(*buttons)
    buttons.each { |button| press_button(button) }
  end

  def press_button(button)
    @working_lights ^= @buttons[button]
  end

  def reset!
    @working_lights = 0
  end

  def done?
    @working_lights == @target_lights
  end

  def to_s
    "machine with #{@indicator_lights.size} indicator lights #{done? ? '** ' : ''}#{@working_lights} => #{@target_lights}#{done? ? ' **' : ''} and #{@button_wirings.size} button wirings #{@buttons.inspect}"
  end
end
