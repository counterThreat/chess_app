require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    mygame = FactoryGirl.create(:game)
    madonna = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:black_pawn, game: mygame, user: madonna)

    it 'returns true if valid_move? is true' do
      newmove = pawn.valid_move?(1, 2)
      expect(newmove).to eq true
    end

    it 'returns false if valid_move? is false' do
      newmove = pawn.valid_move?(4, 2)
      expect(newmove).to eq false
    end
  end

  describe 'pawn_possible?' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)
    FactoryGirl.create(:opponent_pawn, game: mygame, user: doug)

    it 'returns true if valid_vertical_move? is correct' do
      newmove = pawn.valid_vertical_move?(1, 4)
      expect(newmove).to eq true
    end

    it 'returns true if valid_capture? is true' do
      newmove = pawn.valid_capture?(2, 5)
      expect(newmove).to eq true
    end

    it 'returns true if y exceeds bounds' do
      newmove = pawn.y_out_of_bounds?(3)
      expect(newmove).to eq true
    end
  end

  describe 'y_move' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'tells whether a move is the first or second move' do
      newmove = pawn.y_move
      expect(newmove).to eq 2
    end
  end

  describe 'forward direction' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'tells whether the accurate forward for each piece is correct' do
      newmove = pawn.forward_move?(5)
      expect(newmove).to eq true
    end
  end
end
