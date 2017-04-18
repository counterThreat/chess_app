class Queen < Piece
  def valid_move?(x, y)
    return false unless super
    return false if obstructed?(x_new, y_new)
    diagonal_move?(x_new, y_new) || horizontal_move?(x_new, y_new) || vertical_move?(x_new, y_new)
  end
end
