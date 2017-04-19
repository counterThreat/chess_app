class PiecesController < ApplicationController
  def index
    render json: Piece.order(:game_id)
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
