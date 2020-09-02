require 'rails_helper'

describe Profile, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      profile = Profile.new

      profile.valid?

      expect(profile.errors[:full_name]).to include('não pode ficar em branco')
      expect(profile.errors[:birthday]).to include('não pode ficar em branco')
      expect(profile.errors[:work_address]).to include('não pode ficar em branco')
      expect(profile.errors[:position]).to include('não pode ficar em branco')
      expect(profile.errors[:department]).to include('é obrigatório(a)')
    end
  end
end
