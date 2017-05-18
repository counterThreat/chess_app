require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "users controller actions" do
    it "users#show" do
      user = create(:user)
      get :show
      expect(response).to be_success
    end
  end
end
