class Api::V1::Merchants::MerchantIntelligenceController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.most_revenue)
  end

end