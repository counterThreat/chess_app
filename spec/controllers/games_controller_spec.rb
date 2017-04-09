require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#index' do
    it 'successfully a ppears' do
      create(:game_with_white_player)
      get :index, game_with_white_player: { name: 'test game', white_player_id: 0 }
      expect(response).to be_success
    end
  end

  describe 'game#create' do
    it 'creates a new game with the current user as the white player' do
      user = create(:user)
      sign_in user
      post :create, game: { name: 'test game' }
      expect(assigns(:game).white_player_id).to eq(user.id)
    end

    it 'creates a new game and redirects the user to the game path' do
      user = create(:user)
      sign_in user
      post :create, game: { name: 'test game' }
      expect(response).to redirect_to game_path(assigns(:game))
    end
  end

  describe 'game#show' do
    let(:game) { create(:game) }

    describe 'current game loads' do
      it 'returns the current_game w/o error' do
        get :show, id: game.id
        expect(response).to be_success
      end
    end
  end
end
