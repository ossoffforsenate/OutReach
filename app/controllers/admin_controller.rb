# frozen_string_literal: true
require 'json'

class AdminController < ApplicationController
  def show
    current_user.log_voter!(params[:id].to_s)
    @voter = Voter.find(params[:id])
  end

  def show_dashboard
    @users = User.all
    @voters = Voter.all

    @confirmed_registrations = @voters.select {|v| v.voter_registration_status_display == "Registered in PA HD 82"}.count
    @pending_registrations = @voters.select {|v| v.voter_registration_status_display == "Pending registration in PA HD 82"}.count
    @unregistered = @voters.select {|v| v.voter_registration_status_display != "Pending registration in PA HD 82" && v.voter_registration_status_display != "Registered in PA HD 82"}.count
    @total_unofficial_registrations = @pending_registrations + @confirmed_registrations
  end
end
