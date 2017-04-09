class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @game = Game.new
  end

  def create
    @game = current_user.games_as_white.create!(game_params.merge(white_player_id: current_user))
    @game.associate_pieces!(current_user, 'white')
    if @game.valid?
      flash[:notice] = 'You are the white player. Begin play!'
      redirect_to game_path(@game)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def show
    @game = current_game
    respond_to do |format|
      format.json { render json: @game.pieces }
      format.html
    end
    # render the pieces on the board
  end

  # add update, join, forefit, draw, check/checkmate(here or pieces controller/model), load-board functions

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
