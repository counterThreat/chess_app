FactoryGirl.define do
  factory :piece do
    type "Rook"
    color "white"
    x_position 4
    y_position 4
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook do
    type "Rook"
    color "white"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :bishop do
    type "Bishop"
    color "black"
    x_position 2
    y_position 2
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :pawn do
    type "Pawn"
    color "white"
    x_position 1
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :king do
    type "King"
    color "white"
    x_position 4
    y_position 0
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook_white_77, class: Rook do
    type "Rook"
    color "white"
    x_position 7
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook_white_07, class: Rook do
    type "Rook"
    color "white"
    x_position 0
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :king_white_47, class: King do
    type "King"
    color "white"
    x_position 4
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :king_black_40, class: King do
    type "King"
    color "black"
    x_position 4
    y_position 0
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :queen do
    type "Queen"
    color "white"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end
end
