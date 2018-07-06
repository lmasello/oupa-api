class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.integer :measurement_type, default: 0, null: false
      t.text :notes
      t.float :value, null: false
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
