class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :join] # quit/forefit
  respond_to :html, :json

  def index
    @games = Game.open.all
    @game = Game.new
  end

  def create
    @game = current_user.games_as_white.create!(game_params.merge(white_player_id: current_user))
    @game.associate_pieces!(current_user, 'white')
    flash[:notice] = 'You are the white player. You will be notified when a black player joines the game!'
    redirect_to game_path(@game)
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = 'That name is already taken. Please choose another.'
    redirect_to root_path
  end

  def join
    @game = current_game
    if @game.black_player.nil? && current_user != @game.white_player
      current_user.games_as_black.update_attributes(game_params.merge(black_player_id: current_user))
      flash[:notice] = 'You are the black player. Begin play!'
      redirect_to game_path(@game)
    else
      flash[:alert] = 'Either the game is already full or you are also logged as the white player!'
      redirect_to root_path
    end
  end

  def show
    current_game
    # render the pieces on the board
  end

  # add update, join, forefit, draw, check/checkmate(here or pieces controller/model), load-board functions

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
