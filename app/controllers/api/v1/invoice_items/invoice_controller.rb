class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    ii_id = InvoiceItem.find(params[:invoice_item_id]).invoice_id
    render json: InvoiceSerializer.new(Invoice.find(ii_id))    
  end

end