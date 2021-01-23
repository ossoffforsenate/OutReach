class AddIndexesForAllQueries < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, [:relationship, :user_id]
    add_index :relationships, :user_id
    add_index :relationships, :voter_sos_id

    add_index :voters, :household_id
    add_index :voters, [:sos_id, :household_id]

    add_index :users, :phone_number
  end
end
