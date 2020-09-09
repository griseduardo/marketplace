require 'rails_helper'

feature 'User view purchased product' do
  scenario 'and seller is notified to confirm the sell' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user2, scope: :user)
    visit root_path

    expect(page).to have_content('Venda aguardando confirmação:')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
  end

  scenario 'and buyer is notified about the pending confirmation' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user1, scope: :user)
    visit root_path

    expect(page).to have_content('Compra aguardando confirmação do vendedor:')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
  end

  scenario 'and seller visualize list of sells that need confirmation' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'

    expect(page).to have_content('Vendas aguardando confirmação')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
  end

  scenario 'and buyer visualize list of purchase that need confirmation' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'

    expect(page).to have_content('Compras aguardando confirmação do vendedor')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
  end

  scenario 'and seller visualize specific sell that need confirmation' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Aprovar venda')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('Vendas')
    expect(page).to have_content('Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.')
    expect(page).to have_content('Esporte e lazer')
    expect(page).to have_content('Bola')
    expect(page).to have_content('Usado')
    expect(body).to include('fevernova1.jpg')
    expect(body).to include('fevernova2.jpg')
  end

  scenario 'and buyer visualize specific purchase that need confirmation' do
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
    total_quantity = 2
    PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                             initial_value: total_quantity * product2.price, start_date: '10/04/2030')

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Aguardando aprovação do vendedor')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('Vendas')
    expect(page).to have_content('Bola de futebol oficial da Copa do Mundo FIFA de 2002 feita pela Adidas.')
    expect(page).to have_content('Esporte e lazer')
    expect(page).to have_content('Bola')
    expect(page).to have_content('Usado')
    expect(body).to include('fevernova1.jpg')
    expect(body).to include('fevernova2.jpg')
  end
end