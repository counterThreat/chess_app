require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associate_pieces!' do
    before do
      @game = create(:game)
    end

    it 'associates the pieces with the color of the respective player as white or black' do
      # need piece model and controller to be more fleshed out to write this test
    end
  end

  describe 'with_one_player' do
    it 'returns games with one player' do
      game = create(:game_with_white_player)
      expect(game.black_player_id).to eq(nil)
    end
  end
end
