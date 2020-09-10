class PurchasedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :profile
  has_many :negotiations

  validates :total_quantity, :initial_value, presence: true
  validates :discount, :freight_cost, presence: true, if: :presence_condition
  validates_numericality_of :total_quantity, greater_than: 0
  validates_numericality_of :freight_cost, :discount, greater_than_or_equal_to: 0, if: :concluida?

  validate :total_quantity_must_be_greather_than_or_equal_to_disponible_quantity, on: :create

  enum status: { iniciada: 0, recusada: 10, andamento: 20, finalizada: 30, cancelada: 40}

  def initial_price
    self.initial_value = total_quantity * product.price
  end

  def calculate_value
    return if discount.blank? || freight_cost.blank?
    self.final_value = initial_value + freight_cost - discount
  end

  def concluida?
    discount.present? && freight_cost.present?
  end

  def presence_condition
    end_date.present? && status == 'andamento' 
  end

  private

  def total_quantity_must_be_greather_than_or_equal_to_disponible_quantity
    return if total_quantity.blank?
    return if total_quantity <= product.quantity
    errors.add(:total_quantity, 'deve ser menor que quantidade disponível')
  end
end
