class AddReferenceToElderly < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :elderly_user, index: true
  end
end
