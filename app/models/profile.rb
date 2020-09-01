class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :department

  validates :full_name, :birthday, :work_address, :position,  presence: true
  validates_uniqueness_of :user_id
end
