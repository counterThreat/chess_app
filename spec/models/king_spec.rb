require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move? method" do
    mygame = FactoryGirl.create(:game)
    anna = FactoryGirl.create(:user)
    king = FactoryGirl.create(:king, game: mygame, user: anna)

    it 'returns true if moving one square east' do
      newmove = king.valid_move?(5, 0)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square north' do
      newmove = king.valid_move?(3, 1)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square northeast' do
      newmove = king.valid_move?(4, 1)
      expect(newmove).to eq true
    end

    it 'returns false if moving more than one square north' do
      newmove = king.valid_move?(3,5)
      expect(newmove).to eq false
    end

    it 'returns false if moving more than one square east' do
      newmove = king.valid_move?(6,0)
      expect(newmove).to eq false
    end

    it 'returns false if moving to a random square on the board' do
      newmove = king.valid_move?(2,7)
      expect(newmove).to eq false
    end

    it 'returns false if trying to move off the board' do
      newmove = king.valid_move?(-1,8)
      expect(newmove).to eq false
    end
  end
end
