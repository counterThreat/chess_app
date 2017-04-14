class Game < ApplicationRecord
  has_many :pieces
  has_many :white_player, class_name: 'User', foreign_key: 'white_player_id'
  has_many :black_player, class_name: 'User', foreign_key: 'black_player_id'

  validates :name,
            presence: true,
            uniqueness: true

  def associate_pieces!(user, color)
    pieces.where(color: color).each do |piece|
      user.piece << piece
    end
  end

  # scope method for determining which games do not have a black_player
  # def self.black_player_id_nil
  ## where(black_player_id: nil)
  # end
  # ^^ unnecessary method, can append '.nil' to the end of existing methods 4 same result

  def black_player_join!(user)
    update(black_player: user)
    associate_pieces!(user, 'black')
    user.games_as_black << self
  end

  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
