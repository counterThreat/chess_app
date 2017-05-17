class King < Piece
  def valid_move?(x_new, y_new)
    super && obstructed?(x_new, y_new) && (((x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1) || castle!(x_new, y_new))
  end

  def can_castle?(x_new, y_new)
    rook = game.find_piece((x_new < x_position ? 1 : 8), y_new)
    !(
      your_turn?
      (x_new - x_position).abs != 2 ||
      rook.nil? ||
      rook.type != 'Rook' ||
      rook.color != color ||
      move_num != 0 ||
      rook.move_num != 0 ||
      !will_king_be_safe?(x_new) ||
      obstructed?(x_new, y_new) ||
      occupied?(x_new, y_new)
    )
  end

  def castle!(x_new, y_new)
    return false unless can_castle?(x_new, y_new)
    rook = game.find_piece((x_new < x_position ? 1 : 8), y_new)
    rook.update!(x_position: x_new < x_position ? 4 : 6, move_num: move_num + 1)
    update!(x_position: x_new, move_num: move_num + 1)
    game.next_turn
  end

  def will_king_be_safe?(x_new)
    if x_new > x_position
      (5..7).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    elsif x_new < x_position
      (3..5).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    end
  end
end
