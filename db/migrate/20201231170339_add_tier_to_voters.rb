class AddTierToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :tier, :integer, null: false, default: 3
  end
end
