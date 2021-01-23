class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :voter_sos_id
      t.string :user_id
      t.string :relationship

      t.timestamps
    end
  end
end
