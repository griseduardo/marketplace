require 'rails_helper'

describe Negotiation, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      negotiation = Negotiation.new

      negotiation.valid?

      expect(negotiation.errors[:negotiation_message]).to include('não pode ficar em branco')
      expect(negotiation.errors[:profile]).to include('é obrigatório(a)')
      expect(negotiation.errors[:purchased_product]).to include('é obrigatório(a)')
    end
  end
end
