require 'rails_helper'
RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:white_player) { create(:user) }
    let(:game) { create(:game, white_player: white_player) }

    it "updates database" do
      rook = create(:rook, game: game, user_id: game.white_player_id)
      put :update, params: { id: rook.id, piece: { user_id: white_player.id, game_id: game.id, x_position: 4, y_position: 6 } }
      rook.reload
      expect(rook.x_position).to eq 4
      expect(rook.y_position).to eq 6
    end
  end
end
