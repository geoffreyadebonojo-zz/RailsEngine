class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    # This will be how we find the merchant
    id = Customer.favorite_merchant(params[:customer_id])

    render json: MerchantSerializer.new(Merchant.find(id))    
  end

end