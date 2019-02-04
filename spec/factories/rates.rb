FactoryBot.define do
  factory :rate do
    value { 5 }
    association :post
  end
end
