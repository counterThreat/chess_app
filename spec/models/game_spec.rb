require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'successfully creates' do
    it 'successfully links white player and user' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.white_player_id).to eq 0
    end

    it 'has both white and black pplayers' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.white_player_id).to eq 0
      expect(game.black_player_id).to eq 1
    end

    it 'has a black_player' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.black_player_id).to eq 1
    end

    it 'has the move_number set to 1' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.move_number).to eq 1
    end

    it 'has 32 pieces' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.pieces.count).to eq 32
    end
  end
end
