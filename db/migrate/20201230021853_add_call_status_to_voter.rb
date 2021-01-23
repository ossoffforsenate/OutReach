class AddCallStatusToVoter < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :last_call_status, :integer, null: false, default: 0
  end
end
