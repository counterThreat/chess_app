class Bishop < Piece
  def valid_move?(x_new, y_new)
    (x_position - x_new).abs == (y_position - y_new).abs ? true : false
  end
end
