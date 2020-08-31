require 'rails_helper'

feature 'User sign up' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Criar conta')
  end

  scenario 'successfully' do
    Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
    Company.create!(name: 'Lorc', cnpj: '41.235.049/0001-00', domain: 'lorc.com')

    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'joaquim@rotes.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content 'Rotes'
    expect(page).not_to have_content 'Lorc'
    expect(page).to have_content 'Você realizou seu registro com sucesso.'
    expect(page).to have_link 'Sair'
  end

  scenario 'must fill in all fields' do
    visit root_path
    click_on 'Criar conta'
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível salvar usuário: 3 erros.'
    expect(page).to have_content 'Email não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'Empresa é obrigatório(a)'
  end
end