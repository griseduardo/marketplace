require 'rails_helper'

feature 'User send valid question in product' do
  scenario 'and question_message cannot be blank' do
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
                           product_condition: product_condition2, quantity: '2', profile: profile2)
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova1.jpg')), filename: 'fevernova1.jpg')
    product2.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'fevernova2.jpg')), filename: 'fevernova2.jpg')
    product2.save!

    login_as(user1, scope: :user)
    visit root_path
    click_on 'Adidas Fevernova - Bola da copa de 2002'
    click_on 'Enviar pergunta'

    expect(Question.count).to eq 0
    expect(page).to have_content('Faltou preencher pergunta', count: 1)
  end
end