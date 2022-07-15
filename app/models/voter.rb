# frozen_string_literal: true
class Voter < ApplicationRecord
  self.primary_key = :reach_id

  has_many :relationships, foreign_key: :voter_reach_id
  has_many :users, through: :relationships

  enum last_call_status: [ :not_yet_called, :should_call_again, :do_not_call ]
  enum voter_data_status: [:reach_match, :manual_match, :unmatched]
  enum voter_registration_status: [:registered_in_district, :registered_in_state, :registereted_out_of_state, :unregistered]

  CALL_STATUS_TEXT = {
    not_yet_called: "Not called",
    should_call_again: "Should call again",
    do_not_call: "Don't call back",
  }.freeze

  VOTER_REGISTRATION_STATUS_TEXT = {
    registered_in_district: "Registered in PA HD 82",
    registered_in_state: "Registered in PA",
    registereted_out_of_state: "Registered out of state",
    unregistered: "Unregistered"
  }.freeze

  def last_call_status_display
    CALL_STATUS_TEXT.fetch(last_call_status.to_sym, "Unknown")
  end

  def polling_place_display
    nil # TODO: implement voting location search if possible
  end

  def voter_registration_status_display
    return "Unknown" unless voter_registration_status
    VOTER_REGISTRATION_STATUS_TEXT[voter_registration_status.to_sym]
  end

  def phone_number_display
    PhoneNumberUtils.display(primary_phone_number)
  end

  def display_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
