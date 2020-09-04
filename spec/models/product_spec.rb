require 'rails_helper'

describe Product, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = Product.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:description]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:quantity]).to include('não pode ficar em branco')
      expect(product.errors[:images]).to include('não pode ficar em branco')
      expect(product.errors[:product_subcategory]).to include('é obrigatório(a)')
      expect(product.errors[:product_condition]).to include('é obrigatório(a)')
      expect(product.errors[:profile]).to include('é obrigatório(a)')
    end

    it 'price and quantity cannot be negative' do
      product = Product.new(price: -10, quantity: -20)

      product.valid?

      expect(product.errors[:price]).to include('deve ser maior que 0')
      expect(product.errors[:quantity]).to include('deve ser maior ou igual a 0')
    end

    it 'price cannot be zero' do
      product = Product.new(price: 0)

      product.valid?

      expect(product.errors[:price]).to include('deve ser maior que 0')
    end
  end
end
