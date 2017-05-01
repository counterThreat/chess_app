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
    !(
      rook.nil? ||
      rook.type != 'Rook' ||
      rook.color != color ||
      moved? ||
      rook.moved? ||
      !will_king_be_safe?(rook_x) ||
      obstructed?(rook_x, rook_y)
    )
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
      (3..4).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    elsif rook_x > x_position
      (6..7).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    end
  end
end
