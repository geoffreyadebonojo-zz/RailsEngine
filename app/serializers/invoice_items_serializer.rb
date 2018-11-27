class InvoiceItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice
end
