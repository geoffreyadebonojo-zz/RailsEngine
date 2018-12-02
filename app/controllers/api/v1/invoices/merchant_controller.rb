class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    invoice = Invoice.find(params[:invoice_id])
    render json: MerchantSerializer.new(Merchant.find(invoice.merchant_id))
  end
end