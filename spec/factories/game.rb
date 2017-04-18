FactoryGirl.define do
  factory :game do
    name 'test game'
    association :white_player, factory: :user
    association :black_player, factory: :user
  end
end
