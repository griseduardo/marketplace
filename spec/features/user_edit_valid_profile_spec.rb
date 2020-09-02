require 'rails_helper'

feature 'User edit valid profile' do
  scenario 'must be logged in to view profile' do
    visit root_path

    expect(page).not_to have_link('Profile')
  end

  scenario 'and attributes cannot be blank, except chosen_name and sector' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    user = User.create!(email: 'carol@rotes.com', password: '123456')
    department = Department.create!(name: 'RH')
    profile = Profile.create!(full_name: 'Carol Pires', birthday: '10/03/1993', position: 'Auxiliar', 
                              department: department, user: user, work_address: 'Rua Evans, 30')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Meu perfil'
    fill_in 'Nome completo', with: ''
    fill_in 'Nome social', with: ''
    fill_in 'Data de nascimento', with: ''
    fill_in 'Endereço de trabalho', with: ''
    fill_in 'Cargo', with: ''
    fill_in 'Setor', with: ''
    click_on 'Atualizar'

    expect(Profile.count).to eq 1
    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end