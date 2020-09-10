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

  scenario 'and seller visualize list of refused sells' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.recusada!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'

    expect(page).to have_content('Vendas recusadas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(purchased_product.status).to eq 'recusada'
  end

  scenario 'and buyer visualize list of refused purchases' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.recusada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'

    expect(page).to have_content('Compras recusadas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(purchased_product.status).to eq 'recusada'
  end

  scenario 'and seller visualize specific refused sell historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030', end_date: '11/04/2030')
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    purchased_product.recusada!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Venda recusada')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'recusada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end

  scenario 'and buyer visualize specific refused purchase historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030', end_date: '11/04/2030')
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    purchased_product.recusada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Compra recusada')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'recusada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end

  scenario 'and seller is notified about sell negotiation in progress' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.andamento!

    login_as(user2, scope: :user)
    visit root_path

    expect(page).to have_content('Venda em negociação:')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
  end

  scenario 'and buyer is notified about purchase negotiation in progress' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.andamento!

    login_as(user1, scope: :user)
    visit root_path

    expect(page).to have_content('Compra em negociação:')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
  end

  scenario 'and seller visualize list of negotiation sells' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.andamento!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'

    expect(page).to have_content('Vendas em negociação')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(purchased_product.status).to eq 'andamento'
  end

  scenario 'and buyer visualize list of negotiation purchases' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.andamento!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'

    expect(page).to have_content('Compras em negociação')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(purchased_product.status).to eq 'andamento'
  end

  scenario 'and seller visualize specific negotiation sell' do
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

    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Negociação')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
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
    expect(purchased_product.status).to eq 'andamento'
  end

  scenario 'and buyer visualize specific negotiation purchase' do
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

    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Negociação')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
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
    expect(purchased_product.status).to eq 'andamento'
  end

  scenario 'and seller visualize list of canceled sells' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.cancelada!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'

    expect(page).to have_content('Vendas canceladas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(purchased_product.status).to eq 'cancelada'
  end

  scenario 'and buyer visualize list of canceled purchases' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030')
    purchased_product.cancelada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'

    expect(page).to have_content('Compras canceladas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(purchased_product.status).to eq 'cancelada'
  end

  scenario 'and seller visualize specific canceled sell historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030', end_date: '11/04/2030')
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')
    purchased_product.cancelada!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Venda cancelada')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'cancelada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end

  scenario 'and buyer visualize specific canceled purchase historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030', end_date: '11/04/2030')
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')
    purchased_product.cancelada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Compra cancelada')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'cancelada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end

  scenario 'and seller visualize list of concluded sells' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030',
                                                 end_date: '12/04/2030', freight_cost: '10', discount: '30', final_value: '460')
    purchased_product.finalizada!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'

    expect(page).to have_content('Vendas concluídas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(purchased_product.status).to eq 'finalizada'
  end

  scenario 'and buyer visualize list of concluded purchases' do
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
    purchased_product = PurchasedProduct.create!(product: product2, profile: profile1, total_quantity: '2', 
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030',
                                                 end_date: '12/04/2030', freight_cost: '10', discount: '30', final_value: '460')    
    purchased_product.finalizada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'

    expect(page).to have_content('Compras concluídas')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Carol Gomes')
    expect(purchased_product.status).to eq 'finalizada'
  end

  scenario 'and seller visualize specific concluded sell historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030',
                                                 end_date: '12/04/2030', freight_cost: '10', discount: '30', final_value: '460')    
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')
    purchased_product.finalizada!

    login_as(user2, scope: :user)
    visit root_path
    click_on 'Vendas'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Venda concluída')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('R$ 460,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('12/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'finalizada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end

  scenario 'and buyer visualize specific concluded purchase historic' do
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
                                                 initial_value: total_quantity * product2.price, start_date: '10/04/2030',
                                                 end_date: '12/04/2030', freight_cost: '10', discount: '30', final_value: '460')    
    question1 = Question.create!(product: product2, profile: profile1, question_message: 'A bola tem alguma marca?')
    answer1 = Answer.create!(answer_message: 'Nenhuma marca presente', question: question1)
    question2 = Question.create!(product: product2, profile: profile3, question_message: 'A bola foi usada na copa?')
    answer2 = Answer.create!(answer_message: 'Somente na copa do meu bairro', question: question2)
    Negotiation.create!(profile: profile2, purchased_product: purchased_product, negotiation_message: 'Qual endereço de entrega?')
    purchased_product.finalizada!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Compras'
    click_on 'Adidas Fevernova - Bola da copa de 2002'

    expect(page).to have_content('Compra concluída')
    expect(page).to have_content('Adidas Fevernova - Bola da copa de 2002')
    expect(page).to have_content('Eduardo Rodrigues')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 480,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('R$ 460,00')
    expect(page).to have_content('10/04/2030')
    expect(page).to have_content('12/04/2030')
    expect(page).to have_content('Qual endereço de entrega?')
    expect(page).to have_content('A bola tem alguma marca?')
    expect(page).to have_content('Nenhuma marca presente')
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
    expect(purchased_product.status).to eq 'finalizada'
    expect(page).not_to have_content('A bola foi usada na copa?')
    expect(page).not_to have_content('Somente na copa do meu bairro')
  end
end