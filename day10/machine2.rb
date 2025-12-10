class Machine2
  attr_reader :buttons, :joltages

  LINE_REGEX = /^\[(?<lights>[.#]+)\] (?<buttons>.*) \{(?<joltages>.*)\}$/

  def initialize(line)
    match = line.match(LINE_REGEX)

    @joltages = match[:joltages].split(',').map(&:to_i)

    @buttons = match[:buttons]
      .split
      .map do |wiring|
        wiring[1..-1]
          .split(',')
          .map(&:to_i)
          .each_with_object(Array.new(@joltages.size, 0)) { |i, acc| acc[i] = 1; acc }
      end

    @cache = {}
  end

  def make_change(joltages = @joltages, buttons = @buttons, level = 0)
    # return @cache[joltages] if @cache.key?(joltages)
    return @cache[joltages] = 0 if joltages.sum == 0

    puts "  "*level + "target: #{joltages}, buttons: #{buttons.inspect}"

    # find all buttons that are candidates, i.e., don't increase an unwanted counter
    button, *other_buttons = buttons.filter { |button| is_candidate?(joltages, button) }
    puts "  "*level + "button: #{button}  ==>  #{other_buttons.inspect}"
    return @cache[joltages] = nil if button.nil?

    # Figure out the maximum number of times we can push that button
    q = joltages.zip(button).find_all { |_, b| b > 0 }.map { |a, _| a }.min
    # return @cache[joltages] = q if target == multiply_joltages(button, q)

    attempts = (0..q)
      .map do |i|
        new_target = subtract_joltages(joltages, multiply_joltages(button, i))

        puts "  "*level + "*** attempting #{i}x#{button} + make_change(#{new_target}, #{other_buttons.inspect})"
        attempt = make_change(new_target, other_buttons, level + 1)
        puts "  "*level + "*** attempted  #{i}x#{button} + make_change(#{new_target}, #{other_buttons.inspect}): #{attempt}"

        i + attempt unless attempt.nil?
    end

    result = attempts
      .find_all { it }
      .min

    puts "  "*level + "*** attempts: #{attempts.inspect} => #{result}"

    @cache[joltages] =result
  end

  def crank_joltages(joltages = @joltages, pushes_so_far = 0, max_pushes = Float::INFINITY)
    puts "  "*pushes_so_far + "#{joltages.inspect} with #{pushes_so_far} so far (max #{max_pushes})..."
    return @cache[joltages] if @cache.key?(joltages) && @cache[joltages] + pushes_so_far >= max_pushes
    return @cache[joltages] = Float::INFINITY if pushes_so_far >= max_pushes
    return @cache[joltages] = pushes_so_far + 1 if @buttons.include?(joltages)
    # return Float::INFINITY if pushes_so_far >= max_pushes
    # return pushes_so_far + 1 if @buttons.include?(joltages)

    button_candidates = @buttons.filter { |button| is_candidate?(joltages, button) }

    return @cache[joltages] = Float::INFINITY if button_candidates.empty?
    # return Float::INFINITY if button_candidates.empty?

    partial = button_candidates
      .reduce(max_pushes) do |max, button|
        puts "  "*pushes_so_far + "attempt #{button.inspect}..."
        attempt = crank_joltages(subtract_joltages(joltages, button), pushes_so_far + 1, max)
        new_max = [attempt, max].min
        puts "  "*pushes_so_far + "new max is #{new_max}" if max != new_max
        new_max
      end

    @cache[joltages] = partial
    # partial
  end

  def to_s
    "machine with #{@buttons.size} buttons #{@buttons.inspect} and joltages #{@joltages.inspect}"
  end

  private

  def starting_joltages = Array(@joltages.size, 0)
  def add_joltages(joltages, deltas) = joltages.zip(deltas).map { |joltage, delta| joltage + delta }
  def subtract_joltages(joltages, deltas) = joltages.zip(deltas).map { |joltage, delta| joltage - delta }
  def multiply_joltages(joltages, factor) = joltages.map { |joltage| joltage * factor }
  def is_candidate?(joltages, button) = joltages.zip(button).all? { |joltage_counter, button_counter| joltage_counter >= button_counter }
end
