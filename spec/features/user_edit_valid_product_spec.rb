require 'rails_helper'

feature 'User edit valid product' do
  scenario 'must be logged in to view product' do
    visit root_path

    expect(page).not_to have_link('Meus produtos')
  end
  
  scenario 'and attributes cannot be blank' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                              work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user)
    product_category = ProductCategory.create!(name: 'Comida')
    product_subcategory = ProductSubcategory.create!(name: 'Bolo', product_category: product_category)
    product_condition = ProductCondition.create!(name: 'Novo')
    product = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory, 
                          description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition, 
                          quantity: '1', profile: profile)
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product.save!
  
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
    click_on 'Editar'
    fill_in 'Nome', with: '' 
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    fill_in 'Quantidade', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  scenario 'and price cannot be less or equal zero, quantity cannot be negative' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                              work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user)
    product_category = ProductCategory.create!(name: 'Comida')
    product_subcategory = ProductSubcategory.create!(name: 'Bolo', product_category: product_category)
    product_condition = ProductCondition.create!(name: 'Novo')
    ProductCategory.create!(name: 'Doces')
    ProductSubcategory.create!(name: 'Pedaço de bolo', product_category: product_category)
    ProductCondition.create!(name: 'Fresco')
    product = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory, 
                          description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition, 
                          quantity: '1', profile: profile)
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product.save!
  
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
    click_on 'Editar'
    fill_in 'Nome', with: 'Bolo de brigadeiro com morango'
    select 'Pedaço de bolo', from: 'Subcategoria' 
    fill_in 'Descrição', with: 'Bolo de brigadeiro com morango em pedaços'
    fill_in 'Preço', with: '-100'
    select 'Fresco', from: 'Condição'
    fill_in 'Quantidade', with: '-5'
    attach_file 'Imagens', [Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg'), Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')] 
    click_on 'Enviar'

    expect(page).to have_content('deve ser maior que 0', count: 1)
    expect(page).to have_content('deve ser maior ou igual a 0', count: 1)
  end
end