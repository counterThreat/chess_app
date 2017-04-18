require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'successfully creates' do
    before do
      @game = create(:game)
      @game.send(:populate_board!)
      @game.send(:first_turn!)
    end

    it 'has 32 pieces' do
      expect(@game.pieces.count).to eq(32)
    end

    it 'turn is white after creation' do
      expect(@game.turn).to eq('white')
    end

    it 'has 1 as move_number' do
      expect(@game.move_number).to eq(1)
    end
  end
end
