require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'move!' do
    before do
      @game = create(:empty_game)
      @rook = Rook.new(x_position: 1, y_position: 1, color: 'white', last_move: nil)
      @game.pieces << @rook
    end

    it 'updates x' do
      @rook.send(:move!, 3, 1)
      expect(@rook.x_position).to eq 1
      expect(@rook.y_position).to eq 5
    end

    it 'updates y' do
      @rook.send(:move!, 4, 1)
      expect(@rook.x_position).to eq 4
      expect(@rook.y_position).to eq 1
    end

    it 'updates last_move' do
      @rook.send(:move!, 4, 1)
      expect(@rook.last_move).to eq(@game.move_number)
    end

    after(:all) do
      @game.destroy
      @rook.destroy
    end
  end

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
  # describe "empty_previous method"

  describe "obstructed method" do
    game2 = FactoryGirl.create(:game)
    bobby = FactoryGirl.create(:user)
    deepblue = FactoryGirl.create(:user)
    piece2 = FactoryGirl.create(:piece, game: game2, user: bobby, color: "black")

    it "returns false if path is unblocked" do
      x_new = 6
      y_new = 6
      expect(piece2.obstructed?(x_new, y_new)).to eq false
    end

    it "returns true if path is blocked" do
      x_new = 1
      y_new = 1
      FactoryGirl.create(:piece, game: game2, user: deepblue, x_position: 2, y_position: 1)
      expect(piece2.obstructed?(x_new, y_new)).to eq true
    end

    it "returns false if there is a piece on the destination square" do
      x_new = 2
      y_new = 2
      expect(piece2.obstructed?(x_new, y_new)).to eq false
    end
  end
end
