class AuthenticationTokenManager
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      AuthenticationDecodedToken.new(payload)
    rescue
      nil
    end
  end
end
