require 'rails_helper'

feature 'User view profiles' do
  scenario 'must be logged in to view sellers' do
    visit root_path

    expect(page).not_to have_content('Vendedores')
  end

  scenario 'must be logged in to view sellers list' do
    visit profiles_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be logged in to view seller details' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                    department: department, user: user, work_address: 'Rua Evans, 30')

    visit profile_path(profile)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and view list of same company profiles' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    Company.create!(name: 'Pirts', cnpj: '47.621.468/0001-67', domain: 'pirts.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    user2 = User.create!(email: 'pedro@rotes.com', password: '123056')
    user3 = User.create!(email: 'fernanda@rotes.com', password: '120006')
    user4 = User.create!(email: 'ana@pirts.com', password: '291740')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Joaquim Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                    department: department, user: user, work_address: 'Rua Evans, 30')
    Profile.create!(full_name: 'Pedro Pires', birthday: '10/02/1993', position: 'Assistente', 
                    department: department, user: user2, work_address: 'Rua Evans, 30')
    Profile.create!(full_name: 'Bruno Fernandes', chosen_name: 'Fernanda Fernandes', birthday: '10/02/1990', 
                    position: 'Gerente', sector: 'Desenvolvimento', department: department, user: user3, 
                    work_address: 'Rua Nilza, 70')                
    Profile.create!(full_name: 'Ana Jost', birthday: '09/12/1993', position: 'Gerente', 
                    department: department, user: user4, work_address: 'Rua Montes Áureos, 10')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendedores'

    expect(page).to have_content('Pedro Pires')
    expect(page).to have_content('pedro@rotes.com')
    expect(page).to have_content('Rua Evans, 30')
    expect(page).to have_content('Fernanda Fernandes')
    expect(page).to have_content('fernanda@rotes.com')
    expect(page).to have_content('Rua Nilza, 70')
    expect(page).not_to have_content('Joaquim Pires')
    expect(page).not_to have_content('joaquim@rotes.com')
    expect(page).not_to have_content('Ana Jost')
    expect(page).not_to have_content('ana@pirts.com')
    expect(page).not_to have_content('Rua Montes Áureos, 10')
  end

  scenario 'and view other profile details' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    user2 = User.create!(email: 'pedro@rotes.com', password: '123056')
    user3 = User.create!(email: 'fernanda@rotes.com', password: '120006')
    department = Department.create!(name: 'RH')
    Profile.create!(full_name: 'Joaquim Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                    department: department, user: user, work_address: 'Rua Evans, 30')
    Profile.create!(full_name: 'Pedro Pires', birthday: '10/02/1993', position: 'Assistente', 
                    department: department, user: user2, work_address: 'Rua Evans, 30')
    Profile.create!(full_name: 'Bruno Fernandes', chosen_name: 'Fernanda Fernandes', birthday: '10/02/1990', 
                    position: 'Gerente', sector: 'Desenvolvimento', department: department, user: user3, 
                    work_address: 'Rua Nilza, 70')                
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendedores'
    click_on 'Fernanda Fernandes'

    expect(page).to have_content('Fernanda Fernandes')
    expect(page).to have_content('Bruno Fernandes')
    expect(page).to have_content('10/02/1990')
    expect(page).to have_content('Gerente')
    expect(page).to have_content('Desenvolvimento')
    expect(page).to have_content('RH')
    expect(page).to have_content('fernanda@rotes.com')
    expect(page).to have_content('Rua Nilza, 70')
    expect(page).not_to have_content('Pedro Pires')
    expect(page).not_to have_content('10/02/1993')
    expect(page).not_to have_content('Assistente')
    expect(page).not_to have_content('pedro@rotes.com')
    expect(page).not_to have_content('Rua Evans, 30')
  end

  scenario 'and nothing is registered' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'joaquim@rotes.com', password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Vendedores'

    expect(page).to have_content('Nenhum perfil registrado')
  end
end