require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'can_castle?' do
    it 'returns true if kingside castling is possible' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(3, 1)).to eq(true)
    end

    it 'returns true if queenside castling is possible' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(7, 1)).to eq(true)
    end

    it 'returns false if rook has moved' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      rook.move(2, 1)
      expect(king.can_castle?(3, 1)).to eq(false)
    end

    it 'returns false if king has moved' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.move(4, 1)
      expect(king.can_castle?(7, 1)).to eq(false)
    end

    it 'returns false if king is in check' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'black', game_id: game.id, x_position: 6, y_position: 1, user_id: user2.id)
      bishop.move(2, 5)
      expect(king.can_castle?(7, 1)).to eq(false)
    end

    it 'returns false if the king will be in check after castling' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'black', game_id: game.id, x_position: 4, y_position: 8, user_id: user2.id)
      bishop.move(7, 5)
      expect(king.can_castle?(3, 1)).to eq(false)
    end

    it 'returns false if the king will be in check during castling' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'black', game_id: game.id, x_position: 5, y_position: 8, user_id: user2.id)
      bishop.move(8, 5)
      expect(king.can_castle?(3, 1)).to eq(false)
    end

    it 'returns false if king attempts castle with non rook' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'white', x_position: 8, y_position: 1, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(7, 1)).to eq(false)
    end

    it 'returns false if king attempts castle with rook of an opposite color' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook, color: 'black', x_position: 1, y_position: 1, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(3, 1)).to eq(false)
    end

    it 'returns false if there is an obsruction between the rook and king' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:bishop, color: 'black', game_id: game.id, x_position: 7, y_position: 1, user_id: user2.id)
      expect(king.can_castle?(7, 1)).to eq(false)
    end
  end

  describe "castle!" do
    it 'updates the kings position two spaces queenside' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.move(3, 1)
      expect(king.x_position).to eq(3)
    end

    it 'updates the kings position two spaces kingside' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.can_castle?(7, 1)
      expect(king.x_position).to eq(7)
    end

    it 'kingside rook has hopped over king' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.can_castle?(3, 1)
      rook.reload
      expect(rook.x_position).to eq(4)
    end

    it 'queenside rook has hopped over king' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.can_castle?(7, 1)
      rook.reload
      expect(rook.x_position).to eq(6)
    end

    it 'king has been marked as moved after castling' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_11, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.can_castle?(3, 1)
      king.reload
      expect(king.moved).to eq(true)
    end

    it 'rook has been marked as moved after castling' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user.id)
      king.can_castle?(7, 1)
      rook.reload
      expect(rook.moved).to eq(true)
    end

    it 'castling fails if can_castle is false' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_81, game_id: game.id, user_id: user.id)
      create(:bishop, color: 'black', game_id: game.id, x_position: 3, y_position: 5, user_id: user2.id)
      king.can_castle?(7, 1)
      expect(king.can_castle?(7, 1)).to eq(false)
      expect(king.x_position).to eq(5)
      expect(rook.x_position).to eq(8)
    end
  end

  describe "valid_move? method" do
    mygame = FactoryGirl.create(:game)
    anna = FactoryGirl.create(:user)
    king = FactoryGirl.create(:king, game: mygame, user: anna)

    it 'returns true if moving one square east' do
      newmove = king.valid_move?(6, 1)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square west' do
      newmove = king.valid_move?(4, 1)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square north' do
      newmove = king.valid_move?(5, 2)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square northeast' do
      newmove = king.valid_move?(6, 2)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square northwest' do
      newmove = king.valid_move?(4, 2)
      expect(newmove).to eq true
    end

    it 'returns false if moving more than one square north' do
      newmove = king.valid_move?(5, 6)
      expect(newmove).to eq false
    end

    it 'returns false if moving more than one square east' do
      newmove = king.valid_move?(8, 1)
      expect(newmove).to eq false
    end

    it 'returns false if moving to a random square on the board' do
      newmove = king.valid_move?(3, 8)
      expect(newmove).to eq false
    end

    it 'returns false if trying to move off the board' do
      newmove = king.valid_move?(-1, 1)
      expect(newmove).to eq false
    end
  end
end
