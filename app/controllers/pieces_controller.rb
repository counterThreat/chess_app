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
    x_param = params[:x_new].to_i
    y_param = params[:y_new].to_i

    if current_piece.move(x_param, y_param)
      render json: { success: true }
      current_piece.update_attributes(x_position: x_param, y_position: y_param, updated_at: Time.now )
    else
      render json: { success: false, message: 'Illegal move.' }
    end
  end
    ## @piece = Piece.find(params[:id])
    ## @game = @piece.game
    ## x = params[:x_position]
    ## y = params[:y_position]

    ## if @piece && x.present? && y.present?
    ##   @piece.update_attributes(x_position: x, y_position: y)
    ## end

    ## render json: {
    ##   update_url: game_path(@game)
    ## }

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
