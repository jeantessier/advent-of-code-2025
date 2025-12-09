RedTile = Struct.new(:x, :y) do
  def area_between(other) = ((x - other.x).abs + 1) * ((y - other.y).abs + 1)
  def to_s = "(#{x}, #{y})"
end
