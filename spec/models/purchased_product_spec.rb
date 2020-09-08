require 'rails_helper'

describe PurchasedProduct, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      purchased_product = PurchasedProduct.new

      purchased_product.valid?

      expect(purchased_product.errors[:total_quantity]).to include('não pode ficar em branco')
      expect(purchased_product.errors[:initial_value]).to include('não pode ficar em branco')
      expect(purchased_product.errors[:profile]).to include('é obrigatório(a)')
      expect(purchased_product.errors[:product]).to include('é obrigatório(a)')      
    end
  end
end
