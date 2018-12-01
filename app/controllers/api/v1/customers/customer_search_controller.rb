class Api::V1::Customers::CustomerSearchController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.find_by(search_params))
  end

  def index 
    render json: CustomerSerializer.new(Customer.where(search_params))
  end

  def search_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

end