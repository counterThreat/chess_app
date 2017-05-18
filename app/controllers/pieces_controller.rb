class PiecesController < ApplicationController
  # before_action :authorize_player, only: [:update]
  before_action :own_piece?, only: [:update]

  def own_piece?
    game = current_piece.game
    user_id = params[:piece][:user_id]
    render plain: {'msg': 'Not your turn', 'piece_id': params[:piece][:id]}.to_json, status: :forbidden and return unless current_piece.game.send(:"#{current_piece.color}_player_id") == user_id.to_i && user_id.to_i == current_user.id
  end

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
    render json: @piece
  end

  def update
    game = current_piece.game
    x = params[:piece][:x_position].to_i
    y = params[:piece][:y_position].to_i
    puts 'in update action'
    current_piece.move(x, y)
    game.reload
    game.end_game_checkmate && current_piece.pusher_game_end if game.checkmate
    game.end_game_stalemate && current_piece.pusher_game_end if game.stalemate
    #game.end_game_draw && current_piece.pusher_game_end if game.draw
    unless Rails.env == 'test'
      Pusher.trigger("game-channel-#{game.id}", 'piece-moved', {
        message: 'A piece has been moved'
      })

      Pusher.trigger("game-channel-#{game.id}", 'current-turn', {
        message: "It is #{current_piece.color}'s move."
      })
    end
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
