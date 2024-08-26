# app/models/activity_log.rb
class ActivityLog < ApplicationRecord
  belongs_to :user

  validates :activity_type, :activity_data, presence: true

  def log_activity(activity_type, data)
    create(activity_type: activity_type, activity_data: data)
  end
end
