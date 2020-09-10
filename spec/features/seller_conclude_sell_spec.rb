require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

feature 'Seller conclude sell' do
  scenario 'must be logged in to conclude sell' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'perdigao@rotes.com', password: '12ff456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    profile3 = Profile.create!(full_name: 'Perdigão Antunes', birthday: '10/03/1982', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user3)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    total_quantity = 2
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')                                                
    purchased_product.andamento!
    product2.quantity = product2.quantity - total_quantity
    
    visit product_purchased_product_path(product2, purchased_product)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'perdigao@rotes.com', password: '12ff456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    profile3 = Profile.create!(full_name: 'Perdigão Antunes', birthday: '10/03/1982', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user3)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    total_quantity = 2
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')                                                
    purchased_product.andamento!
    product2.quantity = product2.quantity - total_quantity 

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    fill_in 'Frete', with: '3'
    fill_in 'Desconto', with: '20'
    travel_to Date.new(2004, 11, 24) do
      click_on 'Concluir venda'
    end

    expect(page).to have_content('Venda concluída')
    expect(page).to have_content('24/11/2004')
    expect(page).to have_content('R$ 463,00')
    expect(product2.quantity).to eq 1
  end

  scenario 'must fill in freight cost and discount' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'perdigao@rotes.com', password: '12ff456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    profile3 = Profile.create!(full_name: 'Perdigão Antunes', birthday: '10/03/1982', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user3)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    total_quantity = 2
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')                                                
    purchased_product.andamento!
    product2.quantity = product2.quantity - total_quantity 

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    fill_in 'Frete', with: ''
    fill_in 'Desconto', with: ''
    travel_to Date.new(2004, 11, 24) do
      click_on 'Concluir venda'
    end

    expect(page).to have_content('Frete não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
    expect(page).not_to have_content('Venda concluída')
    expect(page).not_to have_content('24/11/2004')
    expect(page).not_to have_content('R$ 463,00')  
  end

  scenario 'freight cost and discount must be greater than or equal to 0' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user2 = User.create!(email: 'carol@rotes.com', password: '123456')
    user3 = User.create!(email: 'perdigao@rotes.com', password: '12ff456')
    department1 = Department.create!(name: 'RH')
    department2 = Department.create!(name: 'Vendas')
    profile1 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                               work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user1)
    profile2 = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                               work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Administração', 
                               department: department2, user: user2)
    profile3 = Profile.create!(full_name: 'Perdigão Antunes', birthday: '10/03/1982', 
                               work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                               department: department1, user: user3)
    product_category2 = ProductCategory.create!(name: 'Esporte e lazer')
    product_subcategory2 = ProductSubcategory.create!(name: 'Bola', product_category: product_category2)
    product_condition2 = ProductCondition.create!(name: 'Usado')
    product2 = Product.new(name: 'Adidas Fevernova - Bola da copa de 2002', product_subcategory: product_subcategory2, 
                           description: 'Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.', price: '240', 
                           product_condition: product_condition2, quantity: '3', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!
    total_quantity = 2
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')                                                
    purchased_product.andamento!
    product2.quantity = product2.quantity - total_quantity 

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    fill_in 'Frete', with: '-5'
    fill_in 'Desconto', with: '-20'
    travel_to Date.new(2004, 11, 24) do
      click_on 'Concluir venda'
    end

    expect(page).to have_content('Frete deve ser maior ou igual a 0')
    expect(page).to have_content('Desconto deve ser maior ou igual a 0')
    expect(page).not_to have_content('Venda concluída')
    expect(page).not_to have_content('24/11/2004')
    expect(page).not_to have_content('R$ 463,00')  
  end
end