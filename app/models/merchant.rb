class Merchant < ApplicationRecord
  
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # TODO Check this please
  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = ?", "success")
    .select('merchants.*, 
    SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group("merchants.id")
    .order("total_revenue DESC")
    .limit(quantity)
  end


end