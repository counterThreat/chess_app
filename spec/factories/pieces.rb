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
    type "rook"
    color "white"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :bishop do
    type "bishop"
    color "white"
    x_position 2
    y_position 2
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :pawn do
    type "pawn"
    color "white"
    x_position 2
    y_position 2
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |_b| a }
    moved false
    captured false
  end
end
