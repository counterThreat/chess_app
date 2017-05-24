class StaticPagesController < ApplicationController
  def index
    @game = Game.new
    @games = Game.all
    @top_users = User.order(wins: :desc).all
  end
end
