class Api::V1::Merchants::MerchantRandomController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find(rand(100)))    
  end

end