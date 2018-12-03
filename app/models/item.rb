class Item < ApplicationRecord

  validates_presence_of :name, :description

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.best_day(item_id)
    joins(invoices: [:transactions])
    .where("transactions.result = ?", "success")
    .where("items.id = ?", item_id)
    .select("items.*, DATE(invoices.created_at) AS date, sum(invoice_items.quantity) AS sold")
    .group("date", "items.id")
    .order("sold")
    .order("date").last.date
  end

  def self.most_revenue(quantity)
    joins(:invoice_items, invoices: [:transactions])
    .where("transactions.result = ?", "success")
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price)")
    .group("items.id")
    .order("sum DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    #! TODO Write me
  end

end
