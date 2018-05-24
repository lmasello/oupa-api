class AddElderlyUserToPersonalMedicineReminder < ActiveRecord::Migration[5.1]
  def change
    add_reference :personal_medicine_reminders, :elderly_user, index: true
  end
end
