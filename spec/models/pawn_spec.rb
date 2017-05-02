require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    mygame = FactoryGirl.create(:game)
    madonna = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:black_pawn, game: mygame, user: madonna)

    it 'returns true if valid_move? is true' do
      newmove = pawn.valid_move?(2, 5)
      expect(newmove).to eq true
    end

    it 'returns false if valid_move? is false' do
      newmove = pawn.valid_move?(5, 8)
      expect(newmove).to eq false
    end
  end

  describe 'pawn_possible?' do
    mygame = FactoryGirl.create(:game)
    doug = FactoryGirl.create(:user)
    pawn = FactoryGirl.create(:pawn, game: mygame, user: doug)
    FactoryGirl.create(:opponent_pawn, game: mygame, user: doug)

    it 'returns true if valid_vertical_move? is correct' do
      newmove = pawn.valid_vertical_move?(2, 4)
      expect(newmove).to eq true
    end

    it 'returns true if valid_capture? is true' do
      newmove = pawn.valid_capture?(3, 3)
      expect(newmove).to eq true
    end

    it 'returns true if y exceeds bounds' do
      newmove = pawn.y_out_of_bounds?(6)
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
      newmove = pawn.forward_move?(4)
      expect(newmove).to eq true
    end
  end

  describe 'is en passant capture possible?' do
      mygame = FactoryGirl.create(:game)
      soren = FactoryGirl.create(:user)
      whitepawn = FactoryGirl.create(:capturing_ep_pawn, game: mygame, user: soren)
      blackpawn = FactoryGirl.create(:capturable_ep_pawn, game: mygame, user: soren)

      it 'returns true if valid_en_passant? is true' do
      blackpawn.move(3, 5)
      newmove = whitepawn.valid_capture?(2, 6)
      expect(newmove).to eq true

  describe 'en passant moves' do
    #puts "here comes the problem"
    #puts pawn_black_47.persisted?
    #puts pawn_black_47.errors.inspect
    #puts "see above" 

    it 'returns true for en passant passant capture' do
      myepgame = FactoryGirl.create(:game)
      pawngrabber = FactoryGirl.create(:user)
      FactoryGirl.create(:king_white_51, game: myepgame, user: pawngrabber)
      FactoryGirl.create(:king_black_58, game: myepgame, user: pawngrabber)
      pawn_white_55 = FactoryGirl.create(:pawn_white_55, game: myepgame, user: pawngrabber)
      pawn_black_47 = FactoryGirl.create(:pawn_black_47, game: myepgame, user: pawngrabber)
      pawn_black_47.move(4, 5)
      expect(pawn_white_55.valid_en_passant?(4, 6)).to eq(true)
    end
  end
end
