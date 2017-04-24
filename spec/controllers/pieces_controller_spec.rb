require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:game) { FactoryGirl.create :game }
    let(:user) { FactoryGirl.create :user }
    let(:piece) { FactoryGirl.create(:piece, game: game, user: user) }

    it "check if move is valid" do
      put :update, params: { id: piece.id, user_id: user.id, game_id: game.id, x_position: 4, y_position: 7 }
      piece.reload
      expect(piece.x_position).to be 4
      expect(piece.y_position).to be 7
    end
  end
end
