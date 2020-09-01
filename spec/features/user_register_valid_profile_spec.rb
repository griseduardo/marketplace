require 'rails_helper'

feature 'User register valid profile' do
  scenario 'must be logged in to view profile' do
    visit root_path

    expect(page).not_to have_link('Profile')
  end

  scenario 'and attributes cannot be blank, except chosen_name and sector' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    click_on 'Cadastrar'

    expect(Profile.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 4)
    expect(page).to have_content('é obrigatório', count: 1)
  end

  scenario 'and just one time is allowed for user' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'pedro', birthday: '10/03/1993', position: 'Auxiliar', 
                    department: department, user: user, work_address: 'Rua Evans, 30')
    
    login_as(user, scope: :user)
    visit new_profile_path
    fill_in 'Nome completo', with: 'Edgar Gomes'
    fill_in 'Nome social', with: 'Carol Gomes'
    fill_in 'Data de nascimento', with: '10/08/1990'
    fill_in 'Endereço de trabalho', with: 'Avenida Paulista, 170'
    fill_in 'Cargo', with: 'Auxiliar'
    fill_in 'Setor', with: 'Treinamento e desenvolvimento'
    select 'RH', from: 'Departamento'
    click_on 'Cadastrar'

    expect(Profile.count).to eq 1
    expect(page).to have_content('já está em uso', count: 1)
  end
end