FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "user_#{i}" }
  end
end
