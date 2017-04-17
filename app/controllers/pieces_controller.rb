class PiecesController < ApplicationController
  def update
    x_value = params[:x_new].to_i
    y_value = params[:y_new].to_i
    if current_piece.color != current_game.turn
      render json: { success: false, message: "It isn't your turn yet." }
    elsif current_piece.move!(x_value, y_value)
      render json: { success: true }
    else
      render json: { success: false, message: 'Not a valid move.' }
    end
  end

  private

  def current_game
    @game ||= current_piece.game
  end

  def current_piece
    @piece ||= Piece.find(params[:id])
  end
end
