class Api::V1::MerchantsController < ApplicationController
  
  def index
    if params.nil?
      render json: MerchantSerializer.new(Merchant.all)
    elsif params[:invoice_id]
      id = Invoice.find(params[:invoice_id]).merchant_id
      render json: CustomerSerializer.new(Customer.find(id))
    end
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: Merchant.create(merchant_params)
  end

  def update
    render json: Merchant.update(params[:id], merchant_params)
  end

  def destroy
    render json: Merchant.delete(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end