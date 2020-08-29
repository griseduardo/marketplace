class ProductCategory < ApplicationRecord
  has_many :product_subcategories

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
