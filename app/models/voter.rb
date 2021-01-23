# frozen_string_literal: true

class Voter < ApplicationRecord
  self.primary_key = :sos_id

  has_many :relationships, foreign_key: :voter_sos_id
  has_many :users, through: :relationships

  enum last_call_status: [ :not_yet_called, :should_call_again, :do_not_call ]

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
    if vote_location_address.present?
      display = ""
      display += "#{vote_location_name.titleize} | " if vote_location_name.present?
      display += vote_location_address.titleize
      display += ", #{vote_location_city}" if vote_location_city.present?
      display += " (#{vote_location_hours})" if vote_location_hours.present?
    else
      nil
    end
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

  def household_members
    Voter.where(household_id: household_id).where.not(sos_id: sos_id)
  end
end
