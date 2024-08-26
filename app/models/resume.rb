# app/models/resume.rb
class Resume < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  belongs_to :template
  has_many :sections, dependent: :destroy

  validates :title, presence: true
  validates :data, presence: true

  def generate_pdf
    PdfGenerator.generate(self)
  end

  def resume_data
    {
      title: title,
      profile: profile.full_profile,
      sections: sections.order(:position).map(&:content)
    }
  end
end
