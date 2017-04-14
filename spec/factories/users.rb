FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'very_secure'
    password_confirmation 'very_secure'
    username { Faker::Internet.user_name }
    created_at Regexp.last_match(2)
    updated_at Regexp.last_match(3)
  end

  factory :test_person, class: User do
  id 0
  username 'whiteTest'
  email 'white@test.com'
  password 'secret123'
  password_confirmation 'secret123'
end

factory :another_test_person, class: User do
  id 1
  username 'blackTest'
  email 'black@test.com'
  password 'humanplayer'
  password_confirmation 'humanplayer'
end
end
