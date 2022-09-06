class AddVoteStatusToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :vote_status, :string
  end
end
