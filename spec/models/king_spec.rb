require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'can_castle?' do
    it 'returns true if kingside castling is possible' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_77, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(true)
    end

    it 'returns true if queenside castling is possible' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_07, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(true)
    end

    it 'returns false if rook has moved' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_07, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user.id)
      rook.move(0, 6)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(false)
    end

    it 'returns false if king has moved' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      rook = create(:rook_white_07, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user.id)
      king.move(4, 6)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(false)
    end

    it 'returns false if king is in check' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_07, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'black', game_id: game.id, x_position: 5, y_position: 0, user_id: user2.id)
      bishop.move(1, 4)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(false)
    end

    it 'returns false if king attempts castle with non rook' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      bishop = create(:bishop, color: 'white', x_position: 0, y_position: 7, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(bishop.x_position, bishop.y_position)).to eq(false)
    end

    it 'returns false if king attempts castle with rook of an opposite color' do
      user = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      rook = create(:rook, color: 'black', x_position: 0, y_position: 7, game_id: game.id, user_id: user.id)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(false)
    end

    it 'returns false if there is an obsruction between the rook and king' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king = create(:king_white_47, game_id: game.id, user_id: user.id)
      create(:king_black_40, game_id: game.id, user_id: user2.id)
      rook = create(:rook_white_07, game_id: game.id, user_id: user.id)
      create(:bishop, color: 'black', game_id: game.id, x_position: 1, y_position: 7, user_id: user2.id)
      expect(king.can_castle?(rook.x_position, rook.y_position)).to eq(false)
    end
  end

  describe "valid_move? method" do
    mygame = FactoryGirl.create(:game)
    anna = FactoryGirl.create(:user)
    king = FactoryGirl.create(:king, game: mygame, user: anna)

    it 'returns true if moving one square east' do
      newmove = king.valid_move?(5, 0)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square west' do
      newmove = king.valid_move?(3, 0)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square north' do
      newmove = king.valid_move?(4, 1)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square northeast' do
      newmove = king.valid_move?(5, 1)
      expect(newmove).to eq true
    end

    it 'returns true if moving one square northwest' do
      newmove = king.valid_move?(3, 1)
      expect(newmove).to eq true
    end

    it 'returns false if moving more than one square north' do
      newmove = king.valid_move?(4, 5)
      expect(newmove).to eq false
    end

    it 'returns false if moving more than one square east' do
      newmove = king.valid_move?(7, 0)
      expect(newmove).to eq false
    end

    it 'returns false if moving to a random square on the board' do
      newmove = king.valid_move?(2, 7)
      expect(newmove).to eq false
    end

    it 'returns false if trying to move off the board' do
      newmove = king.valid_move?(-1, 8)
      expect(newmove).to eq false
    end
  end
end
