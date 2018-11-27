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

  it "can create an item" do
    invoice_item_params = { quantity: 1, unit_price: 100 }

    post "/api/v1/invoice_items", params: {invoice_item: invoice_item_params}

    invoice_item = InvoiceItem.last

    expect(response).to be_successful

    expect(invoice_item.quantity).to eq(invoice_item_params[:quantity])
    expect(invoice_item.unit_price).to eq(invoice_item_params[:unit_price])

  end

  it "can update an existing invoice item" do
    id = create(:invoice_item).id
    previous_quantity = InvoiceItem.last.quantity
    previous_unit_price = InvoiceItem.last.unit_price

    invoice_item_params = {quantity: 3, unit_price: 200}

    put "/api/v1/invoice_items/#{id}", params: {invoice_item: invoice_item_params}

    ii = InvoiceItem.find_by(id: id)

    expect(response).to be_successful

    expect(ii.quantity).to_not eq(previous_quantity)
    expect(ii.unit_price).to_not eq(previous_unit_price)

  end

end