class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    revenue = Merchant.revenue(params[:date])
    render json: {"data" => {"attributes" => {"revenue" => revenue}}}
  end

end