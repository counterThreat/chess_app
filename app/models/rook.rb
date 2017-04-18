class Rook < Piece
  def valid_move?(x_new, y_new)
    return false if obstructed?(x_new, y_new)
    if x_position == x_new || y_position == y_new
      return true
    else
      super
    end
  end
end
