class Rook < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif x_position == x_new || y_position == y_new
      true
    else
      false
    end
  end
end
