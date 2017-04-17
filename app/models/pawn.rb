class Pawn < Piece
  def valid_move?(x_new, y_new)
    return false unless pawn_possible?(x_new, y_new)
    super
  end

  def move!(x_new, y_new)
    super
  end

  def pawn_possible?(x_new, y_new)
    correct_direction = color == 'white' ? 1 : -1
    return true if forward_one_square?(x_new, y_new, correct_direction)
    return true if forward_two_squares?(x_new, y_new, correct_direction)
    return true if capture_diagonally?(x_new, y_new, correct_direction)
  end

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
    correct_distance_one = y_position + correct_direction
    return false if occupied?(x_new, y_new)
    return false unless x_new == x_position
    return false unless y_new == correct_distance_one
    true
  end

  def forward_two_squares?(x_new, y_new, correct_direction)
    correct_distance_two = y_position + (correct_direction * 2)
    return false unless first_move?
    return false unless x_new == x_position
    return false unless y_new == correct_distance_two
    return false if occupied?(x_position, (y_position + correct_direction)) || occupied?(x_new, y_new)
    true
  end

  def capture_diagonally?(x_new, y_new, correct_direction)
    return false if x_difference(x_new) != 1
    return false if y_new - y_position != correct_direction
    return false unless opponent_piece?(x_new, y_new)
    true
  end
end
