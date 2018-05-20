class AuthenticationManager
  NOT_AUTH_CODE = 1
  TOKEN_EXPIRED_CODE = 2
  SUCCESS_CODE = 3

  attr_reader :headers
  delegate :warning_expiration_date_reached?, to: :decoded_auth_token
  delegate :able_to_renew?, to: :decoded_auth_token
  delegate :valid_renew_id?, to: :decoded_auth_token

  def initialize(headers)
    @headers = headers
  end

  def current_user
    return nil unless decoded_auth_token.present?
    # decoded_auth_token.first[0].to_sym was needed after implementing sti on users
    @current_user ||= User.find_by(id: decoded_auth_token[decoded_auth_token.first[0].to_sym])
  end

  def authenticate_request
    return auth_token_expired_response if auth_token_expired?
    return not_authenticated_response if current_user.nil?
    return invalid_verification_code_response if auth_token_invalid_verification_code?
    return expiration_warning_response if auth_token_warning_expiration_date_reached?
  end

  def authenticate_admin_request
    return auth_token_expired_response if auth_token_expired?
    return not_authenticated_response if current_user.nil?
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthenticationTokenManager.decode(authorization_header)
  end

  def renew_access_token(decoded_auth_token)
    AuthenticableEntity.renew_access_token(decoded_auth_token)
  end

  private

  def auth_token_expired_response
    { body: { error: 'Auth token is expired' }, code: TOKEN_EXPIRED_CODE }
  end

  def not_authenticated_response
    { body: { error: 'Not Authorized' }, code: NOT_AUTH_CODE }
  end

  def invalid_verification_code_response
    { body: { error: 'Not Authorized' }, code: NOT_AUTH_CODE }
  end

  def expiration_warning_response
    {
      body: {}, code: SUCCESS_CODE, headers: {
        'X-Expiration-Warning' => decoded_auth_token[:expiration_date].to_s
      }
    }
  end

  def auth_token_invalid_verification_code?
    decoded_auth_token && current_user.present? && !decoded_auth_token.valid_verification_code?
  end

  def auth_token_warning_expiration_date_reached?
    decoded_auth_token&.warning_expiration_date_reached?
  end

  def auth_token_expired?
    decoded_auth_token&.expired?
  end

  def authorization_header
    return @authorization_header if defined? @authorization_header
    return nil unless headers['Authorization'].present?
    @authorization_header = headers['Authorization'].split(' ').last
  end
end
