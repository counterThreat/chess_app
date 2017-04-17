class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :color, presence: true
  validates :type, presence: true
  validates :x_position, presence: true
  validates :y_position, presence: true
  validates :game_id, presence: true
  validates :user_id, presence: true

  def valid_move?(x_new, y_new)
    return false if out_of_bounds?(x_new, y_new)
    return false if obstructed?(x_new, y_new)
    true
  end

  def on_board?
    if x_position >= 0 && x_position <= 7 && y_position >= 0 && y_position <= 7
      true
    else
      false
    end
  end

  def move!(x_new, y_new)
    if valid_move?(x_new, y_new) && on_board?
      attack!(x_new, y_new)
      update(x_position: x_new, y_position: y_new, last_move: game.move_number)
      game.end_turn!(game.turn)
    else
      puts 'Move is not allowed!' # can change this to be a flash method
      return
    end
  end

  def obstructed?(x_new, y_new) # Integrate with color
    # The following two lines determine if the differences between x to x_new
    # and y to y_new are positive, negative, or zero. This is used to iterate in
    # the correct direction below when looking at each square in the piece's path.
    xdir = x_position < x_new ? 1 : ((x_position == x_new ? 0 : -1))
    ydir = y_position < y_new ? 1 : ((y_position == y_new ? 0 : -1))
    i = 1
    dx = (x_new - x_position).abs
    dy = (y_new - y_position).abs
    until i == [dx, dy].max
      # if array[x_position + i * xdir][y_position + i * ydir] != 0
      #  return true
      # end
      if game.find_piece(x_position + i * xdir, y_position + i * ydir).present?
        return true
      end
      i += 1
    end
    false
  end

  def out_of_bounds?(x_new, y_new)
    x_new > 8 || x_new < 1 || y_new > 8 || y_new < 1
  end

  def occupied?(x_new, y_new)
    return false if opponent(x_new, y_new).nil?
    true
  end

  def opponent(x_new, y_new)
    game.find_piece(x_new, y_new)
    # where if find_piece?
  end

  def find_piece(x_new, y_new)
    game.pieces.where(x_position: x_new, y_position: y_new).take
  end

  def friendly?(x_new, y_new)
    return true if color == find_piece(x_new, y_new).color
    false
  end

  def attack!(x_new, y_new)
    return false if occupied?(x_new, y_new) == false
    return false if opponent(x_new, y_new).color == color
    if occupied?(x_new, y_new)
      opponent(x_new, y_new).update(captured: true, x_position: -1, y_position: -1)
    end
  end

  def x_difference(x_new)
    (x_position - x_new).abs
  end

  def y_difference(y_new)
    (y_position - y_new).abs
  end
end
