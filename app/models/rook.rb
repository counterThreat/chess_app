class Rook < Piece
  def valid_move?(x_new, y_new)
    super && !obstructed?(x_new, y_new) && (x_position == x_new || y_position == y_new)
  end
end
