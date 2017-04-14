require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#index' do
    it 'lists games with 1 white player but no black players in @games' do
      game = create(:game_with_white_player)
      get :index
      expect(assigns(:games)).to include game
    end

    it 'lists games with 1 black player but no white players in @games' do
      game = create(:game_with_black_player)
      get :index
      expect(assigns(:games)).to include game
    end

    it 'does not list games with 1 black player and 1 white player in @games' do
      game = create(:game_with_white_and_black_players)
      get :index
      expect(assigns(:games)).not_to include game
    end

    it 'links to a modal form to successfully initiate a new game' do
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
      post :create, game: { name: 'test game' }
      expect(assigns(:game).white_player_id).to eq(user.id)
    end

    it 'creates a new game and redirects the user to the game path' do
      user = create(:user)
      sign_in user
      post :create, game: { name: 'test game' }
      expect(assigns(:game).white_player_id).to eq(user.id)
      expect(response).to redirect_to game_path(assigns(:game))
    end
  end

  describe 'game#join' do
    it 'ensures that black player is joining free game and assigned id to match' do
      user = create(:user)
      sign_in user
      game = create(:game_with_white_player)
      patch :join, id: game
      expect(assigns(:game).black_player_id).to eq(user.id)
      expect(response).to redirect_to(game_path(game))
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

    context 'format.json' do
      it 'succeeds' do
        get :show, id: game.id, format: :json
        expect(response).to be_success
      end
    end

    context 'format.html' do
      it 'succeeds' do
        get :show, id: game.id, format: :html
        expect(response).to be_success
      end
    end
  end
end
