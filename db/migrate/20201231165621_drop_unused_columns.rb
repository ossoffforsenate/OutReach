class DropUnusedColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :canvassed_by, :string
    remove_column :users, :campaign, :string
    remove_column :users, :canvasser_vanid, :integer

    remove_column :voters, :myv_van_id, :integer
    remove_column :voters, :vol_ask, :string
    remove_column :voters, :voting_address_id, :integer
  end
end
