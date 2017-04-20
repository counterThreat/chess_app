class Knight < Piece
  def valid_move?(x_new, y_new)
    return false unless super(x_new, y_new)
    return false unless (x_new - x.position).abs == 2 && (y_new - y_position).abs == 1 ||
      (x_new - x_position).abs == 1 && (y_new - y_position).abs == 2
  end
end

