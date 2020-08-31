require 'rails_helper'

describe Department, type: :model do
  it 'name cannot be blank' do
    department = Department.new

    department.valid?

    expect(department.errors[:name]).to include('não pode ficar em branco')
  end

  it 'name must be unique' do
    Department.create!(name: 'RH')
    department = Department.new(name: 'RH')

    department.valid?

    expect(department.errors[:name]).to include('já está em uso')
  end

  it 'name uniqueness is not case sensitive' do
    Department.create!(name: 'RH')
    department = Department.new(name: 'Rh')

    department.valid?

    expect(department.errors[:name]).to include('já está em uso')
  end
end
