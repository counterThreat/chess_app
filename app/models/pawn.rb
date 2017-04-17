class Pawn < Piece
  def valid_move?; end

  def move!(next_x, next_y)
    correct_direction = color == 'white' ? 1 : -1
  end

  def within_movement_constraints?(next_x, next_y); end

  def first_move?
    return true if color == 'white' && y_position == 2
    return true if color == 'black' && y_position == 7
  end
end
