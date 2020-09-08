class Question < ApplicationRecord
  belongs_to :product
  belongs_to :profile
  has_one :answer

  validates :question_message, presence: true
end
