require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'pawn_possible?' do
    mygame = FactoryGirl.create(:game)
    madonna = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: madonna)

    it 'returns true if pawn_possible? is correct' do
      newmove = pawn.pawn_possible?(1, 2)
      expect(newmove).to eq true
    end
    it 'returns false if pawn_possible is false' do
      newmove = pawn.pawn_possible?(4, 2)
      expect(newmove).to eq false
    end
  end

  describe 'valid_move?' do
    mygame = FactoryGirl.create(:game)
    madonna = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: madonna)

    it 'returns true if valid_move? is true' do
      newmove = pawn.valid_move?(1,2)
      expect(newmove).to eq true
    end

    it 'returns false if valid_move? is false' do
      newmove = pawn.valid_move?(4,2)
    end
  end

  describe 'pawn_possible?' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)

    it 'returns true if valid_vertical_move? is correct' do
      newmove = pawn.valid_vertical_move?(1, 2)
      expect(newmove).to eq true
    end

    it 'returns true if valid_capture? is true' do
      newmove = pawn.valid_capture?(2,2)
      expect(newmove).to eq true
    end

    it 'returns false if y exceeds bounds' do
      newmove = pawn.exceeds_bounds?(1, 4)
      expect(newmove).to eq false
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
