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

  describe "on_board? method" do
    it "returns false if a piece moves out of bounds" do
      piece = FactoryGirl.build(:piece, x_position: 10, y_position: 7)
      expect(piece.on_board?).to eq false
    end
  end

  describe "move method" do
    it "allows a piece to change x position" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      piece = FactoryGirl.create(:rook, game: game1, user: elvis)
      piece.move!(4, 3)
      expect(piece.x_position).to eq 4
    end

    it "allows a piece to change y position" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      piece = FactoryGirl.create(:rook, game: game1, user: elvis)
      piece.move!(3, 4)
      expect(piece.y_position).to eq 4
    end

    it "allows a piece to move diagonally" do
      @game = Game.create
      @white_bishop = Bishop.create(x_position: 3, y_position: 1, color: 'white')
      @white_bishop.diagonal_move?(4,2)
      expect(response).to eq true
    end
  end

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
      blocker = FactoryGirl.create(:piece, game: game2, user: deepblue, x_position: 2, y_position: 1)
      expect(piece2.obstructed?(x_new, y_new)).to eq true
    end

    it "returns false if there is a piece on the destination square" do
      x_new = 2
      y_new = 2
      expect(piece2.obstructed?(x_new, y_new)).to eq false
    end
  end

  describe 'valid moves' do
    context 'white pawn and white rook' do
      before do
        @game = Game.create
        @game.pieces.each(&:destroy)
        @white_pawn = Pawn.create(x_position: 8, y_position: 2, color: 'white')
        @white_rook = Rook.create(x_position: 1, y_position: 1, color: 'white')
        @game.pieces << @white_pawn
        @game.pieces << @white_rook
      end

      context 'a pawn cant go off the board' do
        it 'returns false if the pawn goes out of bounds' do
          @white_pawn.move!(8, 4)
          expect(@white_pawn.move!(8, 4)).to be(false)
        end
      end
    end
  end
end
