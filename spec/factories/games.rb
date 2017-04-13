FactoryGirl.define do
  factory :game do
    name 'test game'
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
end

