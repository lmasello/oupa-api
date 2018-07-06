class ElderlyUser < User
  has_many :assistant_users
  has_many :personal_medicine_reminder
  has_many :measurements
end
