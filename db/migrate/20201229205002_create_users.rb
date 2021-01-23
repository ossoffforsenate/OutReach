class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true, null: false, unique: true
      t.string :first_name
      t.string :last_name
      t.string :canvassed_by
      t.string :email_address
      t.string :phone_number, null: false
      t.string :campaign
      t.integer :canvasser_vanid
      t.string :rmm_email
      t.integer :role

      t.timestamps
    end
  end
end
