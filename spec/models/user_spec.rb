require 'rails_helper'

describe User, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new

      user.valid?

      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')
      expect(user.errors[:company]).to include('é obrigatório(a)')
    end

    it 'password minimum length must be 6' do
      user = User.new(password: '1233')

      user.valid?

      expect(user.errors[:password]).to include('é muito curto (mínimo: 6 caracteres)')
    end

    it 'password must relate to a registered company domain' do
      Company.create!(name: 'Lorc', cnpj: '41.235.049/0001-00', domain: 'lorc.com')
      user = User.new(email: 'joaquim@rotes.com', password: '123456')

      user.valid?

      expect(user.errors[:company]).to include('é obrigatório(a)')
    end
  end
end
