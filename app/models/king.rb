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
    rook = game.find_piece((x_new < x_position ? 1 : 8), y_new)
    !((x_new - x_position).abs != 2 ||
      rook.nil? ||
      rook.type != 'Rook' ||
      rook.color != color ||
      moved? ||
      rook.moved?) #||
      #!will_king_be_safe?(x_new) ||
      #obstructed?(x_new, y_new) ||
      #occupied?(x_new, y_new))
  end

  def castle!(x_new, y_new)
    return false unless can_castle?(x_new, y_new) 
    rook = game.find_piece((x_new < x_position ? 1 : 8), y_new)
    update!(x_position: x_new, moved: true)
    rook.update!(x_position: (x_new < x_position ? 4 : 6), moved: true)
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