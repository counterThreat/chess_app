class King < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif (x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1
      true
    else
      return super unless can_castle?(x_new, y_new)
      castle!(x_new, y_new)
    end
  end

  def can_castle?(rook_x, rook_y)
    rook = game.find_piece(rook_x, rook_y)
    return false if rook.nil?
    return false if rook.type != 'Rook'
    return false if rook.color != color
    return false if moved? || rook.moved?
    return false if will_king_be_safe?(rook_x) == false
    return false if obstructed?(rook_x, rook_y)
    true
    # account for 'through check'
  end

  def castle!(rook_x, rook_y)
    if can_castle?(rook_x, rook_y)
      rook = game.find_piece(rook_x, rook_y)
      if rook_x < x_position
        update(x_position: rook_x + 2)
        rook.update(x_position: rook_x + 3)
      elsif rook_x > x_position
        update(x_position: rook_x - 1)
        rook.update(x_position: rook_x - 2)
      end
      toggle_move!
      rook.toggle_move!
    else
      puts 'castling not allowed'
    end
  end

  def will_king_be_safe?(rook_x)
    if rook_x < x_position
      (2..4).each do |x_pos|
        game.pieces_no_kings.each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    elsif rook_x > x_position
      (4..6).each do |x_pos|
        game.pieces_no_kings.each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    end
  end
end
