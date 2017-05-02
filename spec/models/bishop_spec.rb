require 'rails_helper'

RSpec.describe Bishop, type: :model do
  mygame = FactoryGirl.create(:game)
  hansolo = FactoryGirl.create(:user)
  bishop = FactoryGirl.create(:bishop, game: mygame, user: hansolo)

  describe "valid_move? method" do
    it "returns false for a horizontal move" do
      newmove = bishop.valid_move?(6, 3)
      expect(newmove).to eq false
    end
    it "returns false for a vertical move" do
      newmove = bishop.valid_move?(3, 6)
      expect(newmove).to eq false
    end
    it "returns true for a diagonal move" do
      newmove = bishop.valid_move?(6, 6)
      expect(newmove).to eq true
    end
  end
end
