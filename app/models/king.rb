class King < Piece
  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif (x_new - x_position).abs <= 1 && (y_new - y_position).abs <= 1
      true
    else can_castle?(x_new, y_new)
      #castle!(x_new, y_new)
    #else return super
    end
  end

  #def can_castle?(rook_x, rook_y)
  def can_castle?(x_new, y_new)
    if x_new < x_position
      rook = game.find_piece(x_new - 2, y_new)
      else
        rook = game.find_piece(x_new + 1, y_new)
      end
    return false if (x_new - x_position).abs != 2
    return false if occupied?(x_new, y_new) 
    return false if rook.nil? 
    return false if rook.type != 'Rook'
    return false if rook.color != color
    return false if moved?
    return false if rook.moved?
    return false if !will_king_be_safe?(x_new) 
    return false if obstructed?(x_new, y_new)
      if x_new < x_position
        update(x_position: x_new, moved: true)
        rook.update(x_position: rook.x_position + 3, moved: true)
      elsif x_new > x_position
        update(x_position: x_new, moved: true)
        rook.update(x_position: rook.x_position - 2, moved: true)
        #toggle_move!
        #rook.toggle_move!
      else
       puts 'castling not allowed'
      end
  end
    # account for 'through check'

  #def castle!(x_new, y_new)
      #x_new < x_position ? rook = game.find_piece(x_new - 2, y_new): rook = game.find_piece(x_new + 1, y_new)
      #if x_new < x_position
       #update(x_position: x_new)
        #rook.update(x_position: rook.x_position + 3)
      #elsif x_new > x_position
        #update(x_position: x_new)
        #rook.update(x_position: rook.x_position - 2)
      #toggle_move!
      #rook.toggle_move!
      #else
       #puts 'castling not allowed'
      #end
  #end

  def will_king_be_safe?(rook_x)
    if rook_x < x_position
      (2..5).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    elsif rook_x > x_position
      (5..7).each do |x_pos|
        game.pieces_no_king(color).each do |piece|
          return false if piece.valid_move?(x_pos, y_position) && piece.color != color
        end
      end
      true
    end
  end
end
