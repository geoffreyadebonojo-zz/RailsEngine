class Api::V1::Merchants::MerchantSearchController < ApplicationController

  def show
    if params[:id]
      render json: MerchantSerializer.new(Merchant.where(id: params[:id]))
    elsif params[:name]
      render json: MerchantSerializer.new(Merchant.where(name: params[:name]))
    elsif params[:created_at]
      render json: MerchantSerializer.new(Merchant.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: MerchantSerializer.new(Merchant.where(updated_at: params[:updated_at]))
    end
  end

  def index 

  end

end