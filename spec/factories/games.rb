FactoryGirl.define do
  factory :game do
    name 'test game'
    created_at '2017-04-14 13:45:33.383893795 +0000'
  end

  factory :game_with_white_player, class: Game do
    name 'test game'
    white_player_id 0
  end

  factory :game_with_black_player, class: Game do
    name 'test game'
    black_player_id 1
  end

  factory :game_with_white_and_black_players, class: Game do
    name 'test game'
    white_player_id 0
    black_player_id 1
  end
  
  factory :game_player_associations, class: Game do
    name 'test game'
    association :white_player, factory: :user
    association :black_player, factory: :user
  end
end
