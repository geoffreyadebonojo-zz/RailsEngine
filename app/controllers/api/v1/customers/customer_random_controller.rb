class Api::V1::Invoices::InvoiceRandomController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.find(rand(100)))    
  end

end