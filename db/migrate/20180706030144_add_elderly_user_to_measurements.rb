class AddElderlyUserToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_reference :measurements, :elderly_user, index: true
  end
end
