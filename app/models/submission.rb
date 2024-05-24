class Submission < ApplicationRecord
  belongs_to :job, optional: true
  validates :email, presence: true
  validate :unique_email_for_job

  private

  def unique_email_for_job
    if Submission.exists?(job_id: job_id, email: email)
      errors.add(:email, "has already been submitted for this job")
    end
  end
end
