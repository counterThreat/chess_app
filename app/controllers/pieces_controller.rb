class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:id])
    render json: @game.pieces
  end

  # def update
  # #   piece = Piece.find(params[:id])
  # #   piece.update_attributes(piece_params)
  # #   render json: piece
  # # end
end

private

def piece_params
  params.require(:piece).permit(:x_position, :y_position, :captured)
end
