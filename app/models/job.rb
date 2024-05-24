class Job < ApplicationRecord
  belongs_to :recruiter
  has_many :submissions

  validates :title, :description, presence: true

  default_scope { where(active: true) }
end
