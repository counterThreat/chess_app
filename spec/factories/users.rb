FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password 'very_secure'
    password_confirmation 'very_secure'
    username { Faker::Internet.user_name }
    created_at Regexp.last_match(2)
    updated_at Regexp.last_match(3)
  end
end
