class AddIndexesForCallListQueries < ActiveRecord::Migration[6.0]
  def change
    add_index :voters, [:tier, :last_call_status]
    add_index :voters, :tier
    add_index :voters, :last_call_status
    add_index :voters, [:household_id, :tier, :last_call_status]
  end
end
