class Pawn < Piece
  def valid_move?(x_new, y_new)
    return false unless pawn_possible?(x_new, y_new)
    super
  end

  def move(x_new, y_new)
    super
  end

  def pawn_possible?(x_new, y_new)
    return true if forward_one_square?(x_new, y_new)
    return true if forward_two_squares?(x_new, y_new)
    return true if capture_diagonally?(x_new, y_new)
    false
  end

  def opponent(x_new, y_new)
    super
  end

  def first_move?
    return true if color == 'White' && y_position == 1
    return true if color == 'Black' && y_position == 6
    false
  end

  def find_piece(x_new, y_new)
    Piece.where(x_position: x_new, y_position: y_new).take
  end

  def forward_one_square?(x_new, y_new)
    correct_distance_one = y_position + 1
    return false if occupied?(x_new, y_new)
    return false unless x_new == x_position
    return false unless y_new == correct_distance_one
    true
  end

  def forward_two_squares?(x_new, y_new)
    correct_distance_two = y_position + 2
    return false unless first_move?
    return false unless x_new == x_position
    return false unless y_new == correct_distance_two
    return false if occupied?(x_position, y_position) || occupied?(x_new, y_new)
    true
  end

  def capture_diagonally?(x_new, y_new)
    return false if x_diff(x_new) != 1
    return false if y_new - y_position != 1
    return false unless opponent?(x_new, y_new)
    true
  end

  def x_diff(x_new)
    (x_position - x_new).abs
  end

  def promote?(new_y)
    return true if new_y == 7 || new_y == 0
    false
  end
end
