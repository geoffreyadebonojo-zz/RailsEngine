require 'rails_helper'

describe "Transaction API" do
  it "can get a list of transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions" 
    
    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end
    
  it "can get a transaction by id" do
    id = create(:transaction).id
    
    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id.to_s)
  end

end