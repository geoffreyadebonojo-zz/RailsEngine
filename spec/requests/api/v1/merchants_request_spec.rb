require 'rails_helper'

describe "Merchant API" do
  it "can get a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants" 

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
    
  it "can get a merchant by id" do
    id = create(:merchant).id
    
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id.to_s)
  end

  it "can find a merchant by name" do
    create(:merchant, name: "Mart")

    expect(Merchant.count).to eq(1)

    get "/api/v1/merchants/find?name=Mart"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant["data"].first["attributes"]["name"]).to eq("Mart")
  end

  it "can find merchant by id" do
    merchant = create(:merchant, name: "Mart")

    expect(Merchant.count).to eq(1)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    data = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(data.count).to eq(1)
    expect(data.first["id"]).to eq(merchant.id.to_s)
  end

  it "can find merchant by created_at" do
    merchant = create(:merchant, name: "Mart", created_at: "2012-03-27T14:53:59.000Z")

    expect(Merchant.count).to eq(1)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    data = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(data.count).to eq(1)
    expect(data.first["id"]).to eq(merchant.id.to_s)
    expect(data.first["attributes"]["created_at"]).to eq("2012-03-27T14:53:59.000Z")    
  end

  it "can find merchant by updated_at" do
    merchant = create(:merchant, name: "Mart", updated_at: "2012-03-27T14:53:59.000Z")

    expect(Merchant.count).to eq(1)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    data = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(data.count).to eq(1)
    expect(data.first["id"]).to eq(merchant.id.to_s)
    expect(data.first["attributes"]["updated_at"]).to eq("2012-03-27T14:53:59.000Z")
  end

  it "returns merchants with most revenue" do
    merchant1 = create(:merchant, name: 'Andy')
    merchant2 = create(:merchant, name: 'Bob')
    merchant3 = create(:merchant, name: 'Charles')
    merchant4 = create(:merchant, name: 'Dave')
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice4 = create(:invoice, merchant: merchant4)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    item4 = create(:item, merchant: merchant4)
    invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: invoice1, item: item1)
    invoice_item2 = create(:invoice_item, quantity: 1, unit_price: 200, invoice: invoice2, item: item2)
    invoice_item3 = create(:invoice_item, quantity: 10, unit_price: 300, invoice: invoice3, item: item3)
    invoice_item4 = create(:invoice_item, quantity: 20, unit_price: 400, invoice: invoice4, item: item4)
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'success')
    transaction4 = create(:transaction, invoice: invoice4, result: 'success')

    expect(Merchant.most_revenue(2)).to eq([merchant4, merchant3])
    expect(Merchant.most_revenue(1)).to eq([merchant4])

    get '/api/v1/merchants/most_revenue?quantity=2'
  
    expect(response).to be_successful

    result = JSON.parse(response.body)
    
    expect(result["data".count]).to 

  end


end