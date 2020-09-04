class Product < ApplicationRecord
  belongs_to :product_subcategory
  belongs_to :product_condition
  belongs_to :profile
  has_many_attached :images
  
  validates :name, :description, :price, :quantity, :images, presence: true
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :quantity, greater_than_or_equal_to: 0
end
