require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associate_pieces!' do
    it 'assigns black to the  black_player pieces' do
      user1 = create(:user)
      user2 = create(:user)
      game = create(:game_with_white_and_black_players, white_player_id: user1.id, black_player_id: user2.id)
      piece = create(:bishop, color: 'Black', game: game, user_id: game.white_player_id)
      game.associate_pieces!
      piece.reload
      expect(piece.user_id).to eq(game.black_player_id)
    end
  end
  # it 'associates the pieces with the color of the respective player as white or black' do
  #   # need piece model and controller to be more fleshed out to write this test
  # end
  describe 'with_one_player' do
    it 'returns games with one player' do
      game = create(:game_with_white_player)
      expect(game.black_player_id).to eq(nil)
    end
  end

  describe 'check method' do
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    check_game = FactoryGirl.create(:game_with_white_and_black_players, white_player_id: user3.id, black_player_id: user4.id)
    king = FactoryGirl.create(:king, color: 'White', game: check_game, user_id: check_game.white_player_id)
    rook = FactoryGirl.create(:rook, color: 'White', game: check_game,
    user_id: check_game.white_player_id, x_position: 0, y_position: 1)
    bishop = FactoryGirl.create(:bishop, color: 'Black', game: check_game,
    user_id: check_game.black_player_id, x_position: 1, y_position: 1)

    it 'returns the color of the king in check when in check by opponent' do
      # user3 = FactoryGirl.create(:user)
      # user4 = FactoryGirl.create(:user)
      # check_game = FactoryGirl.create(:game_with_white_and_black_players, white_player_id: user3.id, black_player_id: user4.id)
      # king = FactoryGirl.create(:king, color: 'White', game: check_game, user_id: check_game.white_player_id)
      # bishop = FactoryGirl.create(:bishop, color: 'Black', game: check_game,
      # user_id: check_game.black_player_id, x_position: 1, y_position: 1)
      # bishop.move(2, 2)
      # expect(check_game.check(king.color)).to eq 'White'
    end
    it 'returns color of the king in check when in friendly check' do
      # rook.move(0, 0)
      # expect(check_game.check).to eq 'White'
    end
    it 'returns nil when neither king is in check' do
      # expect(check_game.check).to eq nil
    end
  end
end
