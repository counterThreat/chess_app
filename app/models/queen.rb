class Queen < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif diagonal_move?(x_new, y_new) || horizontal_move?(x_new, y_new) || vertical_move?(x_new, y_new)
      true
    else
      false
    end
  end
end
