require 'rails_helper'

describe Question, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      question = Question.new

      question.valid?

      expect(question.errors[:question_message]).to include('não pode ficar em branco')
      expect(question.errors[:profile]).to include('é obrigatório(a)')
      expect(question.errors[:product]).to include('é obrigatório(a)')
    end
  end
end
