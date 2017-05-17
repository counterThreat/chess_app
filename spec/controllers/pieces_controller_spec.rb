require 'rails_helper'
RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:white_player) { create(:user) }
    let(:black_player) { create(:user) }
    let(:game) { create(:game, white_player: white_player, black_player: black_player) }

    it "updates database" do
      rook = create(:rook, game: game, user_id: game.white_player_id)
      sign_in white_player
      put :update, params: { id: rook.id, piece: { user_id: white_player.id, game_id: game.id, x_position: 4, y_position: 6 } }
      rook.reload
      expect(rook.y_position).to eq 6
    end

    it "will not allow turns if not current user" do
      pawn = create(:pawn, game: game, user_id: game.white_player.id)
      sign_in black_player
      put :update, params: { id: pawn.id, piece: { user_id: black_player.id, game_id: game.id, x_position: 1, y_position: 3 } }
      pawn.reload
      # expect(pawn.y_position).to eq 2
      expect(response).to have_http_status(:forbidden)
    end
  end
end