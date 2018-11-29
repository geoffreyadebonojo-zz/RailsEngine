class Merchant < ApplicationRecord
  
  has_many :items
  has_many :invoices

  def self.most_revenue
    select('merchants.*, 
    SUM(invoice_items.quantity * invoice_items.unit_price) AS total_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .order('total_sold DESC')
  end

end