# app/middleware/token_blacklist_middleware.rb

class TokenBlacklistMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    token = extract_token(request)
    if token
      if token_blacklisted?(token)
        return [401, { 'Content-Type' => 'application/json' }, [{ error: 'Token is blacklisted' }.to_json]]
      elsif invalid_token?(token)
        return [401, { 'Content-Type' => 'application/json' }, [{ error: 'Invalid token' }.to_json]]
      end
    end

    @app.call(env)
  end

  private

  def extract_token(request)
    auth_header = request.get_header('HTTP_AUTHORIZATION')
    auth_header&.split(' ')&.last
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
