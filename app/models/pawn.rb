class Pawn < Piece
  def valid_move?

  end

  def move!(x_new, y_new)
    correct_direction = color == 'white' ? 1 : -1
  end

  def within_movement_constraints?(x_new, y_new); end

  def first_move?
    return true if color == 'white' && y_position == 2
    return true if color == 'black' && y_position == 7
    false
  end
end
