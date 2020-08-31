require 'rails_helper'

feature 'User valid sign up' do
  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Criar conta'
    click_on 'Cadastrar'

    expect(User.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_content('é obrigatório(a)', count: 1)
  end

  scenario 'and password must be equal password confirmation' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'joaquim@rotes.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '990003'
    click_on 'Cadastrar'

    expect(User.count).to eq 0
    expect(page).to have_content('Confirmação de senha não é igual a Senha', count: 1)
  end

  scenario 'and password minimun length must be 6' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'joaquim@rotes.com'
    fill_in 'Senha', with: '12345'
    fill_in 'Confirmação de senha', with: '12345'
    click_on 'Cadastrar'

    expect(User.count).to eq 0
    expect(page).to have_content('é muito curto (mínimo: 6 caracteres)', count: 1)
  end

  scenario 'and email domain must relate to a registered company domain' do
    Company.create!(name: 'Lorc', cnpj: '41.235.049/0001-00', domain: 'lorc.com')

    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'joaquim@rotes.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Cadastrar'

    expect(User.count).to eq 0
    expect(page).to have_content('é obrigatório(a)', count: 1)
  end
end