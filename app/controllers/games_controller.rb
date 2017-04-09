class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = Game.new
  end

  def create
  end

  def show
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
