class Api::V1::ItemsController < ApplicationController

  def index
    if params.nil?
      render json: ItemSerializer.new(Item.all)
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_id]
      items = Invoice.find(params[:invoice_id]).items
      render json: ItemSerializer.new(items)
    elsif params[:invoice_item_id]
      id = InvoiceItem.find(params[:invoice_item_id]).item_id
      render json: ItemSerializer.new(Item.find(id))
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: Item.create(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end