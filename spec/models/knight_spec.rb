require 'rails_helper'

RSpec.describe Knight, type: :model do
  mygame = FactoryGirl.create(:game)
  rintrah = FactoryGirl.create(:user)
  knight = FactoryGirl.create(:knight, game: mygame, user: rintrah)

  describe "valid_move? method" do
    it "returns true for a forward jump" do
      newmove = knight.valid_move?(2, 2)
      expect(newmove).to eq true
    end
    it "returns true for a sideways move" do
      newmove = knight.valid_move?(3, 1)
      expect(newmove).to eq true
    end
    it "returns false for a illegal jump" do
      newmove = knight.valid_move?(3, 3)
      expect(newmove).to eq false
    end
    it "returns true for a border move" do
      newmove = knight.valid_move?(0, 2)
      expect(newmove).to eq true
    end
  end
end
