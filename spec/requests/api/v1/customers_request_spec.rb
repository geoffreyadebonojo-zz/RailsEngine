require 'rails_helper'

describe "Customers API" do
  it "can get a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers" 

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end
    
end