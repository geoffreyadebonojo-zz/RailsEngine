require 'rails_helper'

describe "Merchant API" do
  it "can get a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants" 

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
    
  it "can get a merchant by id" do
    id = create(:merchant).id
    
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can create a new merchant" do
    merchant_params = {name: "McMart" }

    post "/api/v1/merchants", params: {merchant: merchant_params}
    
    merchant = Merchant.last

    expect(merchant.name).to eq("McMart")
  end

  it "can update an existing merchant" do
    merchant_params = {name: "McMart"}

    id = create(:merchant).id
    previous_name = Merchant.last.name

    put "/api/v1/merchants/#{id}", params: {merchant: merchant_params}
    
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful

    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("McMart")

  end

  it "can destroy a merchant" do
    id = create(:merchant).id
    expect(Merchant.count).to eq(1)
    
    delete "/api/v1/merchants/#{id}"
    expect(Merchant.count).to eq(0)
    
  end

end