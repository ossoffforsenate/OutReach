class AddUniqueIndexOnUserIdReachIdToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, [:user_id, :voter_reach_id], unique: true
  end
end
