class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def update
    @game = Game.find(params[:game_id])
  end
end

private

def piece_params
  params.require(:piece).permit(:x_position, :y_position, :captured)
end
