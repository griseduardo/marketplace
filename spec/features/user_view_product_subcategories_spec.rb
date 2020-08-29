require 'rails_helper'

feature 'User view product subcategories' do
  scenario 'succesfully' do
    product_category = ProductCategory.create!(name: 'Esporte e lazer')
    another_product_category = ProductCategory.create!(name: 'Eletrodomésticos')
    ProductSubcategory.create!(name: 'Futebol', product_category: product_category)
    ProductSubcategory.create!(name: 'Basquete', product_category: product_category)
    ProductSubcategory.create!(name: 'Fogão', product_category: another_product_category)
    
    visit root_path
    click_on 'Esporte e lazer'

    expect(page).to have_content('Esporte e lazer')
    expect(page).to have_content('Futebol')
    expect(page).to have_content('Basquete')
    expect(page).not_to have_content('Fogão')
  end

  scenario 'and no product subcategories are created' do
    ProductCategory.create!(name: 'Eletrodomésticos')

    visit root_path
    click_on 'Eletrodomésticos'

    expect(page).to have_content('Nenhuma subcategoria cadastrada')
  end
end