class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status

  belongs_to :customer
  belongs_to :merchant
end
