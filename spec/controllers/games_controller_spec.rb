require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'GET /new' do
    it 'links to a landing page to create a game' do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST /create' do
    it 'creates and redirects to a new game w user as white player' do
      user = create(:user)
      sign_in user
      post :create, game: { name: 'test name' }
      expect(assigns(:game).white_player).to eq(user.id)
      expect(response).to redirect_to(game_path(assigns(:game)))
    end
  end

  describe 'GET /index' do
    it 'successfully returns the index' do
      create(:game)
      get :index, params: { game: { name: 'test game' } }
      expect(response).to be_success
    end
  end

  describe 'GET /show' do
    # let(:game) { create(:game) }
    # describe 'current game loads' do
    it 'returns the current_game w/o error' do
      user = create(:user)
      sign_in user
      game = create(:game)
      get :show, params: { id: game.id }, format: :json
      expect(response).to be_success
    end
  end

  describe 'GET /edit' do
    it 'returns specific game edit form' do
      user = create(:user)
      sign_in user
      game = create(:game)
      get :edit, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'updates game with black_player_id' do
      user = create(:user)
      sign_in user
      game = create(:game)
      patch :update, id: game
      expect(assigns(:game).black_player).to eq(user.id)
      expect(response).to redirect_to(game_path(:game))
    end
  end
end
