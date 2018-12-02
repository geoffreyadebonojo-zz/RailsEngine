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

  xit "can create a new item" do
    id = create(:merchant).id
    item_params = {name: "Saw", description: "Its a scary flick", unit_price: 4000, merchant_id: id}

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

 xit "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Hammer" } 
    
    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Hammer")
  end

  xit "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "returns item best day" do
    merchant1 = create(:merchant, name: 'Andy')
    merchant2 = create(:merchant, name: 'Bob')
    merchant3 = create(:merchant, name: 'Charles')
    merchant4 = create(:merchant, name: 'Dave')
    invoice1 = create(:invoice, merchant: merchant1, created_at: "2018-08-01 09:00:00 UTC")
    invoice2 = create(:invoice, merchant: merchant2, created_at: "2018-08-02 09:00:00 UTC")
    invoice3 = create(:invoice, merchant: merchant3, created_at: "2018-08-03 09:00:00 UTC")
    invoice4 = create(:invoice, merchant: merchant4, created_at: "2018-08-04 09:00:00 UTC")
    item1 = create(:item, merchant: merchant1)
    invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice1, item: item1)
    invoice_item2 = create(:invoice_item, quantity: 5, unit_price: 200, invoice: invoice2, item: item1)
    invoice_item3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice3, item: item1)
    invoice_item4 = create(:invoice_item, quantity: 10, unit_price: 400, invoice: invoice4, item: item1)
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')

    best_day = Item.best_day(item1.id).date
    expect(best_day).to eq()
  end
end
