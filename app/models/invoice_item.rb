class InvoiceItem < ApplicationRecord

  belongs_to :invoice
  belongs_to :item

  def total
    self.quantity * self.unit_price
  end
end
