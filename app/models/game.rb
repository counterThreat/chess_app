class Game < ApplicationRecord
  has_many :pieces
  belongs_to :white_player, class_name: 'User', required: false
  belongs_to :black_player, class_name: 'User', required: false
  belongs_to :winning_player, class_name: 'User', required: false
  
  after_create :make_newboard
  validates :name, presence: true
  
  enum current_player: [:current_user_is_black_player, :current_user_is_white_player]

  def players
    [white_player, black_player].compact
  end
  
  def forfeiting_player!(player)
    if player == white_player
      game_winner = black_player
    else
      game_winner = white_player
    end
    udpate!(winner: game_winner)
  end
  
  def find_piece(x_position, y_position)
    pieces.find_by(x_position: x_position, y_position: y_position)
  end

  def make_newboard
    # create and place white pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 1, color: 'black', user_id: white_player_id, unicode: '&#9823;')
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9820;')
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9820;')
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9822;')
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9822;')
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9821;')
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9821;')
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9819')
    King.create(game_id: id, x_position: 4, y_position: 0, color: 'black', user_id: white_player_id, unicode: '&#9818;')

    # create and place black pieces
    (0..7).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 6, color: 'white', user_id: white_player_id, unicode: '&#9817;')
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9814;')
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9814;')
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9816;')
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9816;')
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9815;')
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9815;')
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9813;')
    King.create(game_id: id, x_position: 4, y_position: 7, color: 'white', user_id: white_player_id, unicode: '&#9812;')
  end

  def associate_pieces!
    pieces.where(color: 'black').update(user_id: black_player_id)
  end

  # scope method for determining which games do not have a black_player
  def self.with_one_player
    where(black_player_id: nil)
  end
  # from here first thing to do is create method for player joining a free game
  # where white player is already present so we need a JOIN method that focuses
  # on the black player since the game is created with the white player

  def check
    # needs to incorporate color of player whose turn it is
    pieces.reload
    black_king = pieces.find_by(type: 'King', color: 'black')
    white_king = pieces.find_by(type: 'King', color: 'white')
    pieces.each do |piece|
      return 'black' if piece.valid_move?(black_king.x_position, black_king.y_position) && piece.color == 'white'
      return 'white' if piece.valid_move?(white_king.x_position, white_king.y_position) && piece.color == 'black'
    end
    nil
  end

  def checkmate
    # needs to incorporate color of player whose turn it is
    friendly_pieces = pieces.where(color: check)
    if !check.nil?
      friendly_pieces.each do |piece|
        (0..7).each do |x|
          (0..7).each do |y|
            if piece.valid_move?(x, y)
              original_x = piece.x_position
              original_y = piece.y_position
              captured_piece = pieces.find_by(x_position: x, y_position: y)
              begin
                captured_piece.update(x_position: -1, y_position: -1) if captured_piece
                piece.update(x_position: x, y_position: y)
                check_state = check
              ensure
                piece.update(x_position: original_x, y_position: original_y)
                captured_piece.update(x_position: x, y_position: y) if captured_piece
              end
              return false if check_state.nil?
            end
          end
        end
      end
    end
    true
  end

  def pieces_no_king(color)
    pieces.where.not(type: 'King', color: color)
  end
end
