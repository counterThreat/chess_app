class PiecesController < ApplicationController
  def index
    render json: Piece.order(:game_id)
  end
end
