class Measurement < ApplicationRecord
  belongs_to :elderly_user
  enum measurement_type: [:temperature, :preasure, :weight, :glucose, :pulsations], _prefix: true
end
