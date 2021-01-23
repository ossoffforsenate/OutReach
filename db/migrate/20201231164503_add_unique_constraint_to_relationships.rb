class AddUniqueConstraintToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, [:user_id, :voter_sos_id], unique: true
  end
end
