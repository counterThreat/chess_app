require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'game_with_white_and_black_players' do
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
end
