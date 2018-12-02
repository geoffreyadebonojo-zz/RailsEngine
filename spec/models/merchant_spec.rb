require 'rails_helper'

describe Merchant, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices)}
  end

  it ".most_revenue" do
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)
    invoice_4 = create(:invoice, merchant: merchant_4)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_4)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item1)
    invoice_item_2 = create(:invoice_item, quantity: 1, unit_price: 200, invoice: invoice_2, item: item2)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice_3, item: item3)
    invoice_item_4 = create(:invoice_item, quantity: 20, unit_price: 400, invoice: invoice_4, item: item4)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Merchant.most_revenue(2)).to eq([merchant_4, merchant_3])
    expect(Merchant.most_revenue(1)).to eq([merchant_4])
  end

  it ".most_items" do 
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)
    invoice_4 = create(:invoice, merchant: merchant_4)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_4)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 200, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, quantity: 20, unit_price: 400, invoice: invoice_4, item: item_4)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Merchant.most_items(1).first).to eq(merchant_2)
    expect(Merchant.most_items(2)).to eq([merchant_2, merchant_4])
  end

end