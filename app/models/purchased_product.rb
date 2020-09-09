class PurchasedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :profile

  validates :total_quantity, :initial_value, presence: true
  validates_numericality_of :total_quantity, greater_than: 0

  validate :total_quantity_must_be_greather_than_or_equal_to_disponible_quantity, on: :create

  enum status: { iniciada: 0, recusada: 10, andamento: 20, finalizada: 30, cancelada: 40}

  def initial_price
    self.initial_value = total_quantity * product.price
  end

  private

  def total_quantity_must_be_greather_than_or_equal_to_disponible_quantity
    return if total_quantity.blank?
    return if total_quantity <= product.quantity
    errors.add(:total_quantity, 'deve ser menor que quantidade disponível')
  end
end
