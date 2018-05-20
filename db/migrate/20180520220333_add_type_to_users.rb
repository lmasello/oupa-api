class AddTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string, default: "ElderlyUser"
  end
end
