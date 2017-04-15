class Bishop < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif (x_position - x_new).abs == (y_position - y_new).abs
      true
    else
      false
    end
  end
end
