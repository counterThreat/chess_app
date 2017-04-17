require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    context 'white pawn, x = 5, y = 2' do
      before do
        game = create(:game)
        pawn = Pawn.create(x_position: 5, y_position: 2, color: 'white')
        black_pawn = Pawn.create(x_position: 8, y_position: 7, color: 'black', last_move: 0)
        game.pieces << pawn
        game.pieces << black_pawn
      end

      it 'can move one square forward' do
        expect(pawn.forward_one_square?(5, 3, 1)).to eq true
      end

      it 'cant move backwards' do
        expect(pawn.forward_one_square?(5, 1, 1)).to eq false
      end

      it 'cant move forward two squares' do
        expect(pawn.forward_two_squares?(5, 4, 1)).to eq false
      end

      it 'cant move to an empty square diagonally' do
        expect(pawn.capture_diagonally?(5, 3, 1)).to eq false
      end

      it 'cant move into an obstructed square' do
        rook = Rook.create(x_position: 4, y_position: 3, color: 'white')
        game.pieces << rook
        expect(pawn.move?(4, 3)).to eq false
      end

      it 'cant capture its teammate' do
        rook = Rook.create(x_position: 4, y_position: 3, color: 'white')
        game.pieces << rook
        expect(pawn.capture_diagonally?(4, 3, 1)).to eq false
      end

      it 'can capture the opponents piece diagonally' do
        rook = Rook.create(x_position: 6, y_position: 3, color: 'black')
        game.pieces << rook
        expect(pawn.capture_diagonally?(6, 3, -1)).to eq true
      end
    end

    context 'determining first move' do
      before do
        game = create(:game)
        game.send(:game_with_players_and_pieces)
        pawn = Pawn.create(x_position: 5, y_position: 2, color: 'white')
        game.pieces << pawn
      end

      it 'finds first move as true' do
        expect(pawn.first_turn?).to eq true
      end

      it 'can move two squares' do
        expect(pawn.forward_two_squares?(5, 4, 1)).to eq true
      end

      it 'can move one square' do
        expect(pawn.forward_one_square?(5, 3, 1)).to eq true
      end
    end
  end
end
