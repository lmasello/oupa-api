class AddTakenToPersonalMedicineReminder < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_medicine_reminders, :taken, :boolean, default: false
  end
end
