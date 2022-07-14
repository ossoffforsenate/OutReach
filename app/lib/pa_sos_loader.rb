# frozen_string_literal: true

# Load data from the tab-separated PA secretary of state data
class PaSosLoader
  VOTER_FILE_LOCATION = ENV['PA_SOS_VOTER_FILE']

  def load_voters
    to_upsert = []

    # PA SOS data is a tab-separated file with the format
    # StateVoterID/unknown/LastName/FirstName/MiddleName/Suffix/Gender/DOB/DateRegistered/ActiveorInactive/Not Sure what this date is--might be updated reg?/PartyRegistration/House Number/Apt/StreetName/City/State/Zip/
    data = File.readlines(VOTER_FILE_LOCATION)
    data.each do |line|
      sos_id, _, last_name, first_name, middle_name, _suffix, gender, _dob,\
        _date_registered, _is_active, _, _party, house_number, \
        apartment_number, street_name, _, _, city, state, zip = \
        line.split("\t").
        map { |col_data| col_data.start_with?("\"") ? col_data[1...-1] : col_data } # strip surrounding quotes

      voting_street_address = "#{house_number} #{street_name}"
      if apartment_number.present?
        voting_street_address += " ##{apartment_number}"
      end

      voter_data = {
          sos_id: sos_id,
          first_name: first_name,
          last_name: last_name,
          middle_name: middle_name,
          gender: gender,
          voting_city: city,
          voting_zip: zip,
          voting_street_address: voting_street_address,
      }
      to_upsert << voter_data
    end

    Voter.upsert_all(to_upsert, unique_by: nil)
  end
end
