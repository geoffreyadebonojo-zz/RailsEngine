class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :unit_price

  belongs_to :merchant
end
