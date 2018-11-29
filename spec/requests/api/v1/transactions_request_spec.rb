require 'rails_helper'

describe "Transaction API" do
  it "can get a list of transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions" 
    
    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end
    
  it "can get a transaction by id" do
    id = create(:transaction).id
    
    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id.to_s)
  end

  xit "can create a new transaction" do
    transaction_params = 
    {credit_card_number: "4654405418249632",
    credit_card_expiration_date: "000",
    result: "success" }

    post "/api/v1/transactions", params: {transaction: transaction_params}
    
    transaction = Transaction.last

    expect(transaction.credit_card_number).to eq("4654405418249632")
  end

  xit "can update an existing transaction" do
    transaction_params =
    {credit_card_number: "4654405418249632",
    credit_card_expiration_date: "000",
    result: "success" }

    id = create(:transaction).id
    previous_ccn = Transaction.last.credit_card_number

    put "/api/v1/transactions/#{id}", params: {transaction: transaction_params}
    
    transaction = Transaction.find_by(id: id)

    expect(response).to be_successful

    expect(transaction.credit_card_number).to_not eq(previous_ccn)
    expect(transaction.credit_card_number).to eq(transaction_params[:credit_card_number])

  end

  xit "can destroy a transaction" do
    id = create(:transaction).id
    expect(Transaction.count).to eq(1)
    
    delete "/api/v1/transactions/#{id}"
    expect(Transaction.count).to eq(0)
    
  end

end