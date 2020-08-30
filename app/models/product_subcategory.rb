class ProductSubcategory < ApplicationRecord
  belongs_to :product_category

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }, unless: :equal_others?

  def equal_others?
    name.to_s.capitalize == 'Outros'
  end
end
