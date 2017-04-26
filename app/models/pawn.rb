class Pawn < Piece
  FIRST_MOVE = 2
  SECOND_MOVE = 1

  def valid_move?(x_new, y_new)
    return false unless forward_move?(y_new)
    return false if vertical_move?(x_new, y_new) && !valid_vertical_move?(x_new, y_new)
    pawn_possible?(x_new, y_new)
  end

  def pawn_possible?(x_new, y_new)
    (vertical_move?(x_new, y_new) && valid_vertical_move?(x_new, y_new)) || valid_capture?(x_new, y_new)
  end

  def move(x_new, y_new)
    super
  end

  def valid_vertical_move?(x_new, y_new)
    return false if y_out_of_bounds?(y_new)
    return false if occupied?(x_new, y_new)
    !obstructed?(x_new, y_new)
  end

  def y_out_of_bounds?(y_new)
    y_diff(y_new) > y_move
  end

  def pawn_diagonal_move?(x_new, y_new)
    x_diff(x_new) == 1 && y_diff(y_new) == 1
  end

  def valid_capture?(x_new, y_new)
    return false unless diagonal_move?(x_new, y_new) &&
    (opponent_at?(x_new, y_new) || valid_en_passant?(x_new, y_new))
  end

  def moved?
    updated_at != created_at
  end

  def forward_move?(y_new)
    y_distance = y_new - y_position
    if color == 'white'
      y_distance > 0
    else
      y_distance < 0
    end
  end

  def forward_direction
    if color == 'white'
      1
    else
      -1
    end
  end

  def backward(y_new)
    y_new + -forward_direction
  end

  def opponent_at?(x_new, y_new)
    target_piece = game.pieces.find_by(x_position: x_new, y_position: y_new)
    opponent?(target_piece)
  end

  def opponent?(piece)
    !piece.nil? && piece.color != color
  end

  def y_move
    moved? ? SECOND_MOVE : FIRST_MOVE
  end

  def last_piece_moved
    game.pieces.order(:updated_at).last
  end

  def valid_en_passant?(x_new, y_new)
    last_piece_moved.piece_type == 'Pawn' &&
    last_piece_moved.move_num == 1 &&
    last_piece_moved.y_position == y_position &&
    last_piece.x_position == (color == 'white' ? 4 : 5) &&
    (last_piece.x_position - x_position).abs == 1
  end
end
