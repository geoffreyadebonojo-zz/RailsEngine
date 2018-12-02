class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    id = 1
    # This will be how we find the merchant
    render json: MerchantSerializer.new(Merchant.find(id))    
  end

end