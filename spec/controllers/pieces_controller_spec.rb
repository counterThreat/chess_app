require 'rails_helper'
RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:white_player) { create(:user) }
    let(:game) { create(:game, white_player: white_player) }

    it "updates database" do
      rook = create(:rook, game: game, user_id: game.white_player_id)
      rook.move(4, 6)
      put :update, params: { id: rook.id, piece: { user_id: white_player.id, game_id: game.id, x_position: 3, y_position: 5 } }
      # rook.reload
      expect(rook.x_position).to eq 4
      expect(rook.y_position).to eq 6
    end
    # rubocop:disable Metrics/ExampleLength
    it "validates correct player's turn" do
      mygame = FactoryGirl.create(:game)
      anna = FactoryGirl.create(:user)
      pawn = FactoryGirl.create(:pawn, game: mygame, user: anna)
      sign_in anna
      # pawn = create(:pawn, game: game, user_id: game.white_player_id)
      # pawn.move(1, 3)
      put :update, params: { id: pawn.id, piece: { user_id: white_player.id, game_id: game.id, x_position: 1, y_position: 3 } }

      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eql "It is your turn"
    end
  end
end
