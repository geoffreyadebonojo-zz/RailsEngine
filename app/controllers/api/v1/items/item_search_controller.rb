class Api::V1::Items::ItemSearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find_by(search_params))
  end

  def index 
    render json: ItemSerializer.new(Item.where(search_params))
  end

  def search_params
    params.permit(:id, :invoice_id, :item_id, :name, :description, :created_at, :updated_at, :merchant_id)
  end

end