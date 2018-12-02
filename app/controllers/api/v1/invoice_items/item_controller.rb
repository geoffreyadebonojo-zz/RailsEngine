class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
    item_id = InvoiceItem.find(params[:invoice_item_id]).item_id

    render json: ItemSerializer.new(Item.find(item_id))    
  end

end