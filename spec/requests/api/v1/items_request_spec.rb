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
end
