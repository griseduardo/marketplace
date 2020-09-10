require 'rails_helper'

feature 'User register valid product' do
  scenario 'must be logged in to view product' do
    visit root_path

    expect(page).not_to have_link('Cadastrar produto')
  end

  scenario 'and attributes cannot be blank' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                    work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar produto'
    click_on 'Enviar'

    expect(Product.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 5)
    expect(page).to have_content('é obrigatório', count: 2)
  end

  scenario 'and price cannot be less or equal zero, quantity cannot be negative' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                    work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user)
    product_category = ProductCategory.create!(name: 'Esporte e lazer')
    ProductSubcategory.create!(name: 'Bola', product_category: product_category)
    ProductCondition.create!(name: 'Usado')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: 'Adidas Fevernova - Bola da copa de 2002'
    select 'Bola', from: 'Subcategoria' 
    fill_in 'Descrição', with: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas. Ano em que o Brasil foi campeão mundial.'
    fill_in 'Preço', with: '-10'
    select 'Usado', from: 'Condição'
    fill_in 'Quantidade', with: '-3'
    click_on 'Enviar'

    expect(Product.count).to eq 0
    expect(page).to have_content('deve ser maior que 0', count: 1)
    expect(page).to have_content('deve ser maior ou igual a 0', count: 1)
  end
end