class Api::V1::CustomersController < ApplicationController
  
  def index
    if params.nil? && params[:invoice_id].nil?
      render json: CustomerSerializer.new(Customer.all)
    elsif params[:invoice_id]
      id = Invoice.find(params[:invoice_id]).customer_id
      render json: CustomerSerializer.new(Customer.find(id))
    end
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def create
    render json: Customer.create(customer_params)
  end

  def update
    render json: Customer.update(params[:id], customer_params)
  end

  def destroy
    render json: Customer.delete(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end