# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_23_040752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "relationships", force: :cascade do |t|
    t.string "voter_reach_id"
    t.string "user_id"
    t.string "relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "voter_reach_id"], name: "index_relationships_on_user_id_and_voter_reach_id", unique: true
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.string "phone_number", null: false
    t.string "rmm_email"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin"
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  create_table "voters", primary_key: "reach_id", id: :string, force: :cascade do |t|
    t.string "sos_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "suffix"
    t.string "prefix"
    t.integer "age"
    t.string "gender"
    t.string "email"
    t.string "phone_country_code"
    t.string "primary_phone_number"
    t.string "voting_street_address"
    t.string "voting_state"
    t.string "voting_city"
    t.string "voting_zip"
    t.string "party_id"
    t.integer "voter_registration_status"
    t.json "voting_history"
    t.string "voting_status"
    t.integer "voting_address_id"
    t.string "vote_plan"
    t.integer "voter_data_status"
    t.integer "last_call_status", default: 0, null: false
    t.integer "support_score"
    t.integer "household_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "notes"
    t.json "survey_data"
    t.string "vote_status"
  end

end
