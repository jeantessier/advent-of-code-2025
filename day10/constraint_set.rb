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

  def num_pos = @num_pos ||= @constraints.map(&:num_pos).reduce(&:*) || 0
  def valid? = @valid ||= @constraints.all?(&:valid?)

  def impacts
    (0...@constraints[0].variables.size).map { |i| @constraints.map { |constraint| constraint.variables[i] }.count { it } }
  end

  def to_s = @constraints.map { |c| "#{c}, #{c.num_vars} vars, #{c.num_pos} pos" }.join("\n")
end
