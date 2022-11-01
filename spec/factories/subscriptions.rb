FactoryBot.define do
  factory :subscription do
    name { Faker::Subscription.plan }
    status { Faker::Number.between(from: 0, to: 1) }
    frequency { Faker::Number.between(from: 0, to: 3) }
    customer { nil }
  end
end
