FactoryBot.define do
  factory :transaction do
    invoice { create(:invoice) }
    credit_card_number { "0000405418249632" }
    credit_card_expiration_date { "000" }
    result { "success" }
  end
end
