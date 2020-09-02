class Company < ApplicationRecord
  has_many :users
  has_many :profiles, through: :users

  validates :name, :cnpj, :domain, presence: true
  validates :cnpj, :domain, uniqueness: { case_sensitive: false }
  validates :cnpj, length: { is: 18 }
  validates :cnpj, format: { with: /[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\/?[0-9]{4}\-?[0-9]{2}/,
                   message: 'formato aceito: **.***.***/****-**' }

  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    return if cnpj.blank?
    return if CNPJ.valid?(cnpj, strict: true)

    errors.add(:cnpj, :invalid)
  end
end
