require 'rails_helper'

describe "Customers API" do
  it "can get a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers" 

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end
    
  it "can get a customer by id" do
    id = create(:customer).id
    
    get "/api/v1/customers/#{id}"

    expect(response).to be_successful
  end
end