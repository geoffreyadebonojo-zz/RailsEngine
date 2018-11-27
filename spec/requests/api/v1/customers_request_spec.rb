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

  it "can update an existing customer" do
    customer_params = {first_name: "James", last_name: "Bond"}

    id = create(:customer).id
    previous_first_name = Customer.last.first_name
    previous_last_name = Customer.last.last_name

    put "/api/v1/customers/#{id}", params: {customer: customer_params}
    
    customer = Customer.find_by(id: id)

    expect(response).to be_successful

    expect(customer.first_name).to_not eq(previous_first_name)
    expect(customer.first_name).to eq("James")

    expect(customer.last_name).to_not eq(previous_last_name)
    expect(customer.last_name).to eq("Bond")
  end

  it "can destroy a customer" do
    id = create(:customer).id
    expect(Customer.count).to eq(1)
    
    delete "/api/v1/customers/#{id}"
    expect(Customer.count).to eq(0)
    
  end

end