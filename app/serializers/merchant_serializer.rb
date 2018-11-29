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
    
    m = merchant.invoices.where(status: "shipped").pluck(:id)

    x = InvoiceItem.find(m).pluck(:unit_price, :quantity)

    z = x.map do |y|
      (y[0] * y[1]).to_f / 100
    end.sum
  end

end
