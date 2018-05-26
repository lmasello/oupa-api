class CreatePersonalMedicineReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_medicine_reminders do |t|
      t.string :name
      t.text :notes
      t.datetime :date
      t.datetime :time

      t.timestamps
    end
  end
end
