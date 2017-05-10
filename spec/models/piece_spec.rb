require 'rails_helper'
RSpec.describe Piece, type: :model do
  # VALIDATIONS
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

  # ASSOCIATIONS
  describe "ActiveRecord Associations" do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user) }
  end

  # Subclasses
  # describe "subclass interactions" do
  # it "allows subclasses to be obstructed"
  # end

  # Instance Methods

  describe 'on_board? method' do
    it 'returns false if a piece moves out of bound' do
      piece = FactoryGirl.build(:piece, x_position: 10, y_position: 7)
      expect(piece.on_board?).to eq false
    end
  end

  describe 'attack!' do
    it 'returns false if opponent color is equal to attacker color' do
      user1 = create(:user)
      user2 = create(:user)
      game = create(:game_with_white_and_black_players)
      piece1 = create(:piece, game: game, user_id: user1.id)
      piece2 = create(:rook, game: game, user_id: user2.id)
      expect(piece1.attack!(piece2.x_position, piece2.y_position)).to eq(false)
    end

    it 'returns true if the square is not occupied' do
      user1 = create(:user)
      game = create(:game_with_white_and_black_players)
      piece1 = create(:piece, game: game, user_id: user1.id)
      expect(piece1.attack!(0, 0)).to eq(true)
    end

    it 'sets piece to captured if attack successful' do
      user1 = create(:user)
      user2 = create(:user)
      game = create(:game_with_white_and_black_players)
      piece1 = create(:piece, game: game, user_id: user1.id)
      piece2 = create(:black_rook, game: game, user_id: user2.id)
      piece1.attack!(piece2.x_position, piece2.y_position)
      piece2.reload
      expect(piece2.captured).to eq(true)
    end
  end

  describe 'occupied?' do
    it 'returns true if a square is occupied' do
      user = create(:user)
      game = create(:game)
      piece = create(:piece, game: game, user: user)
      expect(piece.occupied?(piece.x_position, piece.y_position)).to eq(true)
    end

    it 'returns false if a square is empty' do
      user = create(:user)
      game = create(:game)
      piece = create(:piece, game: game, user: user)
      expect(piece.occupied?(1, 1)).to eq(false)
    end
  end

  # MOVE METHOD
  describe "move method" do
    it "records if move has taken place" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      game = FactoryGirl.create(:game, black_player_id: user2.id, white_player_id: user.id)
      rook = FactoryGirl.create(:rook, game: game, user_id: user.id)
      rook.move(4, 5)
      expect(rook.moved).to eq(true)
    end
    it "allows a piece to change x position" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 7, y_position: 6)
      piece = FactoryGirl.create(:rook, game: game1, user: elvis)
      piece.move(6, 4)
      expect(piece.x_position).to eq 6
    end

    it "allows a piece to change y position" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 7, y_position: 6)
      piece = FactoryGirl.create(:rook, game: game1, user: elvis)
      piece.move(4, 5)
      expect(piece.y_position).to eq 5
    end

    it "allows a piece to move diagonally" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 7, y_position: 6)
      piece = FactoryGirl.create(:rook, game: game1, user: elvis)
      piece = FactoryGirl.create(:bishop, game: game1, user: elvis)
      piece.move(2, 2)
      expect(piece.x_position).to eq 2
      expect(piece.y_position).to eq 2
    end
  end

  # MOVE METHOD WHEN IN CHECK
  describe "move method in relation to check" do
    it "does not allow a king to move itself into check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 7, y_position: 6)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 6, y_position: 2)
      white_king.move(5, 2)
      white_king.reload
      expect(white_king.y_position).to eq 1
    end

    it "does not allow a piece to make a move that exposes that piece's king to check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 7, y_position: 2)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 6, y_position: 1)
      black_rook.move(7, 1)
      white_rook.move(6, 2)
      white_rook.reload
      expect(white_rook.x_position).to eq 6
      expect(white_rook.y_position).to eq 1
    end

    it "allows a capture that resolves check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 5, y_position: 7)
      white_rook.move(5, 4)
      white_rook.reload
      expect(white_rook.x_position).to eq 5
      expect(white_rook.y_position).to eq 4
      expect(game1.check).to eq nil
    end

    it "allows a move that resolves check by blocking the king" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 4, y_position: 2)
      white_rook.move(5, 2)
      white_rook.reload
      expect(white_rook.x_position).to eq 5
      expect(white_rook.y_position).to eq 2
      expect(game1.check).to eq nil
    end

    it "allows a king to move out of check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 4, y_position: 2)
      white_king.move(4, 1)
      white_king.reload
      expect(white_king.x_position).to eq 4
      expect(white_king.y_position).to eq 1
      expect(game1.check).to eq nil
    end

    it "does not allow a move that doesn't resolve check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 6, y_position: 1)
      white_rook.move(6, 3)
      white_rook.reload
      expect(white_rook.x_position).to eq 6
      expect(white_rook.y_position).to eq 1
    end

    it "does not allow a king move that doesn't resolve check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 6, y_position: 1)
      white_king.move(5, 2)
      white_king.reload
      expect(white_king.x_position).to eq 5
      expect(white_king.y_position).to eq 1
      expect(game1.check).to eq 'white'
    end

    # In this test, the king is in check by two pieces. Capturing one doesn't
    # resolve check and therefore isn't allowed.
    it "does not allow a capture move that doesn't resolve check" do
      game1 = FactoryGirl.create(:game)
      elvis = FactoryGirl.create(:user)
      michael = FactoryGirl.create(:user)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user: elvis)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user: michael, x_position: 8, y_position: 7)
      black_rook = FactoryGirl.create(:rook, color: 'black', game: game1, user: michael, x_position: 5, y_position: 4)
      black_bishop = FactoryGirl.create(:bishop, color: 'black', game: game1, user: michael, x_position: 3, y_position: 3)
      white_rook = FactoryGirl.create(:rook, color: 'white', game: game1, user: elvis, x_position: 5, y_position: 8)
      white_rook.move(5, 4)
      white_rook.reload
      expect(white_rook.x_position).to eq 5
      expect(white_rook.y_position).to eq 8
    end
  end

  # OBSTRUCTED METHOD
  describe "obstructed method" do
    game2 = FactoryGirl.create(:game)
    bobby = FactoryGirl.create(:user)
    deepblue = FactoryGirl.create(:user)
    piece2 = FactoryGirl.create(:piece, game: game2, user: bobby, color: "black")

    it "returns false if path is unblocked" do
      x_new = 7
      y_new = 7
      expect(piece2.obstructed?(x_new, y_new)).to eq false
    end

    it "returns true if path is blocked" do
      x_new = 2
      y_new = 2
      blocker = FactoryGirl.create(:piece, game: game2, user: deepblue, x_position: 3, y_position: 3)
      expect(piece2.obstructed?(x_new, y_new)).to eq true
    end

    it "returns false if there is a piece on the destination square" do
      x_new = 3
      y_new = 3
      expect(piece2.obstructed?(x_new, y_new)).to eq false
    end
  end
end
