class ProductSubcategory < ApplicationRecord
  belongs_to :product_category
  has_many :products

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }, unless: :equal_others?

  def equal_others?
    name.to_s.capitalize == 'Outros'
  end
end
