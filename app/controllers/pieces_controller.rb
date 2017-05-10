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
    x = piece_params[:x_position]
    y = piece_params[:y_position]
    current_piece.update_attributes(x_position: x, y_position: y, updated_at: Time.now) if current_piece && x.present? && y.present?
    Pusher.trigger("game-channel-#{game.id}", 'piece-moved', {
      message: 'A piece has been moved'
    })
    render json: { status: :ok } && return if request.xhr?
    redirect_to current_piece.game
  end

  def current_game
    @game ||= current_piece.game
  end

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :color, :game_id, :user_id, :captured, :move_num)
  end

  def url_status
    return :ok if try_success?
    :forbidden
  end
end
