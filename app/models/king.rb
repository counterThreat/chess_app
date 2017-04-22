class King < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif (x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1
      true
    else
      super
    end
  end

  def can_castle?(rook_x, rook_y)
    rook = game.find_piece(rook_x, rook_y)
    return false if rook.type != 'Rook'
    return false if moved? || rook.moved?
    return false if game.check == color
    return false if obstructed?(rook_x, rook_y)
    true
    # account for 'through check'
  end
end
