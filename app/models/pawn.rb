class Pawn < Piece
  FIRST_MOVE = 2
  SECOND_MOVE = 1

  def valid_move?(x_new, y_new)
    pawn_possible?(x_new, y_new)
  end

  def move(x_new, y_new)
    if valid_en_passant?(x_new, y_new)
      Piece.transaction do
        last_piece_moved.update!(captured: true, x_position: -1, y_position: -1)
        update!(x_position: x_new, y_position: y_new, move_num: move_num + 1)
        if game.check == color
          reload
          raise ActiveRecord::Rollback, 'Move forbidden: exposes king to check'
        else
          toggle_move!
        end
      end
    end
    if promote?(y_new)
      Piece.transaction do
        attack!(x_new, y_new)
        update!(
          x_position: x_new, y_position: y_new,
          type: "Queen", unicode: color == "white" ? '&#9813' : '&#9819',
          move_num: move_num + 1)
        if game.check == color
          reload
            raise ActiveRecord::Rollback, 'Move forbidden: exposes king to check'
        else
          toggle_move!
        end
      end
    end
      super
  end

  def pawn_possible?(x_new, y_new)
    (forward_move?(y_new) && vertical_move?(x_new, y_new) && valid_vertical_move?(x_new, y_new)) ||
    valid_capture?(x_new, y_new)
    #is_king_safe?
  end

  def promote?(y_new)
    y_new == 8 ||
    y_new == 1
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
    pawn_diagonal_move?(x_new, y_new) && forward_move?(y_new) &&
    occupied?(x_new, y_new) && opponent(x_new, y_new).color != color
  end

  def moved?
    updated_at != created_at
  end

  def forward_move?(y_new)
    (y_new - y_position) < 0 && color == 'black' ||
    (y_new - y_position) > 0 && color == 'white'
  end

  def forward_direction
    if color == 'black'
      -1
    else
      1
    end
  end

  def backward(y_new)
    y_new + -forward_direction
  end

  def y_move
    move_num != 0 ? SECOND_MOVE : FIRST_MOVE
  end

  def last_piece_moved
    game.pieces.order(:updated_at).last
  end

  def valid_en_passant?(x_new, y_new)
    last_piece = last_piece_moved
    last_piece.type == "Pawn" &&
    last_piece.move_num == 1 &&
    last_piece.y_position == y_position &&
    last_piece.y_position == (last_piece.color == 'white' ? 4 : 5) &&
    (last_piece.x_position - x_position).abs == 1
  end
end
