class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @pieces = @game.pieces
    render json: @pieces
  end

  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    current_game
    current_piece
    x = params[:x_position]
    y = params[:y_position]

    if current_piece && x.present? && y.present?
      current_piece.update_attributes(x_position: x, y_position: y)
    end

    render json: {
      update_url: game_path(current_game)
    }
  end

  private

  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end

  def current_game
    @game ||= current_piece.game
  end
end
