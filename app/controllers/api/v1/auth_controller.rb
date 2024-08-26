# app/controllers/api/v1/auth_controller.rb

module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user_from_token!, only: [:signup, :login]

      # Sign up a new user
      def signup
        user = User.new(user_params)
        if user.save
          render json: { id: user.id, email: user.email, name: user.name, token: encode_token(user.id) }, status: :created
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
        token = extract_token(request)
        if token
          if token_blacklisted?(token)
            render json: { error: 'Token is already blacklisted' }, status: :bad_request
          elsif invalid_token?(token)
            render json: { error: 'Invalid token' }, status: :bad_request
          else
            decoded_token = JwtService.decode(token)
            jti = decoded_token['jti']
            TokenBlacklist.create!(jti: jti, exp: Time.at(decoded_token['exp']))
            head :no_content
          end
        else
          render json: { error: 'No token provided' }, status: :bad_request
        end
      end

      private

      def extract_token(request)
        auth_header = request.headers['Authorization']
        auth_header.split(' ').last if auth_header.present?
      end

      def user_params
        params.require(:user).permit(:email, :password, :username)
      end

      def encode_token(user_id)
        # Encode user_id into JWT token with a JTI (JWT ID) for blacklisting
        payload = { user_id: user_id, jti: SecureRandom.uuid, exp: 24.hours.from_now.to_i }
        JwtService.encode(payload)
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
    end
  end
end