# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user
  has_many :resumes, dependent: :destroy

  validates :name, presence: true
  validates :contact_details, :education, :experience, :skills, presence: true

  def full_profile
    {
      name: name,
      contact_details: contact_details,
      education: education,
      experience: experience,
      skills: skills
    }
  end
end
