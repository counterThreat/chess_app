require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associate_pieces!' do
    it 'assigns black to the  black_player pieces' do
      user1 = create(:user)
      user2 = create(:user)
      game = create(:game_with_white_and_black_players, white_player_id: user1.id, black_player_id: user2.id)
      piece = create(:bishop, color: 'black', game: game, user_id: game.white_player_id)
      game.associate_pieces!
      piece.reload
      expect(piece.user_id).to eq(game.black_player_id)
    end
  end
  # it 'associates the pieces with the color of the respective player as white or black' do
  #   # need piece model and controller to be more fleshed out to write this test
  # end
  describe 'with_one_player' do
    it 'returns games with one player' do
    end
  end

  describe 'check method' do
    it 'returns the color of the king in check when in check by opponent' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      bishop = FactoryGirl.create(:bishop, color: 'black', game: check_game, x_position: 2, y_position: 2, user_id: user4.id)
      bishop.move(3, 3)
      expect(check_game.check).to eq 'white'
    end

    it 'returns nil when king is in check by piece of same color' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook = FactoryGirl.create(:rook, color: 'white', game: check_game,
      user_id: user3.id, x_position: 1, y_position: 2)
      rook.move(1, 1)
      expect(check_game.check).to eq nil
    end
    it 'returns nil when neither king is in check' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook = FactoryGirl.create(:rook, color: 'white', game: check_game,
      user_id: user3.id, x_position: 1, y_position: 2)
      bishop = FactoryGirl.create(:bishop, color: 'black', game: check_game, x_position: 2, y_position: 2, user_id: user4.id)
      expect(check_game.check).to eq nil
    end
  end

  describe 'checkmate method' do
    it 'returns checkmate when a king is in check and cannot escape check' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 2, y_position: 3, user_id: user4.id)
      expect(check_game.checkmate('white)')).to eq true
    end

    it 'returns checkmate when a king is in check and cannot escape check TWO' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 5, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 5, y_position: 8)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 8, y_position: 1, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 7, y_position: 2, user_id: user4.id)
      rook = FactoryGirl.create(:rook, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      expect(check_game.checkmate('white')).to eq true
    end

    it 'does not return checkmate when the attacker can be blocked' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 7, y_position: 8)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 2, y_position: 3, user_id: user4.id)
      white_bishop = FactoryGirl.create(:bishop, color: 'white', game: check_game, x_position: 2, y_position: 1, user_id: user3.id)
      expect(check_game.checkmate('white')).to eq false
    end

    it 'does not return checkmate when the attacker can be captured' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 4, y_position: 8)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 2, y_position: 3, user_id: user4.id)
      white_bishop = FactoryGirl.create(:bishop, color: 'white', game: check_game, x_position: 2, y_position: 4, user_id: user3.id)
      expect(check_game.checkmate('white')).to eq false
    end

    it 'does not return checkmate when a king is in check but can move out of check' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      expect(check_game.checkmate('white')).to eq false
    end
  end

  describe 'stalemate method' do
    it 'returns true when a king is not in check but player has no legal move' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 6, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: check_game, user_id: user4.id, x_position: 7, y_position: 6)
      expect(check_game.check).to eq nil
      expect(check_game.stalemate('black')).to eq true
    end

    it 'returns false when the player is not in check and can make a legal move' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 4, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: check_game, user_id: user4.id, x_position: 7, y_position: 5)
      expect(check_game.check).to eq nil
      expect(check_game.stalemate('black')).to eq false
    end

    it 'returns false in the case of checkmate (no false positive)' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 6, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: check_game, user_id: user4.id, x_position: 7, y_position: 6)
      white_bishop = FactoryGirl.create(:bishop, color: 'white', game: check_game, user_id: user3.id, x_position: 5, y_position: 5)
      expect(check_game.stalemate('black')).to eq false
      expect(check_game.checkmate('black')).to eq true
    end
  end
end
