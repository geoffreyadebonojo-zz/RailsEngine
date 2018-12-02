require 'rails_helper'

describe Invoice, model: :type do

  describe  'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

end