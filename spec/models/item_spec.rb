require 'rails_helper'

describe Item, type: :model do

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  it ".best_day" do
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: "2018-08-01 09:00:00 UTC")
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: "2018-08-02 09:00:00 UTC")
    invoice_3 = create(:invoice, merchant: merchant_3, created_at: "2018-08-03 09:00:00 UTC")
    invoice_4 = create(:invoice, merchant: merchant_4, created_at: "2018-08-04 09:00:00 UTC")
    item_1 = create(:item, merchant: merchant_1)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 200, invoice: invoice_2, item: item_1)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice_3, item: item_1)
    invoice_item_4 = create(:invoice_item, quantity: 10, unit_price: 400, invoice: invoice_4, item: item_1)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Item.best_day(item_1.id)).to eq(invoice_4.created_at.to_date)
  end

  it ".most_revenue" do 
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: "2018-08-01 09:00:00 UTC")
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: "2018-08-02 09:00:00 UTC")
    invoice_3 = create(:invoice, merchant: merchant_3, created_at: "2018-08-03 09:00:00 UTC")
    invoice_4 = create(:invoice, merchant: merchant_4, created_at: "2018-08-04 09:00:00 UTC")
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_4)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 100, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 100, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, quantity: 8, unit_price: 100, invoice: invoice_4, item: item_4)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Item.most_revenue(1).first).to eq(item_3)
    expect(Item.most_revenue(2)).to eq([item_3, item_4])
  end

  it ".most_items" do
    # merchant_1 = create(:merchant, name: 'Andy')
    # merchant_2 = create(:merchant, name: 'Bob')
    # merchant_3 = create(:merchant, name: 'Charles')
    # merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, created_at: "2018-08-01 09:00:00 UTC")
    invoice_2 = create(:invoice, created_at: "2018-08-02 09:00:00 UTC")
    invoice_3 = create(:invoice, created_at: "2018-08-03 09:00:00 UTC")
    invoice_4 = create(:invoice, created_at: "2018-08-04 09:00:00 UTC")
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    item_4 = create(:item)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 100, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 100, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, quantity: 8, unit_price: 100, invoice: invoice_4, item: item_4)
    # transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    # transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    # transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    # transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Item.most_items(3)).to eq([item_3, item_4, item_2])
  end

end
