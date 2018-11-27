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

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it "can create a new customer" do
    customer_params = {first_name: "Mary", last_name: "Sue"}

    post "/api/v1/customers", params: {customer: customer_params}
    
    customer = Customer.last

    expect(customer.first_name).to eq ("Mary")
    expect(customer.last_name).to eq ("Sue")
  end


end