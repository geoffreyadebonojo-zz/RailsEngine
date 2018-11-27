require 'rails_helper'

describe "InvoiceItems API" do

  it "show a list of invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    
    body = JSON.parse(response.body)
    
    expect(body.count).to eq(3)
  end
end