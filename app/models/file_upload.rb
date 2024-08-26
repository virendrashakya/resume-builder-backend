# app/models/file_upload.rb
class FileUpload < ApplicationRecord
  belongs_to :user

  validates :file, :file_type, presence: true

  def file_info
    {
      file: file,
      file_type: file_type,
      metadata: metadata
    }
  end
end
