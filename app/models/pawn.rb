class Pawn < Piece
  FIRST_MOVE = 2
  SECOND_MOVE = 1

  def valid_move?(x_new, y_new)
    return false unless forward_move?(y_new)
    return false if vertical_move?(x_new, y_new) && !valid_vertical_move?(x_new, y_new)
    pawn_possible?(x_new, y_new)
  end

  def pawn_possible?(x_new, y_new)
    valid_vertical_move?(x_new, y_new) || valid_capture?(x_new, y_new)
  end

  def move(x_new, y_new)
    super
  end

  def valid_vertical_move?(x_new, y_new)
    return false if exceeds_bounds?(y_new)
    return false if occupied?(x_new, y_new)
    !obstructed?(x_new, y_new)
  end

  def exceeds_bounds?(y_new)
    y_diff(y_new) > y_determinant
  end

  def diagonal_move?(x_new, y_new)
    x_diff(x_new) == 1 && y_diff(y_new) == 1
  end

  def valid_capture?(x_new, y_new)
    return false unless diagonal_move?(x_new, y_new)
    opponent_at?(x_new, y_new)
  end

  def moved?
    updated_at != created_at
  end

  def forward_move?(y_new)
    y_distance = y_new - y_position
    white? ? y_distance > 0 : y_distance < 0
  end

  def forward_direction
    white? ? 1 : -1
  end

  def backward
    y + -forward_direction
  end

  def opponent_at?(x_new, y_new)
    target_piece = game.pieces.find_by(x_position: x_new, y_position: y_new)
    opponent?(target_piece)
  end

  def opponent?(piece)
    !piece.nil? && piece.color != color
  end

  def y_determinant
    moved? ? SECOND_MOVE : FIRST_MOVE
  end
end
