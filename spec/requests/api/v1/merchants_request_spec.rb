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

  xit "can create a new merchant" do
    merchant_params = {name: "McMart" }

    post "/api/v1/merchants", params: {merchant: merchant_params}
    
    merchant = Merchant.last

    expect(merchant.name).to eq("McMart")
  end

  xit "can update an existing merchant" do
    merchant_params = {name: "McMart"}

    id = create(:merchant).id
    previous_name = Merchant.last.name

    put "/api/v1/merchants/#{id}", params: {merchant: merchant_params}
    
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful

    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("McMart")

  end

  xit "can destroy a merchant" do
    id = create(:merchant).id
    expect(Merchant.count).to eq(1)
    
    delete "/api/v1/merchants/#{id}"
    expect(Merchant.count).to eq(0)
    
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
    # binding.pry
    expect(response).to be_successful
    expect(data.count).to eq(1)
    expect(data.first["id"]).to eq(merchant.id.to_s)
    expect(data.first["attributes"]["updated_at"]).to eq("2012-03-27T14:53:59.000Z")
  end


end