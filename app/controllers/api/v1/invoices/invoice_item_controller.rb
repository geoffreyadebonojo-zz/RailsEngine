class Api::V1::Invoices::InvoiceItemController < ApplicationController

  def index
    invoice_id = Invoice.where(invoice_id: params[:invoice_id]).invoice_id
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: invoice_id))
  end
end