class Api::V1::Invoices::ItemController < ApplicationController

  def index
    item_id = InvoiceItem.where(invoice_id: params[:invoice_id]).item_id
    render json: ItemSerializer.new(Item.find(item_id))
  end
end