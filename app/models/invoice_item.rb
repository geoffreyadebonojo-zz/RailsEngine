class InvoiceItem < ApplicationRecord

  validates_presence_of :quantity, :unit_price

  belongs_to :invoice
  belongs_to :item

  def self.invoice_totals
    group(:invoice_id).sum("quantity * unit_price")
  end

  def self.invoices_by_cost
    group(:invoice_id).order("sum(quantity * unit_price)")
  end
  
  def self.expensive_invoices
    joins(:invoices_items, :transactions)
      .where(transactions: {result: "success"})
      .group(:id)
      .order("sum(quantity * unit_price)")
      .limit(5)
  end
  
end
