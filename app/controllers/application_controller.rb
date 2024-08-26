# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!
  # before_action :authenticate_user!
  # Rescue from unauthorized access and handle it with JSON response
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_user_from_token!
    token = extract_token(request)

    if token
      if token_blacklisted?(token) || invalid_token?(token)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      else
        # Optionally, set the current_user if needed
        # decoded_token = JWT.decode(token, 'your_secret_key', true, { algorithm: 'HS256' })
        # @current_user = User.find(decoded_token[0]['user_id'])
      end
    else
      render json: { error: 'No token provided' }, status: :unauthorized
    end
  end

  def extract_token(request)
    auth_header = request.headers['Authorization']
    auth_header.split(' ').last if auth_header.present?
  end

  def token_blacklisted?(token)
    begin
      decoded_token = JwtService.decode(token)
      jti = decoded_token['jti']
      TokenBlacklist.exists?(jti: jti)
    rescue JWT::DecodeError
      true
    end
  end

  def invalid_token?(token)
    begin
      JwtService.decode(token)
      false
    rescue JWT::DecodeError
      true
    end
  end

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end

  def route_not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
