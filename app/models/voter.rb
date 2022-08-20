# frozen_string_literal: true
require 'json'

class Voter < ApplicationRecord
  self.primary_key = :reach_id

  has_many :relationships, foreign_key: :voter_reach_id
  has_many :users, through: :relationships

  enum last_call_status: [ :not_yet_called, :should_call_again, :do_not_call ]
  enum voter_data_status: [:reach_match, :manual_match, :unmatched]
  enum voter_registration_status: [:registered_in_district, :pending_registration_in_district, :registered_in_state, :registered_out_of_state, :unregistered]

  CALL_STATUS_TEXT = {
    not_yet_called: "Not contacted",
    should_call_again: "Should contact again",
    do_not_call: "Don't contact again",
  }.freeze

  VOTER_REGISTRATION_STATUS_TEXT = {
    registered_in_district: "Registered in PA HD 82",
    pending_registration_in_district: "Pending registration in PA HD 82",
    registered_in_state: "Registered in PA",
    registereted_out_of_state: "Registered out of state",
    unregistered: "Unregistered"
  }.freeze

  DEFAULT_SURVEY_STRUCTURE = 
  {
    "issues" => {
      "cares_climate" => "0",
      "cares_gun_control" => "0",
      "cares_healthcare" => "0",
      "cares_college_affordability" => "0",
      "cares_reproductive_rights" => "0",
      "cares_transparency" => "0",
      "cares_marijuana" => "0",
      "cares_gender_equity" => "0",
      "cares_pay_gap" => "0",
      "cares_sexual_assault" => "0"
    },
    "plan_to_vote_before" => "0",
    "plan_to_vote_for_paul" => "0"
  }.freeze

  def last_call_status_display
    CALL_STATUS_TEXT.fetch(last_call_status.to_sym, "Unknown")
  end

  def safe_survey_data
    survey_data.present? ? JSON.parse(survey_data) : DEFAULT_SURVEY_STRUCTURE
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
