class CreateVoters < ActiveRecord::Migration[6.0]
  def change
    create_table :voters, id: false do |t|
      t.integer :myv_van_id
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.integer :age
      t.string :gender
      t.string :primary_phone_number
      t.string :voting_street_address
      t.string :voting_city
      t.string :voting_zip
      t.string :support_score
      t.string :vote_plan
      t.string :vol_ask
      t.string :voting_status
      t.boolean :voted_general
      t.float :gotv_score
      t.integer :voting_address_id
      t.integer :household_id
      t.integer :sos_id, primary_key: true, null: false, unique: true

      t.timestamps
    end
  end
end
