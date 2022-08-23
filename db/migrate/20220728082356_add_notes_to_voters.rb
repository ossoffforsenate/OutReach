class AddNotesToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :notes, :string
  end
end
