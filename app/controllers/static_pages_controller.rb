class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:update]

  def index
    @game = Game.new
    @games = Game.all
  end

end
