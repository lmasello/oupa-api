class AuthenticationDecodedToken < HashWithIndifferentAccess
  def expired?
    return false unless self[:expiration_date].present?
    Time.zone.now.to_i > self[:expiration_date]
  end

  def valid_verification_code?
    return true unless self[:verification_code].present?
    User.find(self[:user_id]).verification_code == self[:verification_code]
  end

  def warning_expiration_date_reached?
    return false unless self[:warning_expiration_date].present?
    Time.zone.now.to_i >= self[:warning_expiration_date]
  end

  def valid_renew_id?(renew_id)
    return true unless self[:renew_id].present? && renew_id.present?
    renew_id == self[:renew_id]
  end

  def able_to_renew?
    return true unless self[:expiration_date].present? && self[:maximum_useful_date].present?
    self[:expiration_date] < self[:maximum_useful_date]
  end
end
