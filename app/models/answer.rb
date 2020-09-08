class Answer < ApplicationRecord
  belongs_to :question

  validates :answer_message, presence: true
  validates_uniqueness_of :question_id
end
