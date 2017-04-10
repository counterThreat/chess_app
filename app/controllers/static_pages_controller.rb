class StaticPagesController < ApplicationController

  def index
    @game = Game.new
  end

end
