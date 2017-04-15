class Game < ApplicationRecord
  has_many :pieces
  has_many :white_player, class_name: 'User', foreign_key: 'white_player_id'
  has_many :black_player, class_name: 'User', foreign_key: 'black_player_id'

  validates :name, presence: true

  def find_piece(x_position, y_position)
    pieces.find_by(x_position: x_position, y_position: y_position)
  end

  def make_newboard
    # create and place white pieces
    (0..7).each do |i|
      Pawn.create(x_position: i, y_position: 1, color: 'White')
    end

    Rook.create(x_position: 0, y_position: 0, color: 'White')
    Rook.create(x_position: 7, y_position: 0, color: 'White')
    Knight.create(x_position: 1, y_position: 0, color: 'White')
    Knight.create(x_position: 6, y_position: 0, color: 'White')
    Bishop.create(x_position: 2, y_position: 0, color: 'White')
    Bishop.create(x_position: 5, y_position: 0, color: 'White')
    Queen.create(x_position: 3, y_position: 0, color: 'White')
    King.create(x_position: 4, y_position: 0, color: 'White')

    # create and place black pieces
    (0..7).each do |i|
      Pawn.create(x_position: i, y_position: 6, color: 'Black')
    end

    Rook.create(x_position: 0, y_position: 7, color: 'Black')
    Rook.create(x_position: 7, y_position: 7, color: 'Black')
    Knight.create(x_position: 1, y_position: 7, color: 'Black')
    Knight.create(x_position: 6, y_position: 7, color: 'Black')
    Bishop.create(x_position: 2, y_position: 7, color: 'Black')
    Bishop.create(x_position: 5, y_position: 7, color: 'Black')
    Queen.create(x_position: 3, y_position: 7, color: 'Black')
    King.create(x_position: 4, y_position: 7, color: 'Black')
  end

  def associate_pieces!(user, color)
    pieces.where(color: color).each do |piece|
      user.piece << piece
    end
  end

  # scope method for determining which games do not have a black_player
  def self.with_one_player
    where(black_player_id: nil)
  end
  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
