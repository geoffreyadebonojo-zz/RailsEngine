FactoryBot.define do
  factory :item do
    merchant
    name { "Any Ol' Item" }
    description { "It's just your run-of-the-mill item" }
    unit_price { 1355 }
  end
end
