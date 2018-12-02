class Api::V1::InvoiceItems::InvoiceItemSearchController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params))
  end

  def index 
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params))
  end

  def search_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at)
  end

end