class Api::V1::Items::MerchantController < ApplicationController

  def show
    merchant_id = Item.find(params[:item_id]).merchant_id
    render json: MerchantSerializer.new(Merchant.find(merchant_id))
  end
end