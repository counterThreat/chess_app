class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def create
    @game = current_user.games_as_white.create!(game_params.merge(white_player_id: current_user))
    if @game.valid?
      flash[:notice] = 'You are the white player. You will be notified when a black player joines the game!'
      redirect_to game_path(@game)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def show
    @game = current_game
    flash.now[:notice] = @game.check.upcase + ' IN CHECK' if @game.check
    flash.now[:notice] = @game.check.upcase + ' IN CHECKMATE' if @game.check && @game.checkmate

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
    @game.reload
    @game.associate_pieces!
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
