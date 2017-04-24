class PiecesController < ApplicationController
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    x = params[:x_position]
    y = params[:y_position]

    if @piece && x.present? && y.present?
      @piece.update_attributes(x_position: x, y_position: y)
    end

    render json: {
      update_url: game_path(@game)
    }
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :type, :color, :game_id, :user_id, :captured)
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
