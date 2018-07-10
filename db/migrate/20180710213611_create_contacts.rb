class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts, force: :cascade do |t|
      t.string :name, null: false
      t.string :phone_number
      t.string :picture
      t.bigint "elderly_user_id"
      t.index ["elderly_user_id"], name: "index_contacts_on_elderly_user_id"
      t.timestamps
    end
  end
end
