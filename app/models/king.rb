class King < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif (x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1
      true
    else
      return super unless castle!(x_new, y_new)
    end
  end

  def can_castle?(x_new, y_new)
    if x_new < x_position
      rook = game.find_piece(x_new - 2, y_new)
      else
        rook = game.find_piece(x_new + 1, y_new)
      end
    !(x_new - x_position).abs > 2
      rook.nil? ||
      rook.type != 'Rook' ||
      rook.color != color ||
      moved? ||
      rook.moved? ||
      !will_king_be_safe?(rook_x) ||
      obstructed?(rook_x, rook_y) ||
      occupied?(x_new, y_new)
    )
  end

  def castle!(x_new, y_new)
    if can_castle?(x_new, y_new) && x_new < x_position
      rook = game.find_piece(x_new - 2, y_new, moved: true)
      update(x_position: rook_x + 2, moved: true)
      rook.update(x_position: rook_x + 3)
    elsif can_castle?(x_new, y_new) && x_new > x_position
      rook = game.find_piece(x_new + 1, y_new)
      update(x_position: rook_x - 1, moved: true)
      rook.update(x_position: rook_x - 2, moved: true)
    else 
      false
    end
  end

  def will_king_be_safe?(rook_x)
    if rook_x > x_position
      (5..7).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    elsif rook_x < x_position
      (3..5).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    end
  end
end