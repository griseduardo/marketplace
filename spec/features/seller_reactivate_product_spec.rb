require 'rails_helper'

feature 'Seller reactivate product' do
  scenario 'must be logged in to reactivate product' do
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
    product.suspenso!
    product.save!

    visit product_path(product)

    expect(current_path).to eq new_user_session_path
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
    product = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory, 
                          description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition, 
                          quantity: '1', profile: profile)
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product.suspenso!
    product.save!

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
    click_on 'Reativar'
    product.reload
  
    expect(product.status).to eq 'disponível'
  end

  scenario 'must be suspended to reactivate product' do
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
    product.status = :disponível
    product.save!

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
  
    expect(page).not_to have_link 'Reativar'
  end
end