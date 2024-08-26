# app/controllers/api/v1/sessions_controller.rb
class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: { token: token, user: UserSerializer.new(user) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
