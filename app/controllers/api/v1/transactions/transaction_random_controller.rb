class Api::V1::Transactions::TransactionRandomController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.find(rand(100)))    
  end

end