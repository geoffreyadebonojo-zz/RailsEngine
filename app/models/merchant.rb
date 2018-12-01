class Merchant < ApplicationRecord
  
  has_many :items
  has_many :invoices

  # TODO Check this please
  def self.most_revenue
    select('merchants.*, 
    SUM(invoice_items.quantity * invoice_items.unit_price) AS total_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .order('total_sold DESC')
  end

  def total_revenue
    x = invoices.select('invoices.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS total').joins(:invoice_items).group(:id)
  end

end