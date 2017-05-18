class PiecesController < ApplicationController
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
    game.reload
    game.end_game_checkmate && pusher_game_end if game.checkmate
    game.end_game_stalemate && pusher_game_end if game.stalemate
    unless Rails.env == 'test'
      Pusher.trigger("game-channel-#{game.id}", 'piece-moved', {
        message: 'A piece has been moved'
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

  # def piece_params
  # params.require(:piece).permit(:x_position, :y_position, :color, :game_id, :user_id, :captured, :move_num)
  # end

  def url_status
    return :ok if try_success?
    :forbidden
  end
end
