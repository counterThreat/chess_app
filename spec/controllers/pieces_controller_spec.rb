require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:empty_game) }
  let(:piece) { FactoryGirl.create(:piece) }

  context 'update pieces' do
    describe "pieces#update" do
      before do
        piece = Pawn.new(x_position: 1, y_position: 2, color: 'white')
        user.games_as_white << game
        user.pieces << piece
        game.pieces << piece
        patch :update, id: piece.id, x_new: 3, y_new: 2
      end

      it 'moves the correct piece' do
        expect(flash[:alert]).to eq(nil)
      end
    end
  end
end
