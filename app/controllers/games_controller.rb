class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  respond_to :html, :json

  def index
    @games = Game.all
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
      @game.black_player_join!(current_user)
      flash[:notice] = 'You are the black player. Begin play!'
      redirect_to game_path(@game)
    else
      flash[:alert] = 'Either the game is already full or you are also logged as the white player!'
      redirect_to root_path
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

  def edit
    @game = current_game
  end

  def update
    @game = current_game
    @game.update_attributes(game_params)
    if @game.valid?
      flash[:notice] = 'You are the black player. The white player can now begin the game'
      redirect_to game_path(@game)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  # add update, join, forefit, draw, check/checkmate(here or pieces controller/model), load-board functions

  private

  def game_params
    params.require(:game).permit(:name, :black_player_id)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
