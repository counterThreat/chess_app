FactoryGirl.define do
  factory :game do
    name 'test game'
    association :white_player, factory: :user
    association :black_player, factory: :user
  end

  factory :game_with_white_only, class: 'User' do
    name 'test game'
    white_player_id 0
  end

  factory :game_with_black_only, class: 'User' do
    name 'test game'
    black_player_id 1
  end

  factory :game_with_white_and_black, class: 'User' do
    name 'test game'
    white_player_id 0
    black_player_id 1
  end
end
