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

  it "can update an existing item" do
    id = create(:invoice).id
    previous_status = Invoice.last.status
    invoice_params = { status: "cancelled"}

    put "/api/v1/invoices/#{id}", params: {invoice: invoice_params}
    invoice = Invoice.find_by(id: id)
    
    expect(response).to be_successful
    
    expect(invoice.status).to_not eq(previous_status)
    expect(invoice.status).to eq(invoice_params[:status])
  end

  it "can destroy an existing item" do
    invoice = create(:invoice)

    expect(Invoice.count).to eq(1)

    delete "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful

    expect(Invoice.count).to eq(0)

    expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end