# Re-settings the voter table fields completely to accound for the new design
class UpdateVotersFields < ActiveRecord::Migration[6.0]
  def change
    drop_table :voters
    drop_table :relationships

    create_table :voters, id: false do |t|
      # main ID fields
      t.string :reach_id, primary_key: true, null: false, unique: true
      t.string :sos_id, unique: true

      # basic info
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :suffix
      t.string :prefix
      t.integer :age
      t.string :gender
      t.string :email

      # contact info
      t.string :phone_country_code
      t.string :primary_phone_number
      t.string :voting_street_address
      t.string :voting_state
      t.string :voting_city
      t.string :voting_zip

      # voting info
      t.string :party_id
      t.integer :voter_registration_status
      t.json :voting_history
      t.string :voting_status
      t.integer :voting_address_id
      t.string :vote_plan

      t.integer :voter_data_status
      t.integer :last_call_status, default: 0, null: false

      t.integer :support_score
      t.integer :household_id

      t.timestamps
    end

    create_table :relationships do |t|
      t.string :voter_reach_id
      t.string :user_id
      t.string :relationship

      t.timestamps
    end
  end
end
