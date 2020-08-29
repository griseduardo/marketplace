require 'rails_helper'

describe ProductCategory, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product_category = ProductCategory.new

      product_category.valid?

      expect(product_category.errors[:name]).to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      ProductCategory.create!(name: 'Eletrodomésticos')
      product_category = ProductCategory.new(name: 'Eletrodomésticos')

      product_category.valid?

      expect(product_category.errors[:name]).to include('já está em uso')
    end

    it 'name uniqueness is not case sensitive' do
      ProductCategory.create!(name: 'Eletrodomésticos')
      product_category = ProductCategory.new(name: 'eletrodomésticos')
    
      product_category.valid?

      expect(product_category.errors[:name]).to include('já está em uso')
    end
  end
end