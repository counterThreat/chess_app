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
      get :show, params: { id: game }
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

      put :forfeit, params: { id: game }
      expect(response).to redirect_to games_path
      expect(game.reload.winner).to eq white_player
    end

    it 'returns an error if you try to forfeit and its not your turn' do
      game = create(:game_player_associations)
      sign_in create(:user)
      put :forfeit, params: { id: game }
      expect(response).to have_http_status(:unauthorized)
      expect(game.reload.winner).to be_nil
    end

    it 'requires that user be signed in' do
      game = create(:game_player_associations)
      put :forfeit, params: { id: game }
      expect(response).to redirect_to new_user_session_path
      expect(game.reload.winner).to be_nil
    end
  end

  describe 'game#finish' do
    it 'updates winning_player_id, outcome, and finished for a checkmate' do
      white_player = create(:user)
      black_player = create(:user)
      check_game = create(:game_player_associations, white_player: white_player, white_player_id: white_player.id, black_player: black_player, black_player_id: black_player.id)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user: white_player, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user: black_player, x_position: 8, y_position: 7)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user: black_player)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 2, y_position: 3, user: black_player)
      puts check_game.reload.checkmate('white')
      winning_player_color = 'black' if check_game.checkmate('white')
      winning_player_color = 'white' if check_game.checkmate('black')
      winning_player = winning_player_color == 'white' ? white_player : black_player
      puts winning_player.id
      puts white_player.id
      puts black_player.id
      put :finish, params: { id: check_game.id }

      expect(check_game.reload.outcome).to eq 'checkmate'
      expect(check_game.finished.utc).to be_within(1.second).of Time.now
      expect(check_game.reload.winning_player_id).to eq black_player.id
    end
=begin
    it 'updates outcome and finished for a stalemate' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user_id: user3.id, x_position: 6, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: game1, user_id: user4.id, x_position: 7, y_position: 6)

      expect(game1.winning_player_id).to eq nil
      expect(game1.outcome).to eq 'stalemate'
      expect(game1.finished.utc).to to be_within(1.second).of Time.now
    end

    it 'updates winning_player_id, outcome, and finished for a forfeit' do
      white_player = create(:user)
      black_player = create(:user)
      game = create(:game_player_associations, white_player: white_player, black_player: black_player)
      game.forfeiting_player!(white_player)

      expect(game.winning_player_id).to eq black_player.id
      expect(game.outcome).to eq 'forfeit'
      expect(game.finished.utc).to to be_within(1.second).of Time.now
    end

    it 'renders the game unalterable after an outcome is determined'
=end
  end
end
