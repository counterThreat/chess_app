class Bishop < Piece
  def valid_move?(x_new, y_new)
    return false if obstructed?(x_new, y_new)
    return true if diagonal_move?(x_new, y_new)
  end
end
