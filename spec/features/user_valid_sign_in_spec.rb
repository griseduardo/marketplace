require 'rails_helper'

feature 'User valid sign in' do
  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Entrar'
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválidos.', count: 1)
  end

  scenario 'and attributes do not match an user' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    User.create!(email: 'astolfo@rotes.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'edgar@rotes.com'
    fill_in 'Senha', with: '038291'
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválidos.', count: 1)
  end
end