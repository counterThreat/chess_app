require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#games' do
    it 'documents games as a white player' do
      game = create(:game_player_associations)
      expect(game.white_player.games).to include game
    end

    it 'documents games as a black player' do
      game = create(:game_player_associations)
      expect(game.black_player.games).to include game
    end
  end
  describe '#user_data' do
    it 'returns correct user data' do
      user = create(:user)
      username = user.username
      gravatar_url = "https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}?s=75"
      registration_date = user.created_at.strftime('%m-%d-%Y')
      win_count = user.win_count
      data = { name: username, gravatar_url: gravatar_url, member_since: registration_date, total_wins: win_count }
      expect(user.user_data).to eq data
    end
  end
end
