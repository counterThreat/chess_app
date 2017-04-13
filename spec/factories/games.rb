FactoryGirl.define do

  factory :game do
    name 'test game'
    association :game, :white_user, factory: :user
    x_position 0
    y_position 0
    color false
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

  factory :game_white_player, class: Game do
    name 'factory girl test'
    white_player_id 1
  end

  factory :king, parent: :piece do
    piece_type "knight"
    x_position 2
    y_position 1
  end

  factory :bishop, parent: :piece do
    piece_type "rook"
    x_position 1
    y_position 1
  end
end

