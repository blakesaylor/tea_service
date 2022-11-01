FactoryBot.define do
  factory :subscription do
    name { "MyString" }
    status { 1 }
    frequency { 1 }
    customer { nil }
  end
end
