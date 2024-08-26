# app/controllers/analytics_data_controller.rb
class AnalyticsDataController < ApplicationController
  # GET /analytics_data
  def index
    @analytics_data = current_user.analytics_data
    render json: @analytics_data
  end
end
