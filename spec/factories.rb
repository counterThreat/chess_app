FactoryGirl.define do
  factory :game do
    association :white_user, factory: :user
  end

  factory :game_white_player, class: Game do
    name 'factory girl test'
    white_player_id 1
  end

  factory :piece do
    association :game
    x_position 0
    y_position 0
    color false
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