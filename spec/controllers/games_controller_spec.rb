require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#new' do
    it 'links to a landing page to create a game' do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to be_success
    end
  end

  describe 'game#create' do
    it 'creates a new game with the current user as the white player' do
      user = create(:user)
      sign_in user
      post :create, params: { game: { name: 'test name' } }
      expect(assigns(:game).white_player_id).to eq(user.id)
    end

    it 'creates a new game and redirects the user to the game path' do
      user = create(:user)
      sign_in user
      post :create, params: { game: { name: 'test name' } }
      expect(response).to redirect_to game_path(assigns(:game))
    end
  end

  describe 'game#show' do
    # let(:game) { create(:game) }
    # describe 'current game loads' do
    it 'returns the current_game w/o error' do
      user = create(:user)
      sign_in user
      game = create(:game)
      get :show, params: { id: game.id }
      expect(response).to be_success
    end
  end
end
