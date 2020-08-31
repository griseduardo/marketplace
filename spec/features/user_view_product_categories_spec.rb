require 'rails_helper'

feature 'User view product categories' do
  scenario 'must be logged in to view categories list' do
    visit root_path

    expect(page).not_to have_content('Categorias')
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    ProductCategory.create!(name: 'Eletrodomésticos')
    ProductCategory.create!(name: 'Esporte e lazer')
  
    login_as(user, scope: :user)
    visit root_path
  
    expect(page).to have_content('Eletrodomésticos')
    expect(page).to have_content('Esporte e lazer')
  end

  scenario 'and no product categories are created' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end
end  