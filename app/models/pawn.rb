class Pawn < Piece
  FIRST_MOVE = 2
  SECOND_MOVE = 1

  def valid_move?(x_new, y_new)
    if obstructed?(x_new, y_new)
      false
    elsif !forward_move?(y_new)
      false
    elsif vertical_move?(x_new, y_new) && !valid_vertical_move?(x_new, y_new)
      false
    elsif pawn_possible?(x_new, y_new)
      true
    else
      super
    end
  end

  def pawn_possible?(x_new, y_new)
    (vertical_move?(x_new, y_new) && valid_vertical_move?(x_new, y_new)) || valid_capture?(x_new, y_new)
  end

  def move(x_new, y_new)
    update(type: 'Queen') if promote?(y_new)
    super
  end

  def promote?(y_new)
    return true if y_new == 7 || y_new.zero?
    false
  end

  def valid_vertical_move?(x_new, y_new)
    return false if y_out_of_bounds?(y_new)
    return false if occupied?(x_new, y_new)
    !obstructed?(x_new, y_new)
  end

  ## def capture_enpassant(x_new, y_new)
  ##  game.pieces.find_by(
  ##    x_position: x_new,
  ##    y_position: backward(y_new)
  ##  ).destroy
  ## end

  def y_out_of_bounds?(y_new)
    y_diff(y_new) > y_move
  end

  def pawn_diagonal_move?(x_new, y_new)
    x_diff(x_new) == 1 && y_diff(y_new) == 1
  end

  def valid_capture?(x_new, y_new)
    return false unless diagonal_move?(x_new, y_new)
  end

  def moved?
    updated_at != created_at
  end

  def forward_move?(y_new)
    y_distance = y_new - y_position
    if color == 'black'
      y_distance > 0
    else
      y_distance < 0
    end
  end

  def forward_direction
    if color == 'black'
      1
    else
      -1
    end
  end

  def backward(y_new)
    y_new + -forward_direction
  end

  def y_move
    moved? ? SECOND_MOVE : FIRST_MOVE
  end
end

