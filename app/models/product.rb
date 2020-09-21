class Product < ApplicationRecord
  belongs_to :product_subcategory
  belongs_to :product_condition
  belongs_to :profile
  has_many :questions
  has_many :answers
  has_many :purchased_products
  has_many_attached :images

  enum status: { available: 0, unavailable:10, suspended: 20 }
  
  validates :name, :description, :price, :quantity, :images, presence: true
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  before_validation :add_status

  private

  def add_status
    if quantity.present? && status.blank? 
      if quantity >= 1 
        self.status = :available
      else
        self.status = :unavailable
      end
    end
  end
end
