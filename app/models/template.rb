# app/models/template.rb
class Template < ApplicationRecord
  has_many :resumes, dependent: :destroy

  validates :name, presence: true
  validates :description, :content, presence: true

  def template_info
    {
      name: name,
      description: description,
      preview_image: preview_image,
      content: content
    }
  end
end
