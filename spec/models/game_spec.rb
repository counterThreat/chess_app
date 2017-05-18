require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'next_turn' do
    it 'after white_player moves it is black_players turn' do
      user = create(:user)
      user2 = create(:user)
      game = create(:game)
      king_white = create(:king_white_51, game_id: game.id, user_id: user.id)
      create(:king_black_58, game_id: game.id, user_id: user2.id)
      king_white.move(5, 2)
      game.reload
      expect(game.player_turn).to eq('black')
    end

    it 'after black_player moves it is white_players turn' do
      user3 = create(:user)
      user4 = create(:user)
      game2 = create(:game)
      king_white2 = create(:king_white_51, game_id: game2.id, user_id: user3.id)
      king_black2 = create(:king_black_58, game_id: game2.id, user_id: user4.id)
      king_white2.move(5, 2)
      king_white2.reload
      king_black2.move(5, 7)
      king_black2.reload
      expect(game2.player_turn).to eq('white')
    end
  end

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
      white_king = FactoryGirl.create(:king_white_51, game: check_game, user_id: user3.id)
      black_king = FactoryGirl.create(:king_black_58, game: check_game, user_id: user4.id)
      rook = FactoryGirl.create(:rook_white_11, game: check_game, user_id: user3.id)
      bishop = FactoryGirl.create(:bishop, color: 'black', game: check_game, x_position: 2, y_position: 2, user_id: user4.id)
      rook.move(1, 2) # allows black turn
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
      check_game.player_turn = 'white'
      expect(check_game.checkmate).to eq true
    end

    it 'returns checkmate when a king is in check and cannot escape check TWO' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 5, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 5, y_position: 8)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 8, y_position: 1, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 7, y_position: 2, user_id: user4.id)
      check_game.player_turn = 'white'
      expect(check_game.checkmate).to eq true
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
      check_game.player_turn = 'white'
      expect(check_game.checkmate).to eq false
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
      check_game.player_turn = 'white'
      expect(check_game.checkmate).to eq false
    end

    it 'does not return checkmate when a king is in check but can move out of check' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      check_game.player_turn = 'white'
      expect(check_game.checkmate).to eq false
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
      check_game.player_turn = 'black'
      expect(check_game.check).to eq nil
      expect(check_game.stalemate).to eq true
    end

    it 'returns false when the player is not in check and can make a legal move' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 4, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: check_game, user_id: user4.id, x_position: 7, y_position: 5)
      check_game.player_turn = 'black'
      expect(check_game.check).to eq nil
      expect(check_game.stalemate).to eq false
    end

    it 'returns false in the case of checkmate (no false positive)' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 6, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: check_game, user_id: user4.id, x_position: 7, y_position: 6)
      white_bishop = FactoryGirl.create(:bishop, color: 'white', game: check_game, user_id: user3.id, x_position: 5, y_position: 5)
      check_game.player_turn = 'black'
      expect(check_game.stalemate).to eq false
      expect(check_game.checkmate).to eq true
    end
  end

  describe 'end_game_checkmate method' do
    it 'updates winning_player_id, outcome, and finished for a checkmate' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      check_game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: check_game, user_id: user3.id, x_position: 1, y_position: 1)
      black_king = FactoryGirl.create(:king, color: 'black', game: check_game, user_id: user4.id, x_position: 8, y_position: 7)
      rook_b1 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 1, y_position: 3, user_id: user4.id)
      rook_b2 = FactoryGirl.create(:rook, color: 'black', game: check_game, x_position: 2, y_position: 3, user_id: user4.id)
      check_game.player_turn = 'white'
      check_game.end_game_checkmate

      expect(check_game.reload.outcome).to eq 'checkmate'
      expect(check_game.finished.utc).to be_within(1.second).of Time.now
      expect(check_game.reload.winning_player_id).to eq user4.id
    end
  end

  describe 'end_game_stalemate method' do
    it 'updates outcome and finished for a stalemate' do
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      game1 = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, color: 'white', game: game1, user_id: user3.id, x_position: 6, y_position: 7)
      black_king = FactoryGirl.create(:king, color: 'black', game: game1, user_id: user4.id, x_position: 8, y_position: 8)
      white_queen = FactoryGirl.create(:queen, color: 'white', game: game1, user_id: user4.id, x_position: 7, y_position: 6)
      game1.player_turn = 'black'
      game1.end_game_stalemate

      expect(game1.winning_player_id).to eq nil
      expect(game1.outcome).to eq 'stalemate'
      expect(game1.finished.utc).to be_within(1.second).of Time.now
    end
  end

  describe 'end_game_forfeit method' do
    it 'updates winning_player_id, outcome, and finished for a forfeit' do
      white_player = create(:user)
      black_player = create(:user)
      game = create(:game_player_associations, white_player: white_player, black_player: black_player)
      game.player_turn = 'white'
      game.forfeiting_player!(white_player) # calls end_game_forfeit method directly
      expect(game.winning_player_id).to eq black_player.id
      expect(game.outcome).to eq 'forfeit'
      expect(game.finished.utc).to be_within(1.second).of Time.now
    end
  end
end
