class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: {"data"=>{"revenue"=>Merchant.revenue(params[:date])}}
  end

end