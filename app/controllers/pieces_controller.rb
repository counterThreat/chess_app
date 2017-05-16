class PiecesController < ApplicationController
  # before_action :authorize_player, only: [:update]
  # before_action :check_turn, only: [:update]

  def index
    @game = Game.find(params[:game_id])
    @pieces = Piece.where(game_id: @game.id)
    # @game = Game.find(params[:game_id])
    render json: @pieces
  end

  # def create
  #  @pieces = current_game.pieces.create(piece_params)
  # end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    game = current_piece.game
    x = params[:piece][:x_position].to_i
    y = params[:piece][:y_position].to_i

    current_piece.move(x, y)
    # && pusher_status
    Pusher.trigger("game-channel-#{game.id}", 'piece-moved', {
      message: 'A piece has been moved'
    })

    Pusher.trigger("game-channel-#{game.id}", 'current-turn', {
      message: "It is #{current_piece.color}'s move."
    })

    render json: current_piece.game.pieces
  end

  def current_game
    @game ||= current_piece.game
  end

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  private

  def url_status
    return :ok if try_success?
    :forbidden
  end
end
