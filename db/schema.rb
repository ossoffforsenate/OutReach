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

ActiveRecord::Schema.define(version: 2021_04_24_224753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "relationships", force: :cascade do |t|
    t.bigint "voter_sos_id"
    t.string "user_id"
    t.string "relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["relationship", "user_id"], name: "index_relationships_on_relationship_and_user_id"
    t.index ["user_id", "voter_sos_id"], name: "index_relationships_on_user_id_and_voter_sos_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
    t.index ["voter_sos_id"], name: "index_relationships_on_voter_sos_id"
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
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  create_table "voters", primary_key: "sos_id", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.integer "age"
    t.string "gender"
    t.string "primary_phone_number"
    t.string "voting_street_address"
    t.string "voting_city"
    t.string "voting_zip"
    t.string "support_score"
    t.string "vote_plan"
    t.string "voting_status"
    t.boolean "voted_general"
    t.float "gotv_score"
    t.integer "household_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "last_call_status", default: 0, null: false
    t.integer "tier", default: 3, null: false
    t.integer "tier_raw"
    t.boolean "voted"
    t.string "vote_location_name"
    t.string "vote_location_city"
    t.string "vote_location_zip"
    t.string "vote_location_hours"
    t.string "vote_location_address"
    t.boolean "needs_a_ride", default: false
    t.index ["household_id", "tier", "last_call_status"], name: "index_voters_on_household_id_and_tier_and_last_call_status"
    t.index ["household_id"], name: "index_voters_on_household_id"
    t.index ["last_call_status"], name: "index_voters_on_last_call_status"
    t.index ["sos_id", "household_id"], name: "index_voters_on_sos_id_and_household_id"
    t.index ["tier", "last_call_status"], name: "index_voters_on_tier_and_last_call_status"
    t.index ["tier"], name: "index_voters_on_tier"
  end

end
