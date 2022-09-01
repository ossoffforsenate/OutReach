# frozen_string_literal: true
require 'json'

class AdminController < ApplicationController
  def show
    current_user.log_voter!(params[:id].to_s)
    @voter = Voter.find(params[:id])
  end

  def show_dashboard
    @users = User.all
    @user_set = User.first(3)
    @voters = Voter.all

    @confirmed_registrations = @voters.select {|v| v.voter_registration_status_display == "Registered in PA HD 82"}.count
    @pending_registrations = @voters.select {|v| v.voter_registration_status_display == "Pending registration in PA HD 82"}.count
    @unregistered = @voters.select {|v| v.voter_registration_status_display != "Pending registration in PA HD 82" && v.voter_registration_status_display != "Registered in PA HD 82"}.count
    @total_unofficial_registrations = @pending_registrations + @confirmed_registrations

    cares_climate = {"Climate" => @voters.select { |v| v.safe_survey_data["issues"]["cares_climate"] == "1"}.count}
    cares_gun_control = {"Gun control" => @voters.select { |v| v.safe_survey_data["issues"]["cares_gun_control"] == "1"}.count}
    cares_healthcare = {"Healthcare" => @voters.select { |v| v.safe_survey_data["issues"]["cares_healthcare"] == "1"}.count}
    cares_college_affordability = {"College affordability" => @voters.select { |v| v.safe_survey_data["issues"]["cares_about_college_affordability"] == "1"}.count}
    cares_reproductive_rights = {"Reproductive rights" => @voters.select { |v| v.safe_survey_data["issues"]["cares_reproductive_rights"] == "1"}.count}
    cares_transparency = {"Accountability/transparency of government officials" => @voters.select { |v| v.safe_survey_data["issues"]["cares_transparency"] == "1"}.count}
    cares_marijuana = {"Marijuana legalization" => @voters.select { |v| v.safe_survey_data["issues"]["cares_marijuana"] == "1"}.count}
    cares_gender_equity = {"Gender equity/Title IX" => @voters.select { |v| v.safe_survey_data["issues"]["cares_gender_equity"] == "1"}.count}
    cares_pay_gap = {"Gender pay gap" => @voters.select { |v| v.safe_survey_data["issues"]["cares_pay_gap"] == "1"}.count}
    cares_sexual_assault = {"Sexual assault/violence" => @voters.select { |v| v.safe_survey_data["issues"]["cares_sexual_assault"] == "1"}.count}
    plan_to_vote_before = @voters.select { |v| v.safe_survey_data["plan_to_vote_before"] == "1"}.count
    plan_to_vote_for_paul = @voters.select { |v| v.safe_survey_data["plan_to_vote_for_paul"] == "1"}.count

    survey_data = [cares_climate, cares_gun_control, cares_healthcare, cares_college_affordability, cares_reproductive_rights, cares_transparency, cares_marijuana, cares_gender_equity, cares_sexual_assault]
    @sorted_survey_data = survey_data.sort_by { |issue| issue.values.first }.reverse
  end
end
