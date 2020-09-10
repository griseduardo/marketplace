require 'rails_helper'

feature 'User edit own product' do
  scenario 'must be logged in to view product' do
    visit root_path

    expect(page).not_to have_link('Meus produtos')
  end

  scenario 'must be logged in to edit product' do
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

    visit edit_product_path(product)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be the owner to find edit link' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    user2 = User.create!(email: 'felipe@rotes.com', password: '123rd6')
    profile = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                              work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user)
    profile2 = Profile.create!(full_name: 'Felipe Paredes', birthday: '10/02/1993', 
                              work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user2)
    product_category = ProductCategory.create!(name: 'Comida')
    product_subcategory = ProductSubcategory.create!(name: 'Bolo', product_category: product_category)
    product_condition = ProductCondition.create!(name: 'Novo')
    product = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory, 
                          description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition, 
                          quantity: '1', profile: profile)
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product.save!
    
    login_as(user2, scope: :user)
    visit root_path
    click_on 'Bolo de brigadeiro'

    expect(page).not_to have_link('Editar')
  end

  scenario 'successfully' do
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
    fill_in 'Preço', with: '260'
    select 'Fresco', from: 'Condição'
    fill_in 'Quantidade', with: '0'
    attach_file 'Imagens', [Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg'), Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')] 
    click_on 'Enviar'
  
    expect(page).to have_content('Editado com sucesso!')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('RH')
    expect(page).to have_content('Bolo de brigadeiro com morango')
    expect(page).to have_content('Pedaço de bolo')
    expect(page).to have_content('Bolo de brigadeiro com morango em pedaços')
    expect(page).to have_content('R$ 260,00')
    expect(page).to have_content('Fresco')
    expect(page).to have_content('0')
    expect(page).to have_content('Indisponível')
  end

  scenario 'and does not change anything' do
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
    click_on 'Enviar'
  
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('RH')
    expect(page).to have_content('Bolo de brigadeiro')
    expect(page).to have_content('Bolo')
    expect(page).to have_content('Bolo de brigadeiro com bastante recheio')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('Novo')
    expect(page).to have_content('1')
    expect(page).to have_content('Disponível')
  end
end