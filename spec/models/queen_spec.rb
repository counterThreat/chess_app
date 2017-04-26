require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe "valid_move? method" do
    mygame = FactoryGirl.create(:game)
    kasparov = FactoryGirl.create(:user)
    queen = FactoryGirl.create(:queen, game: mygame, user: kasparov)

    it "returns true when moving vertically" do
      newmove = queen.valid_move?(3, 5)
      expect(newmove).to eq true
    end
    it "returns true when moving horizontally" do
      newmove = queen.valid_move?(5, 3)
      expect(newmove).to eq true
    end
    it "returns true when moving diagonally" do
      newmove = queen.valid_move?(5, 5)
      expect(newmove).to eq true
    end
    it "returns false when moving like a knight" do
      newmove = queen.valid_move?(4, 5)
      expect(newmove).to eq false
    end
  end
end
