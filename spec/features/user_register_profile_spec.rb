require 'rails_helper'

feature 'User register profile' do
  scenario 'must be logged in to view profile' do
    visit root_path

    expect(page).not_to have_link('Profile')
  end

  scenario 'must be logged in to register new profile' do
    visit new_profile_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    Department.create!(name: 'RH')
    user = User.create!(email: 'carol@rotes.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: 'Edgar Gomes'
    fill_in 'Nome social', with: 'Carol Gomes'
    fill_in 'Data de nascimento', with: '10/08/1990'
    fill_in 'Endereço de trabalho', with: 'Avenida Paulista, 170'
    fill_in 'Cargo', with: 'Auxiliar'
    fill_in 'Setor', with: 'Treinamento e desenvolvimento'
    select 'RH', from: 'Departamento'
    click_on 'Cadastrar'

    expect(page).to have_content('Cadastrado com sucesso!')
    expect(page).to have_content('carol@rotes.com')
    expect(page).to have_content('Edgar Gomes')
    expect(page).to have_content('Carol Gomes')
    expect(page).to have_content('10/08/1990')
    expect(page).to have_content('Avenida Paulista, 170')
    expect(page).to have_content('Auxiliar')
    expect(page).to have_content('Treinamento e desenvolvimento')
    expect(page).to have_content('RH')
  end

  scenario 'must fill in all fields, except chosen_name and sector' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    expect(page).to have_content('Endereço de trabalho não pode ficar em branco')
    expect(page).to have_content('Cargo não pode ficar em branco')
    expect(page).to have_content('Departamento é obrigatório(a)')
    expect(page).not_to have_content('Nome social não pode ficar em branco')
    expect(page).not_to have_content('Setor não pode ficar em branco')
  end

  scenario 'but no more than one time' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
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

    expect(page).to have_content('Usuário já está em uso')
  end
end