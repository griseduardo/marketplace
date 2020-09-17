require 'rails_helper'

feature 'User edit profile' do
  scenario 'must be logged in to view profile' do
    visit root_path

    expect(page).not_to have_link('Profile')
  end

  scenario 'must be logged in to edit own profile' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                              department: department, user: user, work_address: 'Rua Evans, 30')
    
    visit edit_profile_path(profile)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'must be current user profile to edit' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user1 = User.create!(email: 'carol@rotes.com', password: '123456')
    user2 = User.create!(email: 'eduardo@rotes.com', password: '12ab56')
    department = Department.create!(name: 'RH')
    profile1 = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                               department: department, user: user1, work_address: 'Rua Evans, 30')
    profile2 = Profile.create!(full_name: 'Eduardo Gomes', birthday: '10/03/1992', position: 'Assistente', 
                               department: department, user: user2, work_address: 'Rua Evans, 30')
    
    login_as(user1, scope: :user)
    visit edit_profile_path(profile2)

    expect(current_path).to eq root_path
    expect(page).to have_content('Somente pode editar seu próprio perfil!')
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    Department.create!(name: 'Vendas')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                              department: department, user: user, work_address: 'Rua Evans, 30')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: 'Carol Pires Santos'
    fill_in 'Nome social', with: 'Pedro Santos'
    fill_in 'Data de nascimento', with: '10/08/1993'
    fill_in 'Endereço de trabalho', with: 'Avenida Paulista, 170'
    fill_in 'Cargo', with: 'Assistente'
    fill_in 'Setor', with: 'Treinamento e desenvolvimento'
    select 'Vendas', from: 'Departamento'
    click_on 'Atualizar'
    profile.reload
    
    expect(page).to have_content('Atualizado com sucesso!')
    expect(user.email).to eq('carol@rotes.com')
    expect(profile.full_name).to eq('Carol Pires Santos')
    expect(profile.chosen_name).to eq('Pedro Santos')
    expect(profile.birthday).to eq('10/08/1993'.to_date)
    expect(profile.work_address).to eq('Avenida Paulista, 170')
    expect(profile.position).to eq('Assistente')
    expect(profile.sector).to eq('Treinamento e desenvolvimento')
    expect(profile.department.name).to eq('Vendas')
  end

  scenario 'and does not change anything' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                              department: department, user: user, work_address: 'Rua Evans, 30')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    click_on 'Atualizar'
    profile.reload
    
    expect(user.email).to eq('carol@rotes.com')
    expect(profile.full_name).to eq('Carol Pires')
    expect(profile.birthday).to eq('10/03/1993'.to_date)
    expect(profile.work_address).to eq('Rua Evans, 30')
    expect(profile.position).to eq('Auxiliar')
    expect(profile.department.name).to eq('RH')
  end
end