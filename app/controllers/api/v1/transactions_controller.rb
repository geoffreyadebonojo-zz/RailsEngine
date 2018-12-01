class Api::V1::TransactionsController < ApplicationController

  def index
    if params.nil?
      render json: TransactionSerializer.new(Transaction.all)
    elsif params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:invoice_id]))
    elsif params[:customer_id]
      # TODO Review this
      id = Customer.find(params[:customer_id]).id
      invoice_id = Invoice.where(customer_id: id)
      render json: TransactionSerializer.new(Transaction.where(invoice_id: invoice_id))
    end
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end

  def create
    render json: Transaction.create(transaction_params)
  end

  def update
    render json: Transaction.update(params[:id], transaction_params)
  end

  def destroy
    Transaction.delete(params[:id])
  end

  private

  def transaction_params
    params.require(:transaction).permit(:credit_card_number, :credit_card_expiration_date, :result)
  end
end