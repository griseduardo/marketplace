require 'rails_helper'

describe Company, type: :model do
  context 'validation' do
    it 'name, cnpj, domain cannot be blank' do
      company = Company.new

      company.valid?

      expect(company.errors[:name]).to include('não pode ficar em branco')
      expect(company.errors[:cnpj]).to include('não pode ficar em branco')
      expect(company.errors[:domain]).to include('não pode ficar em branco')
      expect(company.errors[:website]).not_to include('não pode ficar em branco')
    end

    it 'cnpj and domain must be unique' do
      Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
      company = Company.new(cnpj: '96.672.638/0001-48', domain: 'rotes.com')
      
      company.valid?

      expect(company.errors[:cnpj]).to include('já está em uso')
      expect(company.errors[:domain]).to include('já está em uso')
    end

    it 'domain uniqueness is not case sensitive' do
      Company.create!(name: 'Rotes', cnpj: '96.672.638/0001-48', domain: 'rotes.com')
      company = Company.new(domain: 'ROTES.COM')

      company.valid?

      expect(company.errors[:domain]).to include('já está em uso')
    end

    it 'cnpj length must be 18' do
      company = Company.new(cnpj: '963.672.638/0001-48')

      company.valid?

      expect(company.errors[:cnpj]).to include('não possui o tamanho esperado (18 caracteres)')
    end

    it 'cnpj includes invalid character(s)' do
      company = Company.new(cnpj: '96$672.638/0001-48')

      company.valid?

      expect(company.errors[:cnpj]).to include('não é válido')
    end

    it 'cnpj character(s) in invalid position' do
      company = Company.new(cnpj: '96.6.72638/0001-48')

      company.valid?

      expect(company.errors[:cnpj]).to include('formato aceito: **.***.***/****-**')
    end

    it 'cnpj does not exist' do
      company = Company.new(cnpj: '96.672.638/0000-99')

      company.valid?

      expect(company.errors[:cnpj]).to include('não é válido')
    end
  end
end