class Api::V1::Invoices::TransactionController < ApplicationController

  def show
    invoice = Invoice.find(params[:invoice_id])
    render json: TransactionSerializer.new(Transaction.find(invoice.merchant_id))
  end
end