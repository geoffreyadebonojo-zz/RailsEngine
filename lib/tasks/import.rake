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
    
    CSV.foreach(customers) do |row|
      id, first_name, last_name, created_at, updated_at = row
      customer = Customer.create(id: id, first_name: first_name, last_name: last_name, created_at: created_at, updated_at: updated_at)
      puts "customer #{first_name} #{last_name} - #{customer.errors.full_messages}" if customer.errors.any?
      customers_counter += 1 if customer.persisted?
    end
    Customer.first.destroy

    CSV.foreach(merchants) do |row|
      id, name, created_at, updated_at = row
      merchant = Merchant.create(id: id, name: name, created_at: created_at, updated_at: updated_at)
      puts "merchant #{id} - #{merchant.errors.full_messages}" if merchant.errors.any?
      merchants_counter += 1 if merchant.persisted?
    end
    Merchant.first.destroy

    CSV.foreach(invoices) do |row|
      id, customer_id, merchant_id, status, created_at, updated_at = row
      invoice = Invoice.create(id: id, customer_id: customer_id, merchant_id: merchant_id, status: status, created_at: created_at, updated_at: updated_at)
      puts "invoice #{id} - #{invoice.errors.full_messages}" if invoice.errors.any?
      invoices_counter += 1 if invoice.persisted?
    end
    Invoice.first.destroy

    CSV.foreach(items) do |row|
      id, name, description, unit_price, merchant_id, created_at, updated_at = row
      item = Item.create(id: id, name: name, description: description, unit_price: unit_price, merchant_id: merchant_id, created_at: created_at, updated_at: updated_at)
      puts "item #{id} - #{item.errors.full_messages}" if item.errors.any?
      items_counter += 1 if item.persisted?
    end
    Item.first.destroy

    CSV.foreach(invoice_items) do |row|
      id, item_id, invoice_id, quantity, unit_price, created_at, updated_at = row
      invoice_item = InvoiceItem.create(id: id, item_id: item_id, invoice_id: invoice_id, quantity: quantity, unit_price: unit_price, created_at: created_at, updated_at: updated_at)
      puts "invoice_item #{id} - #{invoice_item.errors.full_messages}" if invoice_item.errors.any?
      invoice_items_counter += 1 if invoice_item.persisted?
    end
    InvoiceItem.first.destroy

    CSV.foreach(transactions) do |row|
      id, item_id, invoice_id, quantity, unit_price, created_at, updated_at = row
      transaction = Transaction.create(id: id, invoice_id: invoice_id, credit_card_number: credit_card_number, credit_card_expiration_date: credit_card_expiration_date, result: result, created_at: created_at, updated_at: updated_at)
      puts "#{id} - #{transaction.errors.full_messages}" if transaction.errors.any?
      transactions_counter += 1 if transaction.persisted?
    end
    Transaction.first.destroy


    puts "Imported #{customers_counter} customers"
    puts "Imported #{merchants_counter} merchants"
    puts "Imported #{invoices_counter} invoices"
    puts "Imported #{items_counter} items"
    puts "Imported #{invoice_items_counter} invoice items"
    puts "Imported #{transactions_counter} transactions"
  end
end