class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if params.nil? && params[:invoice_id].nil?
      render json: InvoiceItemSerializer.new(InvoiceItem.all)
    elsif params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: params[:invoice_id]))
    elsif params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: params[:item_id]))
    end
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end

  def create
    render json: InvoiceItem.create(invoice_item_params)
  end

  def update
    render json: InvoiceItem.update(params[:id], invoice_item_params)
  end

  def destroy
    InvoiceItem.delete(params[:id])
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:quantity, :unit_price)
  end
end