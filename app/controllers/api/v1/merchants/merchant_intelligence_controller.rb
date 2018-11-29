class Api::V1::Merchants::MerchantIntelligenceController < ApplicationController

  def show
    # binding.pry
    render json: MerchantSerializer.new( Merchant.most_revenue)
  end

end