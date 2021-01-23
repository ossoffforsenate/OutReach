class AddUniqueToUsersPhone < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :phone_number
    add_index :users, :phone_number, unique: true
  end
end
