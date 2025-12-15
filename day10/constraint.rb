class Constraint
  attr_accessor :variables, :total

  def initialize(variables: [], total: 0)
    @variables = variables
    @total = total
  end

  def num_vars = @variables.count { |v| v && v.size > 1 }
  def num_pos = @variables.filter { it }.map(&:size).reduce(&:*) || 0
  def range = (@variables.sum { |v| v&.begin || 0 })..(@variables.sum { |v| v&.end || 0 })
  def valid? = range.include?(total)

  def +(variation)
    Constraint.new(
      variables: variables.zip(variation).map { |a, b| a.nil? ? nil : b.nil? ? a : b },
      total: total,
    )
  end

  def ==(other)
    variables == other.variables && total == other.total
  end

  alias_method :eql?, :==

  def to_s = "#{variables.inspect} = #{total}"
end
