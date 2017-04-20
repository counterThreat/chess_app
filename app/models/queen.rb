class Queen < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif diagonal_move?(x, y) || horizontal_move?(x, y) || vertical_move?(x, y)
      true
    else
      super
    end
  end
end