class Game < ApplicationRecord
  belongs_to :white_player, class_name: 'User', foreign_key: 'white_player_id'
  belongs_to :black_player, class_name: 'User', foreign_key: 'black_player_id', validate: false

  has_many :pieces

  validates_presence_of :name

  enum current_player: [:current_player_is_black_player, :current_player_is_white_player]

  after_create :populate_board!

  def find_piece(x_position, y_position)
    pieces.find_by(x_position: x_position, y_position: y_position)
  end

  def populate_board!
    make_newboard
    current_player_is_white_player!
  end

  def full?
    players.count == 2
  end

  def players
    [white_player, black_player].compact
  end

  def includes_player?(player)
    players.include?(player)
  end

  def make_newboard
    # create and place white pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 1, color: 'white', user_id: white_player_id)
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: 'white', user_id: white_player_id)
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: 'white', user_id: white_player_id)
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: 'white', user_id: white_player_id)
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: 'white', user_id: white_player_id)
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: 'white', user_id: white_player_id)
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: 'white', user_id: white_player_id)
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: 'white', user_id: white_player_id)
    King.create(game_id: id, x_position: 4, y_position: 0, color: 'white', user_id: white_player_id)

    # create and place black pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 6, color: 'black', user_id: white_player_id)
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: 'black', user_id: white_player_id)
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: 'black', user_id: white_player_id)
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: 'black', user_id: white_player_id)
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: 'black', user_id: white_player_id)
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: 'black', user_id: white_player_id)
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: 'black', user_id: white_player_id)
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: 'black', user_id: white_player_id)
    King.create(game_id: id, x_position: 4, y_position: 7, color: 'black', user_id: white_player_id)
  end

  def associate_pieces!
    pieces.where(color: 'black').update(current_user: black_player_id)
  end

  def update_current_player!(color)
    color == 'white' ? current_player_is_black_player! : current_player_is_white_player!
  end

  # scope method for determining which games do not have a black_player
  def self.with_one_player
    where(black_player_id: nil)
  end

  def opponent_pieces_on_board(color)
    opposite_color = color == 'black' ? 'white' : 'black'
    pieces.where(x_position: 0..7, y_position: 0..7, color: opposite_color.to_s).to_a
  end

  def current_player_pieces_on_board(color)
    pieces.where(x_position: 0..7, y_position: 0..7, color: color.to_s).to_a
  end
  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
