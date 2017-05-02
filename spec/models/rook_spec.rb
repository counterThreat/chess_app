require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "valid_move? method" do
    mygame = FactoryGirl.create(:game)
    beyonce = FactoryGirl.create(:user)
    rook = FactoryGirl.create(:rook, game: mygame, user: beyonce)

    it "returns true when moving vertically" do
      newmove = rook.valid_move?(4, 6)
      expect(newmove).to eq true
    end
    it "returns true when moving horizontally" do
      newmove = rook.valid_move?(6, 4)
      expect(newmove).to eq true
    end
    it "returns false when moving diagonally" do
      newmove = rook.valid_move?(6, 6)
      expect(newmove).to eq false
    end
  end
end
