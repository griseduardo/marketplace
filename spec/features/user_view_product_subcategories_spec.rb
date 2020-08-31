require 'rails_helper'

feature 'User view product subcategories' do
  scenario 'must be logged in to view subcategories list' do
    product_category = ProductCategory.create!(name: 'Esporte e lazer')

    visit product_category_path(product_category)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'succesfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    product_category = ProductCategory.create!(name: 'Esporte e lazer')
    another_product_category = ProductCategory.create!(name: 'Eletrodomésticos')
    ProductSubcategory.create!(name: 'Futebol', product_category: product_category)
    ProductSubcategory.create!(name: 'Basquete', product_category: product_category)
    ProductSubcategory.create!(name: 'Fogão', product_category: another_product_category)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'

    expect(page).to have_content('Esporte e lazer')
    expect(page).to have_content('Futebol')
    expect(page).to have_content('Basquete')
    expect(page).not_to have_content('Fogão')
  end

  scenario 'and no product subcategories are created' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    ProductCategory.create!(name: 'Eletrodomésticos')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Eletrodomésticos'

    expect(page).to have_content('Nenhuma subcategoria cadastrada')
  end
end