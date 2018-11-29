FactoryBot.define do
  factory :invoice_item do
    item { create(:item)  }
    invoice { create(:invoice) }
    quantity { 1 }
    unit_price { 100 }
  end
end
