class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  
  def self.favorite_merchant(customer_id)
    x = joins(invoices: [:transactions, :invoice_items])
    .select("customers.first_name, customers.last_name, invoices.merchant_id AS favorite_merchant_id, COUNT(invoices.id) AS num_invoices")
    .where("customers.id = ?", customer_id)
    .where("transactions.result = ?", "success")
    .group("invoices.merchant_id")
    .group("customers.id")
    .group("invoices.id")
    .order("num_invoices DESC")
    .first.favorite_merchant_id
  end

end
