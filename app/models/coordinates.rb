class Coordinates
  attr_reader :x, :y
  
  def initialize(x,y)
    @x = x
    @y = y
  end
  
  def ==(other)
    return false unless other.respond_to?(:x, :y)
    other.x == x && other.y == y
  end
end