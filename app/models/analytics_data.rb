# app/models/analytics_data.rb
class AnalyticsData < ApplicationRecord
  belongs_to :user

  validates :data_type, :data, presence: true

  def analytics_summary
    {
      data_type: data_type,
      data: data
    }
  end
end
