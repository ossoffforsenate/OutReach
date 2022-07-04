# frozen_string_literal: true
require 'csv'

class ReachCsvLoader
  VOTER_FILE_LOCATION = ENV['REACH_VOTER_FILE']

  def load_voters
    to_upsert = []

    ::CSV.foreach(VOTER_FILE_LOCATION, headers: true) do |row|
      address_line_1 = row["Address Line 1"]
      address_line_2 = row["Address Line 2"]

      address = "#{address_line_1}#{address_line_2 ? ", #{address_line_2}" : ""}"

      to_upsert << {
        reach_id: row["Reach ID"],
        sos_id: row["State File ID"],
        voter_data_status: row["Source Tag"] == "Voter" ? :reach_match : :unmatched,
        voter_registration_status: row["Source Tag"] == "Voter" ? :registered_in_district : nil,
        first_name: row["First Name"],
        prefix: row["Prefix"],
        last_name: row["Last Name"],
        middle_name: row["Middle Name"],
        suffix: row["Suffix"],
        phone_country_code: row["Phone Country Code"],
        primary_phone_number: row["Phone Number"],
        email: row["Email"],
        voting_street_address: address,
        voting_zip: row["Zip"],
        voting_state: row["State"],
        voting_city: row["City"],
        support_score: row["Support Score"],
        created_at: Time.now,
        updated_at: Time.now,
      }
    end

    !Voter.upsert_all(to_upsert, unique_by: nil)
  end
end
