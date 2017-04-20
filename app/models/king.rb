class King < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif x_position == x_new || y_position == y_new
      true
    elsif (x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1
      true
    else
      super
    end
  end
end
