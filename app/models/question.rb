class Question < ApplicationRecord
  belongs_to :product
  belongs_to :profile

  validates :question_message, presence: true
end
