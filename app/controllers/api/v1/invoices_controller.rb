class Api::V1::InvoicesController < ApplicationController
  
  def index
    if params.nil?
      render json: InvoiceSerializer.new(Invoice.all)
    elsif params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_item_id]
      id = InvoiceItem.find(params[:invoice_item_id]).item_id
      render json: InvoiceSerializer.new(Invoice.find(id))
    end
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

  def create
    render json: Invoice.create(invoice_params)
  end

  def update
    render json: Invoice.update(params[:id], invoice_params)
  end

  def destroy
    Invoice.delete(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status)
  end

end