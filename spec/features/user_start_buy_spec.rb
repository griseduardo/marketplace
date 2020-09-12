require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

feature 'User start buy' do
  scenario 'must be logged in to start buy' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!

    visit product_path(product2)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must complete profile to start buy' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    click_on 'Comprar'

    expect(current_path).to eq new_profile_path
    expect(page).to have_content('Necessário cadastrar perfil!')
  end

  scenario 'and seller must not see buy option' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
  
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).not_to have_content('Efetuar compra')
  end

  scenario 'must not see buy option of indisponible product' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '0', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
  
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).not_to have_content('Efetuar compra')
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    fill_in 'Quantidade total', with: '2'
    travel_to Date.new(2004, 11, 24) do
      click_on 'Comprar'
    end
    product2.reload

    expect(page).to have_content('Compra iniciada!')
    expect(page).to have_content('Aguardando aprovação do vendedor')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('Vendas')
    expect(page).to have_content('Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.')
    expect(page).to have_content('Bola')
    expect(page).to have_content('2')
    expect(page).to have_content('Usado')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('24/11/2004')
    expect(body).to include('fevernova1.jpg')
    expect(body).to include('fevernova2.jpg')
    expect(product2.quantity).to eq 1     
  end

  scenario 'and must fill in quantity to buy' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    travel_to Date.new(2004, 11, 24) do
      click_on 'Comprar'
    end
    product2.reload

    expect(page).to have_content('Quantidade total não pode ficar em branco')
    expect(page).not_to have_content('Compra iniciada!')
    expect(page).not_to have_content('Aguardando aprovação do vendedor')
    expect(page).not_to have_content('R$ 480,00')
    expect(page).not_to have_content('2004-11-24')
  end
end