require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end

  it "can create a new invoice" do
    invoice_params = {status: "shipped"}

    post "/api/v1/invoices", params: {invoice: invoice_params}
  
    invoice = Invoice.last

    expect(response).to be_successful
    expect(invoice.status).to eq(invoice_params[:status])
  end

end