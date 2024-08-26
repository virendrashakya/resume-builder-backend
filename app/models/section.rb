# app/models/section.rb
class Section < ApplicationRecord
  belongs_to :resume

  validates :title, :content, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def section_info
    {
      title: title,
      content: content,
      position: position
    }
  end
end
