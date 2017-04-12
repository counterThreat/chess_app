class StaticPagesController < ApplicationController

  def index
    @game = Game.new
    @games = Game.all
  end

end
