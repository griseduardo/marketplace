class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  
  before_validation :add_company

  private
    def add_company
      self.company = Company.find_by domain: email.split('@').last
    end
end