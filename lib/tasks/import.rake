require 'csv'

namespace :import do
  desc "imports data from a csv file"
  task :data => :environment do
    require 'csv'
    customers_counter = 0
    invoice_items_counter = 0
    invoices_counter = 0
    items_counter = 0
    merchants_counter = 0
    transactions_counter = 0

    customers = File.join Rails.root, "customers.csv"
    invoice_items = File.join Rails.root, "invoice_items.csv"
    invoices = File.join Rails.root, "invoices.csv"
    items = File.join Rails.root, "items.csv"
    merchants = File.join Rails.root, "merchants.csv"
    transactions = File.join Rails.root, "transactions.csv"
    
    CSV.foreach(customers, headers: true) do |row|
      attempt = Customer.create!(row.to_hash)
      customers_counter += 1 if attempt.persisted?
    end
    puts "Imported #{customers_counter} customers"


    CSV.foreach(merchants, headers: true) do |row|
      merchant = Merchant.create!(row.to_hash)
      merchants_counter += 1 if merchant.persisted?
    end
    puts "Imported #{merchants_counter} merchants"
    
    
    CSV.foreach(invoices, headers: true) do |row|
      invoice = Invoice.create!(row.to_hash)
      invoices_counter += 1 if invoice.persisted?
    end
    puts "Imported #{invoices_counter} invoices"
    

    CSV.foreach(items, headers: true) do |row|
      item = Item.create!(row.to_hash)
      items_counter += 1 if item.persisted?
    end
    puts "Imported #{items_counter} items"
    

    CSV.foreach(invoice_items, headers: true) do |row|
      invoice_item = InvoiceItem.create!(row.to_hash)
      invoice_items_counter += 1 if invoice_item.persisted?
    end
    puts "Imported #{invoice_items_counter} invoice items"
    

    CSV.foreach(transactions, headers: true) do |row|
      transaction = Transaction.create!(row.to_hash)
      transactions_counter += 1 if transaction.persisted?
    end
    puts "Imported #{transactions_counter} transactions"


  end
end