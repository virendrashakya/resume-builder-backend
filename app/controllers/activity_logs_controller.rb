# app/controllers/activity_logs_controller.rb
class ActivityLogsController < ApplicationController
  # GET /activity_logs
  def index
    @activity_logs = current_user.activity_logs
    render json: @activity_logs
  end
end
