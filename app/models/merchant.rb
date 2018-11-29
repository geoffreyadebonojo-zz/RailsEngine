class Merchant < ApplicationRecord
  
  has_many :items
  has_many :invoices

  def revenue
    m = merchant.invoices.where(status: "shipped").pluck(:id)

    x = InvoiceItem.find(m).pluck(:unit_price, :quantity)

    z = x.map do |y|
      (y[0] * y[1]).to_f / 100
    end.sum
  end

end