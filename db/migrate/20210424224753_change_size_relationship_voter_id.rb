class ChangeSizeRelationshipVoterId < ActiveRecord::Migration[6.0]
  def change
    change_column :relationships, :voter_sos_id, :integer, limit: 8
  end
end
