class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:forfeit]

  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def create
    @game = current_user.games_as_white.create!(game_params.merge(white_player_id: current_user))
    if @game.valid?
      flash[:notice] = 'You are the white player. You will be notified when a black player joins the game!'
      redirect_to game_path(@game)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def show
    @game = current_game
    @pieces = current_game.pieces.order(:y_position).order(:x_position).to_a

    flash.now[:notice] = @game.check.upcase + ' IN CHECK' if @game.check
    flash.now[:notice] = @game.check.upcase + ' IN CHECKMATE' if @game.check && @game.checkmate
    unless Rails.env == 'test'
      Pusher.trigger("player-channel-#{@game.id}", 'new-player', {
        message: 'black player has joined the game'
      })
    end

    # html/json
    respond_to do |format|
      format.json { render json: @game.pieces } # render json: @pieces
      format.html
    end
  end

  def data_view
    @game = current_game
    render json: @game
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

  def draw
    current_game.end_game_draw(current_user)
    redirect_to games_path, alert: 'The game has been drawn.'
  end

  def forfeit
    current_game.end_game_forfeit(current_user)
    redirect_to games_path, alert: 'You forfeited the game.'
  end

  # add update, join, forefit, draw, check/checkmate(here or pieces controller/model), load-board functions

  def text
    "You can't perform that action."
  end

  private

  def game_params
    params.require(:game).permit(:name, :black_player_id)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end

  def authorize_user
    render html: text, status: :unauthorized unless current_game.black_player == current_user || current_game.white_player == current_user
  end
end
