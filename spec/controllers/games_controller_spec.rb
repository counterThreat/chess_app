require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#index' do
    it 'puts games with only a white player in the index as available' do
      game = create(:game_with_white_player)
      get :index
      expect(assigns(:games)).to include game
    end
  end

  describe 'game#create' do
  end

  describe 'game#show' do
  end
end
