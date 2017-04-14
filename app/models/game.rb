class Game < ApplicationRecord
  has_many :pieces
  # question: would this still work if we changed has_many to has_one?
  has_many :white_player, class_name: 'User', foreign_key: 'white_player_id'
  has_many :black_player, class_name: 'User', foreign_key: 'black_player_id'

  validates :name, presence: true, length: { minimum: 2 }

  scope :open, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }

  def associate_pieces!(user, color)
    pieces.where(color: color).each do |piece|
      user.pieces << piece
    end
  end

  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
