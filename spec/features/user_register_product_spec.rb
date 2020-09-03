require 'rails_helper'

feature 'User register product' do
  scenario 'must be logged in to view product' do
    visit root_path

    expect(page).not_to have_link('Cadastrar produto')
  end

  scenario 'must be logged in to register product' do
    visit new_product_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must complete profile to register product' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar produto'

    expect(current_path).to eq new_profile_path
    expect(page).to have_content('Necessário cadastrar perfil!')
  end

  scenario 'successfully' do
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
    fill_in 'Preço', with: '240'
    select 'Usado', from: 'Condição'
    fill_in 'Quantidade', with: '2'
    click_on 'Cadastrar'

    expect(page).to have_content('Cadastrado com sucesso!')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('RH')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Bola')
    expect(page).to have_content('Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas. Ano em que o Brasil foi campeão mundial.')
    expect(page).to have_content('R$ 240,00')
    expect(page).to have_content('Usado')
    expect(page).to have_content('2')
  end

  scenario 'must fill in all fields' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                    work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar produto'
    click_on 'Cadastrar'
    
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Subcategoria é obrigatório(a)')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Condição é obrigatório(a)')
    expect(page).to have_content('Quantidade não pode ficar em branco')
  end
end