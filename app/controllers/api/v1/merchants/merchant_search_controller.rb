class Api::V1::Merchants::MerchantSearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(search_params))
  end

  def index 
    render json: MerchantSerializer.new(Merchant.where(search_params))
  end

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end