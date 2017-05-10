class Move
  attr_accessor :source, :destination

  def initialize(arguments)
    @piece = arguments[:piece]
    self.source = @piece.coordinates
    self.destination = arguments[:destination]
  end

  def path
    return vertical_path if vertical?
    return horizontal_path if horizontal?
    return diagonal_path if diagonal?
    fail ArgumentError, 'Invalid path'
  end

  private

  def vertical_path
    (from_y...to_y).map do |y|
      Coordinates.new(source.x, y)
    end
  end

  def horizontal_path
    (from_x...to_x).map do |x|
      Coordinates.new(x, source.y)
    end
  end

  def diagonal_path
    y_positions = y_range

    (from_x...to_x).each_with_index.map do |x, idx|
      Coordinates.new(x, y_positions[idx])
    end
  end

  def vertical?
    source.x == destination.x && source.y != destination.y
  end

  def horizontal?
    source.y == destination.y && source.x != destination.x
  end

  def diagonal?
    diff_in_x == diff_in_y
  end

  def from_x
    [source.x, destination.x].min + 1
  end

  def to_x
    [source.x, destination.x].max
  end

  def from_y
    [source.y, destination.y].min + 1
  end

  def to_y
    [source.y, destination.y].max
  end

  def diff_in_x
    (source.x - destination.x).abs
  end

  def diff_in_y
    (source.y - destination.y).abs
  end

  def y_range
    range = (from_y...to_y).to_a

    # Reverse the range if x is increasing and y is decreasing or vice versa
    return range if x_and_y_opposite?
    range.reverse
  end

  def x_and_y_opposite?
    source.x - destination.x == source.y - destination.y
  end
end