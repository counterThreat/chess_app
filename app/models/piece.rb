class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def self.types
    %w[Pawn Rook Knight Bishop Queen King]
  end

  scope :pawns, -> { where(type: 'Pawn') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :knights, -> { where(type: 'Knight') }
  scope :bishops, -> { where(type: 'Bishop') }
  scope :queens, -> { where(type: 'Queen') }
  scope :kings, -> { where(type: 'King') }

  def can_move?(x_new, y_new)
    if color == game.turn && game.winning_player_id.nil?
      # return false for check logic
      game.end_turn!(game.turn) if move!(x_new, y_new)
    end
  end

  def move!(x_new, y_new)
    return false unless valid_move?(x_new, y_new)
    attack!(x_new, y_new)
    update(x_position: x_new, y_position: y_new, last_move: game.move_number)
    true
  end

=begin
# kf: this method kept giving me a lot of trouble, i put an alternative way below
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
      return true if array[x_position + i * xdir][y_position + i * ydir] != 0
      return true if game.find_piece(x_position + i * xdir, y_position + i * ydir).present?
      i += 1
    end
    false
  end
=end

  private

  def valid_move?(x_new, y_new)
    return false if out_of_bounds?(x_new, y_new)
    return false if obstructed?(x_new, y_new)
    true
  end

  def obstructed?(x_new, y_new)
    x_current = x_new
    y_current = y_new
    loop do
      x_current += (x_new <=> x_current)
      y_current += (y_new <=> y_current)
      return false if x_current == x_new && y_current == y_new
      return true if game.occupied?(x_current_, y_current)
    end
  end

  def out_of_bounds?(x_new, y_new)
    x_new > 7 || x_new < 1 || y_new > 7 || y_new < 1
  end

  def opponent(x_new, y_new)
    game.find_piece(x_new, y_new)
    # where if find_piece?
  end

  def same_team?(x_new, y_new)
    return true if color == find_piece(x_new, y_new).color
    false
  end

  def find_piece(x_new, y_new)
    pieces.where(x_position: x_new, y_position: y_new).take
  end

  def attack!(x_new, y_new)
    if occupied?(x_new, y_new)
      return false if same_team?(x_new, y_new)
      return false if find_piece(x_new, y_new).type == 'King'
      return true if find_piece(x_new, y_new).update!(x_position: nil, y_position: nil, captured: true)
    end
  end

  def horizontal_move?(x_new, y_new)
    y_position == y_new && x_position != x_new
  end

  def vertical_move?(x_new, y_new)
    x_position == x_new && y_position != y_new
  end

  def diagonal_move?(x_new, y_new)
    return false if x_position == x_new && y_position == y_new
    x_difference(x_new) == y_difference(y_new)
  end

  def occupied?(x_new, y_new)
    game.pieces.where(x_position: x_new, y_position: y_new).take.present?
  end

  def x_difference(x_new)
    (x_position - x_new).abs
  end

  def y_difference(y_new)
    (y_position - y_new).abs
  end
end
