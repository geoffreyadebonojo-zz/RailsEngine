class Merchant < ApplicationRecord
  
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  #? TODO works, but how to expose

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = ?", "success")
    .select('merchants.*, 
    SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group("merchants.id")
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity) AS total_sold")
    .where("transactions.result = ?", "success")
    .group("merchants.id")
    .order("total_sold DESC")
    .limit(quantity)
  end

  def self.revenue(date) 
    x = joins(invoices: [:invoice_items, :transactions])
    .group("merchants.id")
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where("DATE(invoices.created_at) = ?", date)
  end

end