class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :status, :created_at

  belongs_to :customer
  belongs_to :merchant
end
