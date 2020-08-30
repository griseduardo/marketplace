require 'rails_helper'

describe ProductSubcategory, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product_subcategory = ProductSubcategory.new

      product_subcategory.valid?

      expect(product_subcategory.errors[:name]).to include('não pode ficar em branco')
      expect(product_subcategory.errors[:product_category]).to include('é obrigatório(a)')
    end

    it 'name must be uniq if different from Outros' do
      product_category = ProductCategory.create!(name: 'Esporte e lazer')
      another_product_category = ProductCategory.create!(name: 'Fisioterapia')
      ProductSubcategory.create!(name: 'Bola', product_category: product_category)
      product_subcategory = ProductSubcategory.new(name: 'Bola', product_category: another_product_category)

      product_subcategory.valid?

      expect(product_subcategory.errors[:name]).to include('já está em uso')
    end

    it 'name accepts Outros repetition' do
      product_category = ProductCategory.create!(name: 'Esporte e lazer')
      another_product_category = ProductCategory.create!(name: 'Eletrodomésticos')
      ProductSubcategory.create!(name: 'Outros', product_category: product_category)
      product_subcategory = ProductSubcategory.new(name: 'Outros', product_category: another_product_category)

      product_subcategory.valid?

      expect(product_subcategory.errors[:name]).not_to include('já está em uso')
    end

    it 'name uniqueness is not case sensitive' do
      product_category = ProductCategory.create!(name: 'Esporte e lazer')
      another_product_category = ProductCategory.create!(name: 'Fisioterapia')
      ProductSubcategory.create!(name: 'Bola', product_category: product_category)
      product_subcategory = ProductSubcategory.new(name: 'bola', product_category: another_product_category)

      product_subcategory.valid?

      expect(product_subcategory.errors[:name]).to include('já está em uso')
    end

    it 'name accepts Outros repetition (is not case sensitive)' do
      product_category = ProductCategory.create!(name: 'Esporte e lazer')
      another_product_category = ProductCategory.create!(name: 'Eletrodomésticos')
      ProductSubcategory.create!(name: 'outros', product_category: product_category)
      product_subcategory = ProductSubcategory.new(name: 'outros', product_category: another_product_category)

      product_subcategory.valid?

      expect(product_subcategory.errors[:name]).not_to include('já está em uso')      
    end
  end
end
