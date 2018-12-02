require 'rails_helper'

describe "Items API" do
  
  it "sends list of all items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    body = JSON.parse(response.body)
    items = body["data"]
    
    expect(items.count).to eq(3)
  end


  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    body = JSON.parse(response.body)
    item = body["data"]
    expect(response).to be_successful
    expect(item["id"]).to eq(id.to_s)
  end

  it "returns item best day" do
    merchant_1 = create(:merchant, name: 'Andy')
    merchant_2 = create(:merchant, name: 'Bob')
    merchant_3 = create(:merchant, name: 'Charles')
    merchant_4 = create(:merchant, name: 'Dave')
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: "2018-08-01 09:00:00 UTC")
    invoice_2 = create(:invoice, merchant: merchant_2, created_at: "2018-08-02 09:00:00 UTC")
    invoice_3 = create(:invoice, merchant: merchant_3, created_at: "2018-08-03 09:00:00 UTC")
    invoice_4 = create(:invoice, merchant: merchant_4, created_at: "2018-08-04 09:00:00 UTC")
    item_1 = create(:item, merchant: merchant_1)
    invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item_1)
    invoice_item2 = create(:invoice_item, quantity: 5, unit_price: 200, invoice: invoice_2, item: item_1)
    invoice_item3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice_3, item: item_1)
    invoice_item4 = create(:invoice_item, quantity: 10, unit_price: 400, invoice: invoice_4, item: item_1)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
    transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
    transaction_4 = create(:transaction, invoice: invoice_4, result: 'success')

    best_day = Item.best_day(item_1.id).date
    expect(best_day).to eq(invoice_4.created_at.to_date)
  end
end
