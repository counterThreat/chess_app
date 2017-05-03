require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:game) { FactoryGirl.create :game }
    let(:user) { FactoryGirl.create :user }
    let(:piece) { FactoryGirl.create(:piece, game: game, user: user) }

    it "check if move is valid" do
      patch :update, params: { id: piece.id, user_id: user.id, game_id: game.id, x_position: 4, y_position: 7 }
      piece.reload
      expect(piece.x_position).to eq 4
      expect(piece.y_position).to eq 7
    end
  end
  
  describe "pieces#permitted" do
    let(:game) { FactoryGirl.create :game }
    let(:user) { FactoryGirl.create :user }
    let(:piece) { FactoryGirl.create(:piece, game: game, user: user)}
    
    it "checks if the potential move is permitted" do
      pawn = FactoryGirl.create(:pawn, game: game, user: user)
      sign_in user
      get :permitted, id: pawn
      expect(JSON.parse(response.body)).to include('x' => 1, 'y' => 3)
    end
  end
end
