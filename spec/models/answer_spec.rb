require 'rails_helper'

describe Answer, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      answer = Answer.new

      answer.valid?

      expect(answer.errors[:answer_message]).to include('não pode ficar em branco')
      expect(answer.errors[:question]).to include('é obrigatório(a)')
    end
  end
end
