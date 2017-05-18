require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe 'get_username' do
    it 'returns specific user username' do
      user = create(:user)
      expect(get_username(user.id)).to eq(user.username)
    end
  end
  
  describe '#gravatar_for' do
    it 'generates an image tag' do
      user = create(:user)
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=50"
      expect(helper.gravatar_for(user)).to eq image_tag(gravatar_url, alt: user.username)
    end
  end
end
