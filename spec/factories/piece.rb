FactoryGirl.define do
  factory :piece do
    type "Q"
    color "white"
    x_position 0
    y_position 0
    sequence(:game_id) { |a| a }
    sequence(:user_id){ |b| b }
    moved false
    captured false
  end
end
