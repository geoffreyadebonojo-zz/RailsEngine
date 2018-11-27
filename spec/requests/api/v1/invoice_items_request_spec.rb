require 'rails_helper'

describe "InvoiceItems API" do

  it "show a list of invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    
    body = JSON.parse(response.body)
    
    expect(body.count).to eq(3)
  end

  it "can show a single invoice item by id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["quantity"]).to eq(1)
    expect(invoice_item["unit_price"]).to eq(100)    
  end

end