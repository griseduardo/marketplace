require 'rails_helper'

feature 'User view product categories' do
  scenario 'successfully' do
    ProductCategory.create!(name: 'Eletrodomésticos')
    ProductCategory.create!(name: 'Esporte e lazer')
  
    visit root_path
  
    expect(page).to have_content('Eletrodomésticos')
    expect(page).to have_content('Esporte e lazer')
  end

  scenario 'and no product categories are created' do
    visit root_path

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end
end  