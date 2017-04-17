class Pawn < Piece
  def valid_move?(x_new, y_new)
  end

  def move!(x_new, y_new)
    correct_direction = color == 'white' ? 1 : -1
    super
  end

  def within_movement_constraints?(x_new, y_new); end

  def opponent_piece?(x_new, y_new)
    opponent_piece = find_piece(x_new, y_new)
    return false if opponent_piece.nil?
    return true if color != opponent_piece.color
    false
  end

  def first_move?
    return true if color == 'white' && y_position == 2
    return true if color == 'black' && y_position == 7
    false
  end

  def forward_one_square?(x_new, y_new, correct_direction)
    correct_distance = y_position + correct_direction
    return false if occupied?(x_new, y_new)
    return false unless x_new == x_position
    return false unless y_new == correct_distance
    true
  end


end
