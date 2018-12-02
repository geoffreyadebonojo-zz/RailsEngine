class Api::V1::Invoices::CustomerController < ApplicationController

  def show
    invoice = Invoice.find(params[:invoice_id])
    render json: CustomerSerializer.new(Customer.find(invoice.customer_id))
  end
end