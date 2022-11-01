FactoryBot.define do
  factory :tea do
    name { "MyString" }
    description { "MyString" }
    temperature_c { 1 }
    brew_time_sec { 1 }
    price { 1.5 }
  end
end
