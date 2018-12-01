class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :items
  has_many :invoices

  attribute :created_at
  attribute :updated_at

  attribute :item_count do |merchant|
    merchant.items.count
  end

  attribute :invoice_count do |merchant|
    merchant.invoices.count
  end

  attribute :shipped_invoice_count do |merchant|
    merchant.invoices.where(status: "shipped").count
  end

  attribute :total_revenue do |merchant|
    merchant.total_revenue
  end

end
