require 'rails_helper'

describe Customer, model: :type do

  describe  'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end
  
end