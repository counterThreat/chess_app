require 'rails_helper'
RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    let(:white_player) { create(:user) }
    let(:game) { create(:game, white_player: white_player) }

    it "updates database" do
      rook = create(:rook, game: game, user_id: game.white_player_id)
      rook.move(3, 5)
      put :update, params: { id: rook.id, piece: { user_id: white_player.id, game_id: game.id, x_position: 3, y_position: 5 } }
      # rook.reload
      expect(rook.x_position).to eq 3
      expect(rook.y_position).to eq 5
    end
  end
end
