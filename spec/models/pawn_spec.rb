require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    context 'white pawn, x = 5, y = 2' do
      before do
        user = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        game.pieces.each(&:destroy)
        white_pawn = FactoryGirl.create(:piece, game: game, user: user)
        game.pieces << white_pawn
      end

      it 'can move one square forward' do
        expect(white_pawn.forward_one_square?(5, 3, 1)).to eq true
      end

      it 'cant move backwards' do
        expect(white_pawn.forward_one_square?(5, 1, 1)).to eq false
      end

      it 'cant move forward two squares' do
        expect(white_pawn.forward_two_squares?(5, 4, 1)).to eq false
      end

      it 'cant move to an empty square diagonally' do
        expect(white_pawn.capture_diagonally?(5, 3, 1)).to eq false
      end
    end

    context 'determining first move' do
      before do
        user = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        game.pieces.each(&:destroy)
        white_pawn = FactoryGirl.create(:piece, game: game)
        game.pieces << white_pawn
      end

      it 'finds first move as true' do
        expect(white_pawn.first_turn?).to eq true
      end

      it 'can move two squares' do
        expect(white_pawn.forward_two_squares?(5, 4, 1)).to eq true
      end

      it 'can move one square' do
        expect(white_pawn.forward_one_square?(5, 3, 1)).to eq true
      end
    end
  end
end
