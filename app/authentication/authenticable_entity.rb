class AuthenticableEntity
  MAXIMUM_USEFUL_DATES         = 30.days
  EXPIRATION_DATES             = 2.days
  WARNING_EXPIRATION_DATES     = 5.hours
  RENEW_ID_CHARACTERS          = 32
  VERIFICATION_CODE_CHARACTERS = 64

  class << self
    def generate_access_token(entity)
      renew_id = Devise.friendly_token(RENEW_ID_CHARACTERS)
      payload = { "#{entity.class.name.underscore}_id" => entity.id }
      payload = add_secure_attrs(payload, renew_id, entity)
      { token: AuthenticationTokenManager.encode(payload), renew_id: renew_id }
    end

    def renew_access_token(decoded_auth_token)
      payload = decoded_auth_token
      now = Time.zone.now
      payload[:expiration_date] = expiration_date(now)
      payload[:warning_expiration_date] = warning_expiration_date(now)
      AuthenticationTokenManager.encode(payload)
    end

    def verification_code
      Devise.friendly_token(VERIFICATION_CODE_CHARACTERS)
    end

    private

    def add_secure_attrs(payload, renew_id, client)
      now = Time.zone.now
      payload.merge!(
        verification_code: client.verification_code,
        renew_id: renew_id,
        maximum_useful_date: maximum_useful_date(now),
        expiration_date: expiration_date(now),
        warning_expiration_date: warning_expiration_date(now)
      )
    end

    def maximum_useful_date(now)
      (now + MAXIMUM_USEFUL_DATES).to_i
    end

    def expiration_date(now)
      (now + EXPIRATION_DATES).to_i
    end

    def warning_expiration_date(now)
      (now + WARNING_EXPIRATION_DATES).to_i
    end
  end

  private_class_method :add_secure_attrs, :maximum_useful_date, :expiration_date,
                       :warning_expiration_date
end
