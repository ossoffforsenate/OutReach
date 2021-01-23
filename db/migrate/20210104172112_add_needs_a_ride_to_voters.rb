class AddNeedsARideToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :needs_a_ride, :boolean, default: false
  end
end
