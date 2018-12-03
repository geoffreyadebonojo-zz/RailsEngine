require 'rails_helper'

describe Customer, model: :type do

  describe  'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  it '.favorite_merchant' do 
    customer_1 = create(:customer, first_name: "Wannaby", last_name:"Goods" )
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1 )
    invoice_2 = create(:invoice, merchant: merchant_2, customer: customer_1 )
    invoice_3 = create(:invoice, merchant: merchant_3, customer: customer_1 )
    invoice_4 = create(:invoice, merchant: merchant_1, customer: customer_1 )
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_1)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1000, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 100, unit_price: 2, invoice: invoice_2, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice_3, item: item_3)
    invoice_item_4 = create(:invoice_item, quantity: 20, unit_price: 400, invoice: invoice_4, item: item_4)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    expect(Customer.favorite_merchant(customer_1.id)).to eq(merchant_1.id)
  end
  
end