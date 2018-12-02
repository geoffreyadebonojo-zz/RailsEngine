class Api::V1::Transactions::TransactionSearchController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.find_by(search_params))
  end

  def index 
    render json: TransactionSerializer.new(Transaction.where(search_params))
  end

  def search_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end

end