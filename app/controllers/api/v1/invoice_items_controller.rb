class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.all
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end

  def create
    render json: InvoiceItem.create(invoice_item_params)
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:quantity, :unit_price)
  end
end