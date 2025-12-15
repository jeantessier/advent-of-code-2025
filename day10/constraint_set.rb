class ConstraintSet
  attr_accessor :constraints

  def initialize(*constraints)
    @constraints = []
    constraints.each { |constraint| self << constraint }
  end

  def <<(constraint)
    @constraints << constraint unless @constraints.include?(constraint)
  end

  def +(variation)
    ConstraintSet.new(*(@constraints.map { it + variation }.filter { it.num_vars > 0 }))
  end

  def restrict_variables
    ConstraintSet.new(*@constraints).restrict_variables!
  end

  def restrict_variables!
    (0...constraints.first.variables.size).each do |variable|
      restrictions = constraints.map { |constraint| constraint.variables[variable] }.reject(&:nil?)
      strictest_restriction = (restrictions.map(&:begin).max)..(restrictions.map(&:end).min)
      constraints
        .reject { |constraint| constraint.variables[variable].nil? }
        .each do |constraint|
          constraint.variables[variable] = strictest_restriction
        end
    end

    self
  end

  def constraints_by_number_of_variables = @constraints.group_by(&:num_vars)

  def variables_by_impact
    @constraints.reduce(Hash.new(0)) do |acc, constraint|
      constraint.variables.each.with_index { |variable, i| acc[i] += 1 if variable }
      acc
    end
  end

  def variations
    target_constraint = constraints_by_number_of_variables.sort.first.last.first

    if target_constraint.num_vars == 1
      accumulated_so_far = target_constraint.variables.sum { |v| v && v.size == 1 ? v.begin : 0 }
      remainder = target_constraint.total - accumulated_so_far
      return [target_constraint.variables.map { |v| v && v.size > 1 ? remainder..remainder : nil }]
    end

    variable_impact = target_constraint.variables.map.with_index do |variable, i|
      next unless variable
      variables_by_impact[i]
    end

    max_impact = variable_impact.select { it }.max
    target_variable = variable_impact.index(max_impact)

    range = target_constraint.variables[target_variable]
    range.map do |value|
      Array.new(target_constraint.variables.size) { |variable| variable == target_variable ? value..value : nil }
    end
  end

  def num_pos = @constraints.map(&:num_pos).reduce(&:*) || 0
  def valid? = @constraints.all?(&:valid?)

  def to_s = @constraints.map { |c| "#{c}, #{c.num_vars} vars, #{c.num_pos} pos" }.join("\n")
end
