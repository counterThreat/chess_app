require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'successfully creates' do
    before do
      @game = Game.create!
    end

    it 'has first turn go to the white player' do
      expect(@game.turn).to eq 'white'
    end

    it 'has the move_number set to 1' do
      expect(@game.move_number).to eq 1
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq 32
    end
  end

  describe 'associate_pieces!' do
    before do
      @game = Game.create!
    end

    it 'associates the pieces with the color of the respective player as white or black' do
      # need piece model and controller to be more fleshed out to write this test
    end
  end

  describe 'with_one_player' do
    it 'returns game with one player' do
      @game = create(:game_with_white_player)
      expect(@game.black_player_id).to eq(nil)
    end
  end
end
