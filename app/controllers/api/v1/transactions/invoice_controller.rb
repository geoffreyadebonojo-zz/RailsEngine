class Api::V1::Transactions::InvoiceController < ApplicationController

  def show
    invoice_id = Transaction.find(params[:transaction_id]).invoice_id
    render json: TransactionSerializer.new(Transaction.where(invoice_id: invoice_id))
  end
end