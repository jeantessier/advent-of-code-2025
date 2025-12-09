Rectangle = Struct.new(:a, :b) do
  def area = @area ||= a.area_between(b)
  def to_s = "#{area}: #{a} - #{b}"

  def min_x = @min_x ||= [a.x, b.x].min
  def max_x = @max_x ||= [a.x, b.x].max
  def min_y = @min_y ||= [a.y, b.y].min
  def max_y = @max_y ||= [a.y, b.y].max

  def to_my_left?(other) = other.max_x <= min_x
  def to_my_right?(other) = other.min_x >= max_x
  def below_me?(other) = other.max_y <= min_y
  def above_me?(other) = other.min_y >= max_y

  def intersects?(other)
    !to_my_left?(other) && !to_my_right?(other) && !below_me?(other) && !above_me?(other)
  end
end
