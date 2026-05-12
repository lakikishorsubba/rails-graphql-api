FactoryBot.define do
  factory :posts do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    status { :draft }
  end
end
