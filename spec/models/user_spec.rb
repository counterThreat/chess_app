require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user_attr = FactoryGirl.attributes_for(:user)
    @user = FactoryGirl.build(:user)
  end

  it 'should create a new user from valid attributes' do
    User.create!(@user_attr)
  end
end
