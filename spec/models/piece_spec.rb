require 'rails_helper'

RSpec.describe Piece, type: :model do
  # subject {
  #  described_class.new(type: nil, color: "black", x_position: 0, y_position: 0,
#    game_id: nil, user_id: nil, moved: nil, captured: nil)
#  }

  # Validations
  it "has a valid factory" do
    game1 = FactoryGirl.create(:game)
    elvis = FactoryGirl.create(:user)
    queen = FactoryGirl.create(:piece, game: game1, user: elvis)
    expect(queen).to be_valid
  end

  it "is not valid without a type" do
    piece = FactoryGirl.build(:piece, type: nil)
    expect(piece).to_not be_valid
  end

  it "is not valid without a color" do
    piece = FactoryGirl.build(:piece, color: nil)
    expect(piece).to_not be_valid
  end

  it "has an x_position" do
    piece = FactoryGirl.build(:piece, x_position: nil)
    expect(piece).to_not be_valid
  end

  it "has a y_position" do
    piece = FactoryGirl.build(:piece, y_position: nil)
    expect(piece).to_not be_valid
  end

  # Associations
  describe "ActiveRecord Associations" do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user) }
  end

  # Instance Methods
end
