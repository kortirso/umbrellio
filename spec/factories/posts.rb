FactoryBot.define do
  factory :post do
    title { 'Something' }
    content { 'useless' }
    author_ip { '192.168.0.1' }
    association :user
  end
end
