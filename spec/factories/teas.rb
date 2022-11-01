FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Food.description }
    temperature_c { Faker::Number.between(from: 120, to: 210) }
    brew_time_sec { Faker::Number.between(from: 60, to: 240) }
    price { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
  end
end
