require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'successfully creates' do
    it 'has a name' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game)
      expect(game.name).to eq 'test game'
    end

    it 'has a white player' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game_with_white_only)
      expect(game.white_player_id).to eq 0
    end

    it 'has both white and black players' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game_with_white_and_black)
      expect(game.white_player_id).to eq 0
      expect(game.black_player_id).to eq 1
    end

    it 'has a black_player' do
      elvis = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game_with_black_only)
      expect(game.black_player_id).to eq 1
    end
  end
end
