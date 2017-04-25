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
    x = params[:x_new].to_i
    y = params[:y_new].to_i

    if current_piece.move(x, y)
      render json: { success: true }
      current_piece.update_attributes(x_position: x, y_position: y, updated_at: Time.now)
    else
      render json: { success: false, message: 'Illegal Move' }
    end

    # render json: {
    #   update_url: game_path(@game)
    # }
  end

  private

  def current_piece
    @piece ||= Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position, :type, :color, :game_id, :user_id, :captured)
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
