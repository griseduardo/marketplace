require 'rails_helper'

feature 'User view products' do
  scenario 'must be logged in to view products' do

    visit root_path

    expect(page).not_to have_content('Produtos')
  end

  scenario 'must be logged in to view product list for specific category' do
    product_category = ProductCategory.create!(name: 'Esporte e lazer')

    visit product_category_path(product_category)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view product list for specific subcategory' do
    product_category = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory = ProductSubcategory.create!(name: 'Futebol', product_category: product_category)

    visit product_subcategory_path(product_subcategory)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view product list for specific profile' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'eduardo@rotes.com', password: '120456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user)
    visit profile_path(profile)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'succesfully the first image of each product in home page (same company, others users)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user3 = User.create!(email: 'fernanda@secal.com', password: '003456')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bola de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile1)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product1.save!
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
    profile3 = Profile.create!(full_name: 'Fernanda Silva', birthday: '23/01/1988', 
                    work_address: 'Rua Nilza, 17', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user3)
    product3 = Product.new(name: 'Bolo de cenoura', product_subcategory: product_subcategory1, 
                           description: 'Bolo de cenoura caseiro.', price: '30', product_condition: product_condition1, 
                           quantity: '3', profile: profile3)
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura1.png')), filename: 'cenoura1.png')
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura2.jpg')), filename: 'cenoura2.jpg')
    product3.save!

    login_as(user1, scope: :user)
    visit root_path

    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
    expect(body).not_to include('brigadeiro2.jpg')
    expect(body).not_to include('cenoura1.png')
    expect(body).not_to include('cenoura2.jpg')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de brigadeiro')
  end

  scenario 'and no products are created' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')

    login_as(user1, scope: :user)
    visit root_path
    
    expect(page).to have_content('Nenhum produto disponível')
  end

  scenario 'succesfully the first image of each product for a specific category (same company, others users)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'joicy@rotes.com', password: 'dad456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user4 = User.create!(email: 'fernanda@secal.com', password: '003456')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile1)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product1.save!
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
    profile3 = Profile.create!(full_name: 'Joicy Andrade', birthday: '01/02/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user3)
    product_subcategory3 = ProductSubcategory.create!(name: 'Salgado', product_category: product_category1)
    product3 = Product.new(name: 'Coxinha de frango', product_subcategory: product_subcategory3, 
                           description: 'Coxinha de frango com bastante recheio', price: '3', product_condition: product_condition1, 
                           quantity: '1', profile: profile3)
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha1.png')), filename: 'coxinha1.png')
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha2.jpeg')), filename: 'coxinha2.jpeg')
    product3.save!
    profile4 = Profile.create!(full_name: 'Fernanda Silva', birthday: '23/01/1988', 
                    work_address: 'Rua Nilza, 17', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user4)
    product4 = Product.new(name: 'Bolo de cenoura', product_subcategory: product_subcategory1, 
                           description: 'Bolo de cenoura caseiro.', price: '30', product_condition: product_condition1, 
                           quantity: '3', profile: profile4)
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura1.png')), filename: 'cenoura1.png')
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura2.jpg')), filename: 'cenoura2.jpg')
    product4.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Esporte e lazer'

    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
    expect(body).not_to include('brigadeiro2.jpg')
    expect(body).not_to include('coxinha1.png')
    expect(body).not_to include('coxinha2.jpeg')
    expect(body).not_to include('cenoura1.png')
    expect(body).not_to include('cenoura2.jpg')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(page).not_to have_content('Coxinha de frango')
  end

  scenario 'and no products are created for a specific category' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    product_category1 = ProductCategory.create!(name: 'Alimentos')
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
    click_on 'Alimentos'

    expect(page).to have_content('Nenhum produto disponível')
  end

  scenario 'succesfully the first image of each product for a specific subcategory (same company, others users)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'joicy@rotes.com', password: 'dad456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user4 = User.create!(email: 'fernanda@secal.com', password: '003456')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile1)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product1.save!
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
    profile3 = Profile.create!(full_name: 'Joicy Andrade', birthday: '01/02/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user3)
    product_subcategory3 = ProductSubcategory.create!(name: 'Salgado', product_category: product_category1)
    product3 = Product.new(name: 'Coxinha de frango', product_subcategory: product_subcategory3, 
                           description: 'Coxinha de frango com bastante recheio', price: '3', product_condition: product_condition1, 
                           quantity: '1', profile: profile3)
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha1.png')), filename: 'coxinha1.png')
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha2.jpeg')), filename: 'coxinha2.jpeg')
    product3.save!
    profile4 = Profile.create!(full_name: 'Fernanda Silva', birthday: '23/01/1988', 
                    work_address: 'Rua Nilza, 17', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user4)
    product4 = Product.new(name: 'Bolo de cenoura', product_subcategory: product_subcategory1, 
                           description: 'Bolo de cenoura caseiro.', price: '30', product_condition: product_condition1, 
                           quantity: '3', profile: profile4)
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura1.png')), filename: 'cenoura1.png')
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura2.jpg')), filename: 'cenoura2.jpg')
    product4.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Alimentos'
    click_on 'Doces'

    expect(page).to have_content('Bolo de brigadeiro')
    expect(body).to include('brigadeiro1.png')
    expect(body).not_to include('brigadeiro2.jpg')
    expect(body).not_to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('coxinha1.png')
    expect(body).not_to include('coxinha2.jpeg')
    expect(body).not_to include('cenoura1.png')
    expect(body).not_to include('cenoura2.jpg')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).not_to have_content('Coxinha de frango')
  end

  scenario 'and no products are created for a specific subcategory' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
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
    click_on 'Alimentos'
    click_on 'Doces'

    expect(page).to have_content('Nenhum produto disponível')
  end

  scenario 'succesfully the first image of each product for a specific profile (same company, other user)' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'joicy@rotes.com', password: 'dad456')
    Company.create!(name: 'Secal', cnpj: '80.455.285/0001-94', domain: 'secal.com')
    user4 = User.create!(email: 'fernanda@secal.com', password: '003456')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile1)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product1.save!
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
    profile3 = Profile.create!(full_name: 'Joicy Andrade', birthday: '01/02/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user3)
    product_subcategory3 = ProductSubcategory.create!(name: 'Salgado', product_category: product_category1)
    product3 = Product.new(name: 'Coxinha de frango', product_subcategory: product_subcategory3, 
                           description: 'Coxinha de frango com bastante recheio', price: '3', product_condition: product_condition1, 
                           quantity: '1', profile: profile3)
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha1.png')), filename: 'coxinha1.png')
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha2.jpeg')), filename: 'coxinha2.jpeg')
    product3.save!
    profile4 = Profile.create!(full_name: 'Fernanda Silva', birthday: '23/01/1988', 
                    work_address: 'Rua Nilza, 17', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                    department: department, user: user4)
    product4 = Product.new(name: 'Bolo de cenoura', product_subcategory: product_subcategory1, 
                           description: 'Bolo de cenoura caseiro.', price: '30', product_condition: product_condition1, 
                           quantity: '3', profile: profile4)
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura1.png')), filename: 'cenoura1.png')
    product4.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cenoura2.jpg')), filename: 'cenoura2.jpg')
    product4.save!
    
    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'

    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
    expect(body).not_to include('brigadeiro1.png')
    expect(body).not_to include('brigadeiro2.jpg')
    expect(body).not_to include('coxinha1.png')
    expect(body).not_to include('coxinha2.jpeg')
    expect(body).not_to include('cenoura1.png')
    expect(body).not_to include('cenoura2.jpg')
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de brigadeiro')
    expect(page).not_to have_content('Coxinha de frango')
  end

  scenario 'and no products are created for a specific profile' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user2)

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Carol Gomes'

    expect(page).to have_content('Nenhum produto disponível')
  end
 
  scenario 'succesfully the first image of each product for own profile' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456') 
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_subcategory1 = ProductSubcategory.create!(name: 'Doces', product_category: product_category1)
    product_condition1 = ProductCondition.create!(name: 'Novo')
    product1 = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory1, 
                           description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition1, 
                           quantity: '1', profile: profile1)
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product1.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product1.save!
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
    click_on 'Meus produtos'

    expect(page).to have_content('Bolo de brigadeiro')
    expect(body).to include('brigadeiro1.png')
    expect(body).not_to include('brigadeiro2.jpg')
    expect(page).not_to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(body).not_to include('fevernova1.jpg')
    expect(body).not_to include('fevernova2.jpg')
  end

  scenario 'and no products are created for own profile' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user1)

                               login_as(user1, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    expect(page).to have_content('Nenhum produto disponível')
  end

  scenario 'and view details' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'joicy@rotes.com', password: 'dad456')
    department = Department.create!(name: 'RH')
    product_category1 = ProductCategory.create!(name: 'Alimentos')
    product_condition1 = ProductCondition.create!(name: 'Novo')
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
    profile3 = Profile.create!(full_name: 'Joicy Andrade', birthday: '01/02/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department, user: user3)
    product_subcategory3 = ProductSubcategory.create!(name: 'Salgado', product_category: product_category1)
    product3 = Product.new(name: 'Coxinha de frango', product_subcategory: product_subcategory3, 
                           description: 'Coxinha de frango com bastante recheio', price: '3', product_condition: product_condition1, 
                           quantity: '1', profile: profile3)
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha1.png')), filename: 'coxinha1.png')
    product3.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'coxinha2.jpeg')), filename: 'coxinha2.jpeg')
    product3.save!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('RH')
    expect(page).to have_content('Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.')
    expect(page).to have_content('Bola')
    expect(page).to have_content('240')
    expect(page).to have_content('Usado')
    expect(page).to have_content('2')
    expect(body).to include('fevernova1.jpg')
    expect(body).to include('fevernova2.jpg')
    expect(page).not_to have_content('Coxinha de frango')
  end
end