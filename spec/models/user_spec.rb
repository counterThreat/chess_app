require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'something' do
    it 'something' do
    end
  end
  
  describe '#user_data' do
    it 'returns correct user data' do
      user = create(:user)
      username = user.username
      registration_date = user.created_at.strftime('%m-%d-%Y')
      win_count = user.win_count
      data = { name: username, member_since: registration_date, total_wins: win_count }
      expect(user.user_data).to eq data
    end
  end
end
