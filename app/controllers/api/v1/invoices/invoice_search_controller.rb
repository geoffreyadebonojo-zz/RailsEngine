class Api::V1::Invoices::InvoiceSearchController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params))
  end

  def index 
    render json: InvoiceSerializer.new(Invoice.where(search_params))
  end

  def search_params
    params.permit(:id, :status, :created_at, :updated_at)
  end

end