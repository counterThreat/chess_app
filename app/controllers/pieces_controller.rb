class PiecesController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def show

  end

  def update
    @piece = Piece.find(params[:id])
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if @piece.user_id == current_user.id
			if @piece.move(x_new, y_new)
				respond_to do |format|
					format.html { render :show }
					format.json { render json: @piece, status: :ok }
				end
			else
				render json: 'failure'
			end
		end
  end
end

private

def piece_params
  params.require(:piece).permit(:x_position, :y_position, :type, :color, :game_id, :user_id, :captured)
end
