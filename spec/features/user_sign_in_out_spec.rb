require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    Company.create!(name: 'Lorc', cnpj: '41.235.049/0001-00', domain: 'lorc.com')
    User.create!(email: 'astolfo@rotes.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'astolfo@rotes.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(page).to have_content('Rotes')
    expect(page).not_to have_content('Lorc')
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_link('Sair')
  end

  scenario 'must fill in all fields' do
    visit root_path
    click_on 'Entrar'
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválidos.')
  end

  scenario 'and sign out' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    User.create!(email: 'astolfo@rotes.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'astolfo@rotes.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content('Rotes')
    expect(page).not_to have_content('Login efetuado com sucesso.')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end
end