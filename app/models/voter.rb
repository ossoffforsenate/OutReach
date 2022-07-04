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

  VOTE_STATUS_TEXT = {
    "ballot mailed" => "Needs to Return Ballot",
    "ballot received" => "Has Voted!",
  }.freeze

  def last_call_status_display
    CALL_STATUS_TEXT.fetch(last_call_status.to_sym, "Unknown")
  end

  def polling_place_display
    nil # TODO: implement voting location search if possible
  end

  def voting_status_display
    VOTE_STATUS_TEXT.fetch(voting_status.downcase, voting_status) || "Unknown"
  end

  def phone_number_display
    PhoneNumberUtils.display(primary_phone_number)
  end

  def display_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
