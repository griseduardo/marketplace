class Negotiation < ApplicationRecord
  belongs_to :profile
  belongs_to :purchased_product

  validates :negotiation_message, presence: true
end
