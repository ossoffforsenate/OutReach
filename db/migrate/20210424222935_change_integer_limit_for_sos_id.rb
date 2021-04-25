class ChangeIntegerLimitForSosId < ActiveRecord::Migration[6.0]
  def change
    change_column :voters, :sos_id, :integer, limit: 8
  end
end
