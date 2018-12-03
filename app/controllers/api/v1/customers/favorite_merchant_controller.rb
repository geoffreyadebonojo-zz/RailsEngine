class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    id = Customer.favorite_merchant(params[:customer_id])

    render json: MerchantSerializer.new(Merchant.find(id))    
  end

end