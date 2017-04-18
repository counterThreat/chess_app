require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    mygame = FactoryGirl.create(:game)
    madonna = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: madonna)

    it 'returns true if pawn_possible? is correct' do
      newmove = pawn.valid_move?(1, 2)
      expect(newmove).to eq true
    end
    it 'returns false if pawn_possible is false' do
      newmove = pawn.valid_move?(4, 2)
      expect(newmove).to eq false
    end
  end

  describe 'pawn_possible?' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'returns true if forward_one_square? is correct' do
      newmove = pawn.forward_one_square?(1, 2)
      expect(newmove).to eq true
    end

    it 'returns true if forward_two_squares? is true' do
      newmove = pawn.forward_two_squares?(1, 3)
      expect(newmove).to eq true
    end

    it 'returns true if capture_diagonally? is true' do
      newmove = pawn.capture_diagonally?(2, 2)
      expect(newmove).to eq true
    end

    it 'returns false if all of the above are false' do
      newmove = pawn.pawn_possible?(4, 3)
      expect(newmove).to eq false
    end
  end

  describe 'first move' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'returns white if y position is 1' do
      mypawn = pawn.first_move?
      expect(mypawn).to eq true
    end
  end

  describe 'promote?' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'returns true if promote? is true' do
      mypawn = pawn.promote?(7)
      expect(mypawn).to eq true
    end
  end
end
