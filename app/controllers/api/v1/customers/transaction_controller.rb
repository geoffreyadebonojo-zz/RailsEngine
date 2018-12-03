class Api::V1::Customers::TransactionController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    invoices = Invoice.where(customer_id: customer.id)
    render json: TransactionSerializer.new(Transaction.where(invoice_id: invoices.ids))
  end
end