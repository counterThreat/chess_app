require 'rails_helper'

RSpec.describe Piece, type: :model do
  # Validations
  it "has a valid factory" do
    game1 = FactoryGirl.create(:game)
    elvis = FactoryGirl.create(:user)
    queen = FactoryGirl.create(:piece, game: game1, user: elvis)
    expect(queen).to be_valid
  end

  it "is not valid without an id" do
    piece = FactoryGirl.build(:piece, id: nil)
    expect(piece).not_to be_valid
  end

  it "is not valid without a type" do
    piece = FactoryGirl.build(:piece, type: nil)
    expect(piece).not_to be_valid
  end

  it "is not valid without a color" do
    piece = FactoryGirl.build(:piece, color: nil)
    expect(piece).not_to be_valid
  end

  it "has an x_position" do
    piece = FactoryGirl.build(:piece, x_position: nil)
    expect(piece).not_to be_valid
  end

  it "has a y_position" do
    piece = FactoryGirl.build(:piece, y_position: nil)
    expect(piece).not_to be_valid
  end

  # Associations
  describe "ActiveRecord Associations" do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user) }
  end

  # Subclasses
  # describe "subclass interactions" do
  # it "allows subclasses to be obstructed"
  # end

  # Instance Methods
  describe "move method" do
    it "allows a piece to change x position" do
      piece = FactoryGirl.build(:rook)
      piece.move(4, 3)
      expect(piece.x_position).to eq 4
    end

    it "allows a piece to change y position" do
      piece = FactoryGirl.build(:rook)
      piece.move(3, 4)
      expect(piece.y_position).to eq 4
    end

    it "allows a piece to move diagonally" do
      piece = FactoryGirl.build(:bishop)
      piece.move(1, 1)
      expect(piece.x_position).to eq 1
      expect(piece.y_position).to eq 1
    end
  end

  # describe "empty_previous method"

  describe "obstructed method" do
    it "returns false if path is unblocked"
    it "returns true is path is blocked"
    it "returns false if there is a piece on the destination square"
  end
end
