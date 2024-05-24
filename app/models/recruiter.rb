class Recruiter < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  has_many :jobs
end
