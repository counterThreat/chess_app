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

  describe 'game#edit' do
    it 'returns specific game edit form' do
      user = create(:user)
      sign_in user
      game = create(:game)
      get :edit, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'game#update' do
    it 'updates game with black_player_id' do
      user = create(:user)
      sign_in user
      game = create(:game_with_white_player)
      put :update, params: { id: game.id, game: { black_player_id: 1 } }
      expect(response).to redirect_to game_path(game)
      game.reload
      expect(game.black_player_id).to eq(1)
    end
  end
  
  describe 'game#forfeit' do
    it 'forfeits the game according to the authorized user' do
      white_player = create(:user)
      black_player = create(:user)
      game = create(:game_player_associations, white_player: white_player, black_player: black_player)
      sign_in black_player
      
      put :forfeit, id: game
      expect(response).to redirect_to games_path
      expect(game.reload.winning_player).to eq white_player
    end
    
    it 'returns an error if you try to forfeit and its not your turn' do
      game = create(:game_player_associations)
      sign_in create(:user)
      put :forfeit, id: game
      expect(response).to have_http_status(:unauthorized)
      expect(game.reload.winner).to be_nil
    end
    
    it 'requires that user be signed in' do
      game = create(:game_player_associations)
      put :forfeit, id: game
      expect(response).to redirect_to new_user_session_path
      expect(game.reload.winner).to be_nil
    end
  end
end
