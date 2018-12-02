require 'rails_helper'

describe InvoiceItem, model: :type do

  describe  'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end

end

