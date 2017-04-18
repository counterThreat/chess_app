class Game < ApplicationRecord
  has_many :pieces
  belongs_to :white_player, class_name: 'User', foreign_key: 'white_player_id'
  belongs_to :black_player, class_name: 'User', foreign_key: 'black_player_id'

  validates :name, presence: true

  after_create :populate_board!

  scope :available_games, -> { where(winning_player_id: nil) }

  def associate_pieces!(user, color)
    pieces.where(color: color).each do |piece|
      user.pieces << piece
    end
  end

  def black_player_update!(user)
    update(black_player: user)
    associate_pieces!(user, 'black')
    user.games_as_black << self
  end

  def first_turn!
    update(turn: 'white', move_number: 1)
  end

  def end_turn!(color)
    player_turn = color == 'white' ? 'black' : 'white'
    increment!(:move_number)
    update(turn: player_turn)
    game_over!(turn) if checkmate?(turn)
    draw! if stalemate?(turn)
  end

  def forfeit_by!(user)
    if user == white_player
      winner = black_player
    else
      winner = white_player
    end
    update!(winning_player_id: winner)
  end

  # other methods: draw, checkmate?, check?, stalemate? [could consolidate to forfiet and checkmate]

  def game_over!(player_turn)
    player_turn == 'white' ? black_player : white_player
    update(winning_player_id: player_turn)
    increment!(:winning_player_id)
    game_played!
  end

  def locate_king(color)
    pieces.find_by(type: 'King', color: color)
  end

  def game_played!
    white_player.increment!(:games_played)
    black_player.increment!(:games_played)
  end

  def populate_board!
    create_pawns!
    create_back_rows!
    first_turn!
  end

  def create_pawns!
    (0..7).each do |x|
      pieces << Pawn.create(color: 'white', x_position: x, y_position: 1)
      pieces << Pawn.create(color: 'black', x_position: x, y_position: 6)
    end
  end

  def create_back_rows!
    # white back
    Rook.create(game_id: id, x_position: 0, y_position: 0, color: 'white')
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: 'white')
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: 'white')
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: 'white')
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: 'white')
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: 'white')
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: 'white')
    King.create(game_id: id, x_position: 4, y_position: 0, color: 'white')

    # black back
    Rook.create(game_id: id, x_position: 0, y_position: 7, color: 'black')
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: 'black')
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: 'black')
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: 'black')
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: 'black')
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: 'black')
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: 'black')
    King.create(game_id: id, x_position: 4, y_position: 7, color: 'black')
  end

  def opponent_pieces_on_board(color)
    opposite_color = color == 'black' ? 'white' : 'black'
    pieces.where(x_position: 0..7, y_position: 0..7, color: opposite_color.to_s).to_a
  end

  def current_player_pieces_on_board(color)
    pieces.where(x_position: 0..7, y_position: 0..7, color: color.to_s).to_a
  end

  # scope method for determining which games do not have a black_player
  def self.with_one_player
    where(black_player_id: nil)
  end
  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player
end
