class AddNewColumnsToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :tier_raw, :integer
    add_column :voters, :voted, :boolean
    add_column :voters, :vote_location_name, :string
    add_column :voters, :vote_location_city, :string
    add_column :voters, :vote_location_zip, :string
    add_column :voters, :vote_location_hours, :string
    add_column :voters, :vote_location_address, :string
  end
end
