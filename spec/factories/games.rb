FactoryGirl.define do
  factory :game do
    name 'test game'
  end

  factory :game_with_white_player, class: Game do
    name 'test game'
    white_player_id 0
  end
end
