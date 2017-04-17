FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'very_secure'
    password_confirmation 'very_secure'
    username { Faker::Internet.user_name }
    created_at Regexp.last_match(2)
    updated_at Regexp.last_match(3)
  end
end
