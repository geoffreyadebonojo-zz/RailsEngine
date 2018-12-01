class Api::V1::InvoiceItems::InvoiceItemRandomController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(rand(100)))    
  end

end