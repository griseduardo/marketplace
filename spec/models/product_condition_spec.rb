require 'rails_helper'

describe ProductCondition, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product_condition = ProductCondition.new

      product_condition.valid?

      expect(product_condition.errors[:name]).to include('não pode ficar em branco')
    end

    it 'name must be unique' do
      ProductCondition.create!(name: 'Usado')
      product_condition = ProductCondition.new(name: 'Usado')

      product_condition.valid?

      expect(product_condition.errors[:name]).to include('já está em uso')
    end

    it 'name uniqueness is not case sensitive' do
      ProductCondition.create!(name: 'Usado')
      product_condition = ProductCondition.new(name: 'usado')

      product_condition.valid?

      expect(product_condition.errors[:name]).to include('já está em uso')
    end
  end
end
