class AddReferenceToDoctor < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :doctor_user, index: true
  end
end
