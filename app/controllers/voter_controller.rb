# frozen_string_literal: true
require 'json'

class VoterController < ApplicationController
  SKIP_WARN_THRESHOLDS = Set.new(Rails.configuration.rewards.skip_warnings)

  before_action :authorize_and_set_contact, only: [:show, :update]
  before_action :migrate_voters_seen, only: [:next, :show]

  def show
    current_user.log_voter!(params[:id].to_s)
    @voter = Voter.find(params[:id])
  end

  def next
    call_list = current_user.call_list
    voters_seen = current_user.seen_voters
    next_voter = call_list.find { |v| !voters_seen[v.reach_id] }

    if params[:skip] && voter
      record_in_reach(Rails.configuration.reach.responses[:skip])
      current_user.log_skip!

      if SKIP_WARN_THRESHOLDS.include?(current_user.skips_logged)
        flash[:warning] = "You're skipping more calls than most Reachers. " \
          "It's really imporant we talk to everyone, consider re-contacting the skipped calls!"
      end
    end

    if next_voter.nil? && call_list.any?
      flash[:success] = "Completed all calls, re-starting from beginning of the list!"
      current_user.set_voters!({})
      next_voter = call_list.first
    end

    if next_voter.nil?
      flash[:success] = "No voters to call, thanks for your help to elect Jon!"
      redirect_to root_path
    else
      redirect_to next_voter
    end
  end

  def update
    if voter_params[:last_call_status]
      current_user.log_call!
      # TODO: un-comment this if we want to sync responses to the Reach API
      # record_in_reach(Rails.configuration.reach.responses.to_h.fetch(params[:last_call_status].to_sym))
    end

    if voter.update(voter_params)
      # if last_call_status is what changed, we want to redirect to the next
      # voter. Else we just want to reload the previous voter
      if voter_params[:last_call_status]
        flash[:success] = 'Contact status updated, check out the next voter to call!'
        redirect_to voter_next_path
      else
        flash[:success] = 'Changes saved successfully'
      end
    else
      flash[:danger] = 'Error recording changes, try again!'
      redirect_to @voter
    end
  end

  def update_survey
    survey_data_from_form = 
    {
        "issues" => {
          "cares_climate" => params[:cares_about_climate].present? ? "1" : "0",
          "cares_gun_control" => params[:cares_about_gun_control].present? ? "1" : "0",
          "cares_healthcare" => params[:cares_about_healthcare].present? ? "1" : "0",
          "cares_college_affordability" => params[:cares_about_college_affordability].present? ? "1" : "0",
          "cares_reproductive_rights" => params[:cares_about_reproductive_rights].present? ? "1" : "0",
          "cares_transparency" => params[:cares_about_transparency].present? ? "1" : "0",
          "cares_marijuana" => params[:cares_about_marijuana].present? ? "1" : "0",
          "cares_gender_equity" => params[:cares_about_gender_equity].present? ? "1" : "0",
          "cares_pay_gap" => params[:cares_about_gender_pay_gap].present? ? "1" : "0",
          "cares_sexual_assault" => params[:cares_about_sexual_assault].present? ? "1" : "0"
        },
        "plan_to_vote_before" => params[:planned_to_vote_before].present? ? "1" : "0",
        "plan_to_vote_for_paul" => params[:planned_to_vote_for_paul].present? ? "1" : "0"
    }

    voter = Voter.find(params[:id])
    voter.update!(survey_data: survey_data_from_form.to_json)
  end

  private

  def voter_params
    params.require(:voter).permit(:email, :last_call_status, :voter_registration_status, :notes, :party_id)
  end

  def migrate_voters_seen
    if current_user && session[:voters_seen].is_a?(Hash)
      current_user.set_voters!(session[:voters_seen])
      session[:voters_seen] = nil
    end
  end

  def voter
    @voter ||= Voter.find(params[:id])
  end

  def authorize_and_set_contact
    return unless voter.relationships.where(user: current_user).empty?
    flash[:danger] = "You don't have access to that voter's details"
    redirect_back(fallback_location: root_path)
  end

  def record_in_reach(choice_id)
    REACH_CLIENT.record_response("#{Rails.configuration.reach.id_prefix}_#{voter.sos_id.to_s.rjust(8, "0")}",
                                 current_user.id,
                                 Rails.configuration.reach.question_id,
                                 choice_id)
  end
end
