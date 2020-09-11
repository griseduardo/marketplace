require 'rails_helper'

feature 'Seller suspend product sell' do
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
    product.save!
  
    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
    click_on 'Suspender'
    product.reload
  
    expect(product.status).to eq 'suspenso'
  end

  scenario 'must not have ongoing sells' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    user2 = User.create!(email: 'eduardo@rotes.com', password: '120456')
    user3 = User.create!(email: 'perdigao@rotes.com', password: '12ff456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Edgar Gomes', chosen_name: 'Carol Gomes', birthday: '10/08/1990', 
                              work_address: 'Avenida Paulista, 170', position: 'Auxiliar', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user)
    profile2 = Profile.create!(full_name: 'Eduardo Rodrigues', birthday: '10/03/1992', 
                              work_address: 'Avenida Paulista, 170', position: 'Assistente', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user2)
    profile3 = Profile.create!(full_name: 'Perdigão Antunes', birthday: '10/03/1982', 
                              work_address: 'Avenida Paulista, 170', position: 'Gerente', sector: 'Treinamento e desenvolvimento', 
                              department: department, user: user3)
    product_category = ProductCategory.create!(name: 'Comida')
    product_subcategory = ProductSubcategory.create!(name: 'Bolo', product_category: product_category)
    product_condition = ProductCondition.create!(name: 'Novo')
    product = Product.new(name: 'Bolo de brigadeiro', product_subcategory: product_subcategory, 
                          description: 'Bolo de brigadeiro com bastante recheio', price: '30', product_condition: product_condition, 
                          quantity: '10', profile: profile)
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro1.png')), filename: 'brigadeiro1.png')
    product.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'brigadeiro2.jpg')), filename: 'brigadeiro2.jpg')
    product.save!
    total_quantity = 1
    total_quantity2 = 3
    purchased_product = PurchasedProduct.create!(product: product, profile: profile2, total_quantity: total_quantity, 
                                                 initial_value: total_quantity * product.price, start_date: '10/04/2030')
    purchased_product2 = PurchasedProduct.create!(product: product, profile: profile3, total_quantity: total_quantity2, 
                                                  initial_value: total_quantity2 * product.price, start_date: '10/04/2030')                                                
    purchased_product.andamento!
    purchased_product2.finalizada!

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meus produtos'
    click_on 'Bolo de brigadeiro'
  
    expect(page).not_to have_content('Suspender')
  end
end