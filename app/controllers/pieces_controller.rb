class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    current_piece

    x = params[:x_position]
    y = params[:y_position]

    if current_piece && x.present? && y.present?
      current_piece.update_attributes(x_position: x, y_position: y, updated_at: Time.now)
    end

    render json: {
      update_url: game_path(current_game)
    }
  end

  private

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :type, :color, :game_id, :user_id, :captured)
  end

  def current_game
    @game ||= current_piece.game
  end

  def url_status
    return :ok if try_success?
    :forbidden
  end
end
