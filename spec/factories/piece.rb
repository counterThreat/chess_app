FactoryGirl.define do
  factory :piece do
    type "Rook"
    color "white"
    x_position 5
    y_position 5
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook do
    type "Rook"
    color "white"
    x_position 4
    y_position 4
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :black_rook, class: Rook do
    type "Rook"
    color "black"
    x_position 5
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :bishop do
    type "Bishop"
    color "black"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :bishop_white, class: Bishop do
    type "Bishop"
    color "white"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :pawn do
    type "Pawn"
    color "white"
    x_position 2
    y_position 2
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :opponent_pawn, class: Pawn do
    type "Pawn"
    color "black"
    x_position 3
    y_position 3
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :black_pawn, class: Pawn do
    type "Pawn"
    color "black"
    x_position 2
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :pawn_white_55, class: Pawn do
    type "Pawn"
    color "white"
    x_position 5
    y_position 5
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved true
    captured false
  end

  factory :pawn_black_47, class: Pawn do
    type "Pawn"
    color "black"
    x_position 4
    y_position 7
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
   end

  factory :king do
    type "King"
    color "white"
    x_position 5
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook_white_11, class: Rook do
    type "Rook"
    color "white"
    x_position 1
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook_white_81, class: Rook do
    type "Rook"
    color "white"
    x_position 8
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :rook_black_18, class: Rook do
    type "Rook"
    color "black"
    x_position 1
    y_position 8
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :king_white_51, class: King do
    type "King"
    color "white"
    x_position 5
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :king_black_58, class: King do
    type "King"
    color "black"
    x_position 5
    y_position 8
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :queen do
    type "Queen"
    color "white"
    x_position 4
    y_position 4
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end

  factory :knight do
    type "Knight"
    color "white"
    x_position 2
    y_position 1
    sequence(:game_id) { |a| a }
    sequence(:user_id) { |b| b }
    moved false
    captured false
  end
end
