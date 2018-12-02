class Customer < ApplicationRecord

  validates_presence_of :first_name, :last_name

  has_many :invoices
  
  def self.favorite_merchant
    #! TODO Write me
  end

end
