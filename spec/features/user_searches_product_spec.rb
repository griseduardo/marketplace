require 'rails_helper'

feature 'User searches product' do
  scenario 'must be logged in to view search form' do
    visit root_path

    expect(page).not_to have_content('Busca de produto')
  end

  scenario 'must be logged in to view search form in category details' do
    product_category = ProductCategory.create!(name: 'Eletrodomésticos')
    
    visit product_category_path(product_category)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view search form in subcategory details' do
    product_category = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory = ProductSubcategory.create!(name: 'Futebol', product_category: product_category)

    visit product_subcategory_path(product_subcategory)

    expect(current_path).to eq new_user_session_path

  end

  scenario 'must be logged in to view search form in seller details' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                    department: department, user: user, work_address: 'Rua Evans, 30')

    visit profile_path(profile)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and find partial match (product name, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).to include('fevernova1.jpg')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match (product name, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match (product name, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and find partial match (product subcategory, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Futebol', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Fut'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match (product subcategory, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Futebol', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Fut'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match (product subcategory, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Futebol', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Fut'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and find partial match (product description, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match (product description, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match (product description, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match (product suspended)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.suspended!
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    fill_in 'Busca de produto', with: 'Bol'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).to include('fevernova1.jpg')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and find partial match in specific category (product name, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match in specific category (product name, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific category (product name, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and find partial match in specific category (product description, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match in specific category (product description, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific category (product description, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific category (product suspended)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Outros')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.suspended!
    product1.save!
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category1)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Outros'
    fill_in 'Busca de produto', with: 'Bol'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and find partial match in specific subcategory (product name, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match in specific subcategory (product name, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific subcategory (product name, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and find partial match in specific subcategory (product description, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match in specific subcategory (product description, own user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific subcategory (product description, other company user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user2 = User.create!(email: 'carol@secal.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'
    click_on 'Bola'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
  end

  scenario 'and does not find partial match in specific subcategory (product suspended)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Diversos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Outros', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.suspended!
    product1.save!
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory1, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Diversos'
    click_on 'Outros'
    fill_in 'Busca de produto', with: 'Bol'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end
  
  scenario 'and find partial match in specific profile (product name, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'
    fill_in 'Busca de produto', with: 'Adidas'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and find partial match in specific profile (product subcategory, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Futebol', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'
    fill_in 'Busca de produto', with: 'Fut'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and find partial match in specific profile (product description, other user of same company)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'
    fill_in 'Busca de produto', with: 'FIFA'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end

  scenario 'and does not find partial match in specific profile (product suspended)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile2)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.suspended!
    product1.save!
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'
    fill_in 'Busca de produto', with: 'Bol'
    click_on 'Buscar'
    
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
  end
end