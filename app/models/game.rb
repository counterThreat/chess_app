class Game < ApplicationRecord
  has_many :pieces
  belongs_to :white_player, class_name: 'User', required: false
  belongs_to :black_player, class_name: 'User', required: false
  belongs_to :winning_player, class_name: 'User', required: false

  after_create :make_newboard
  validates :name, presence: true

  scope :active_games, (-> { where(winning_player: nil) })

  def players
    [white_player, black_player].compact
  end

  def drawing_player!
    update(outcome: "draw")
  end

  def find_piece(x_position, y_position)
    pieces.find_by(x_position: x_position, y_position: y_position)
  end

  def make_newboard
  # create and place white pieces
    (1..8).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 2, color: 'white', user_id: white_player_id, unicode: '&#9817;')
    end

    Rook.create(game_id: id, x_position: 1, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9814;')
    Rook.create(game_id: id, x_position: 8, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9814;')
    Knight.create(game_id: id, x_position: 2, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9816;')
    Knight.create(game_id: id, x_position: 7, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9816;')
    Bishop.create(game_id: id, x_position: 3, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9815;')
    Bishop.create(game_id: id, x_position: 6, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9815;')
    Queen.create(game_id: id, x_position: 4, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9813;')
    King.create(game_id: id, x_position: 5, y_position: 1, color: 'white', user_id: white_player_id, unicode: '&#9812;')

    # create and place black pieces
    (1..8).each do |i|
      Pawn.create(game_id: id, x_position: i, y_position: 7, color: 'black', user_id: white_player_id, unicode: '&#9823;')
    end

    Rook.create(game_id: id, x_position: 1, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9820;')
    Rook.create(game_id: id, x_position: 8, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9820;')
    Knight.create(game_id: id, x_position: 2, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9822;')
    Knight.create(game_id: id, x_position: 7, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9822;')
    Bishop.create(game_id: id, x_position: 3, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9821;')
    Bishop.create(game_id: id, x_position: 6, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9821;')
    Queen.create(game_id: id, x_position: 4, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9819')
    King.create(game_id: id, x_position: 5, y_position: 8, color: 'black', user_id: white_player_id, unicode: '&#9818;')
  end

  def associate_pieces!
    pieces.where(color: 'black').update(user_id: black_player_id)
  end

  # scope method for determining which games do not have a black_player
  def self.with_one_player
    where(black_player_id: nil)
  end

  def check
    pieces.reload
    black_king = pieces.find_by(type: 'King', color: 'black')
    white_king = pieces.find_by(type: 'King', color: 'white')
    pieces.each do |piece|
      return 'black' if piece.valid_move?(black_king.x_position, black_king.y_position) && piece.color == 'white' && piece.captured == false
      return 'white' if piece.valid_move?(white_king.x_position, white_king.y_position) && piece.color == 'black' && piece.captured == false
    end
    nil
  end

  def no_legal_next_move?
    friendly_pieces = pieces.where(color: player_turn, captured: false)
    friendly_pieces.each do |piece|
      (1..8).each do |x|
        (1..8).each do |y|
          if piece.valid_move?(x, y)
            original_x = piece.x_position
            original_y = piece.y_position
            captured_piece = pieces.find_by(x_position: x, y_position: y)
            begin
              captured_piece.update(x_position: -1, y_position: -1) if captured_piece
              piece.update(x_position: x, y_position: y)
              reload
              check_state = check
            ensure
              piece.update(x_position: original_x, y_position: original_y)
              captured_piece.update(x_position: x, y_position: y) if captured_piece
              reload
            end
            if check_state.nil?
              return false
            end
          end
        end
      end
    end
    true
  end

  def checkmate
    if !check.nil?
      return true if no_legal_next_move?
    end
    false
  end

  def stalemate
    if check.nil?
      return true if no_legal_next_move?
    end
    false
  end

  def pieces_no_king(color)
    pieces.where.not(type: 'King', color: color)
  end

  def next_turn
    if player_turn == 'white'
      update(player_turn: 'black')
    else
      update(player_turn: 'white')
    end
  end

  def end_game_checkmate
    winning_player_color = player_turn == 'white' ? 'black' : 'white'
    winning_id = pieces.find_by(type: 'King', color: winning_player_color).user_id
    update(winning_player_id: winning_id)
    update(outcome: 'checkmate')
    update(finished: Time.now)
  end

  def end_game_stalemate
    update(outcome: 'stalemate')
    update(finished: Time.now)
  end

  def end_game_forfeit(player)
    winning_player = player == white_player ? black_player : white_player
    update(winning_player_id: winning_player.id)
    update(outcome: 'forfeit')
    update(finished: Time.now)
  end
end
