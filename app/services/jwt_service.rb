# app/services/jwt_service.rb
require 'jwt'

class JwtService
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM = 'HS256'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY, ALGORITHM)[0]
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end
