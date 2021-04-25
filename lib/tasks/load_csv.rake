require "csv"

desc "Load voter data from CSV"
task load_voters: :environment do
  voter_file = ENV['VOTER_FILE']
  raise "Need `VOTER_FILE`" unless voter_file

  to_upsert = []
  now = Time.now

  CSV.foreach(voter_file, headers: true) do |row|
    address = row["Address Line 1"]

    if row["Address Line 2"]
      address = "#{address} #{row["Address Line 2"]}"
    end

    to_upsert << {
      created_at: now,
      updated_at: now,
      last_name: row["Last Name"],
      first_name: row["First Name"],
      middle_name: row["Middle Name"],
      primary_phone_number: row["Phone"],
      voting_street_address: address,
      voting_city: row["City"],
      voting_zip: row["Zip"],
      sos_id: row["Reach ID"],
    }
  end

  Voter.upsert_all(to_upsert)
end

desc "Load user data from CSV"
task load_users: :environment do
  user_file = ENV['USER_FILE']
  raise "Need `USER_FILE`" unless user_file

  to_upsert = []
  now = Time.now

  CSV.foreach(user_file, headers: true) do |row|
    to_upsert << {
      created_at: now,
      updated_at: now,
      last_name: row["Last Name"],
      first_name: row["First Name"],
      email_address: row["Email"],
      id: row["User ID"],
      phone_number: row["Phone Number"],
    }
  end

  User.upsert_all(to_upsert)
end

desc "Load relationship data from CSV"
task load_relationships: :environment do
  rel_file = ENV['RELATIONSHIPS_FILE']
  raise "Need `RELATIONSHIPS_FILE`" unless rel_file

  to_upsert = []
  now = Time.now

  CSV.foreach(rel_file, headers: true) do |row|
    to_upsert << {
      created_at: now,
      updated_at: now,
      voter_sos_id: row["Reach ID"],
      user_id: row["User ID"],
    }
  end

  Relationship.upsert_all(to_upsert, unique_by: [:user_id, :voter_sos_id])
end
