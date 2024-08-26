# app/controllers/api/v1/auth_controller.rb

module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate_user!, only: [:logout]

      # Sign up a new user
      def signup
        user = User.new(user_params)
        if user.save
          render json: { id: user.id, email: user.email, username: user.username, token: encode_token(user.id) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # Log in an existing user
      def login
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          render json: { id: user.id, email: user.email, username: user.username, token: encode_token(user.id) }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      # Log out a user (invalidate token)
      def logout
        # Invalidate the token on the client-side
        render json: { message: 'Logged out successfully' }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :username)
      end

      def encode_token(user_id)
        # Encode user_id into JWT token (you might use a library like JWT)
        payload = { user_id: user_id }
        JwtService.encode(payload)
      end
    end
  end
end
