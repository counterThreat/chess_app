class Game < ApplicationRecord
  has_many :pieces
  has_many :white_player, class_name: 'User', foreign_key: 'white_player_id'
  has_many :black_player, class_name: 'User', foreign_key: 'black_player_id'

  validates :name, presence: true

  def make_newboard
    # create and place white pieces
    (0..7).each do |i|
      Pawn.create(x_position: i, y_position: 1, color: 'White', moved: false)
    end
    Rook.create(x_position: 0, y_position: 0, color: 'White', moved: false)
    Rook.create(x_position: 7, y_position: 0, color: 'White', moved: false)
    Knight.create(x_position: 1, y_position: 0, color: 'White', moved: false)
    Knight.create(x_position: 6, y_position: 0, color: 'White', moved: false)
    Bishop.create(x_position: 2, y_position: 0, color: 'White', moved: false)
    Bishop.create(x_position: 5, y_position: 0, color: 'White', moved: false)
    Queen.create(x_position: 3, y_position: 0, color: 'White', moved: false)
    King.create(x_position: 4, y_position: 0, color: 'White', moved: false)
    # create and place black pieces
    (0..7).each do |i|
      Pawn.create(x_position: i, y_position: 6, color: 'Black', moved: false)
    end
    Rook.create(x_position: 0, y_position: 7, color: 'Black', moved: false)
    Rook.create(x_position: 7, y_position: 7, color: 'Black', moved: false)
    Knight.create(x_position: 1, y_position: 7, color: 'Black', moved: false)
    Knight.create(x_position: 6, y_position: 7, color: 'Black', moved: false)
    Bishop.create(x_position: 2, y_position: 7, color: 'Black', moved: false)
    Bishop.create(x_position: 5, y_position: 7, color: 'Black', moved: false)
    Queen.create(x_position: 3, y_position: 7, color: 'Black', moved: false)
    King.create(x_position: 4, y_position: 7, color: 'Black', moved: false)
  end

  def associate_pieces!(user, color)
    pieces.where(color: color).each do |piece|
      user.piece << piece
    end
  end

  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
