# frozen_string_literal: true

class VoterController < ApplicationController
  SKIP_WARN_THRESHOLDS = Set.new(Rails.configuration.rewards.skip_warnings)
  SUCCESS_THRESHOLDS   = Set.new(Rails.configuration.rewards.videos.keys)

  before_action :authorize_and_set_contact, only: [:show, :update]
  before_action :migrate_voters_seen, only: [:next, :show]

  def show
    current_user.log_voter!(params[:id].to_s)
    @voter = Voter.find(params[:id])
  end

  def next
    call_list = current_user.call_list
    voters_seen = current_user.seen_voters
    next_voter = call_list.find { |v| !voters_seen[v.sos_id.to_s] }

    if params[:skip] && voter
      record_in_reach(Rails.configuration.reach.responses.skip)
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
    if params[:last_call_status]
      current_user.log_call!
      if voter.update(last_call_status: params[:last_call_status])
        record_in_reach(Rails.configuration.responses.to_h.fetch(params[:last_call_status].to_s))
        calls_logged = current_user.calls_logged
        if Rails.configuration.rewards.videos.key?(calls_logged.to_s)
          flash[:success] = Rails.configuration.rewards.messages.success
          flash[:confetti] = true
          flash[:video] = REWARD_VIDEOS[calls_logged]
        elsif calls_logged == 1
          flash[:success] = Rails.configuration.rewards.messages.first
          flash[:confetti] = true
        else
          flash[:success] = 'Call status updated, check out the next voter to call!'
        end

        redirect_to voter_next_path
      else
        flash[:danger] = 'Error updating call status, try clicking again!'
        redirect_to voter_next_path
      end
    elsif params[:is_needs_a_ride_form]
      needs_a_ride = params[:needs_a_ride] == "1"
      record_in_reach(Rails.configuration.reach.responses.needs_a_ride) if needs_a_ride
      voter.update(needs_a_ride: needs_a_ride)
    end
  end

  private

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
    same_household_voter = voter.
      household_members.
      where(sos_id: current_user.relationships.select(:voter_sos_id)).
      first

    if same_household_voter
      @same_household_voter = same_household_voter
    else
      flash[:danger] = "You don't have access to that voter's details"
      redirect_back(fallback_location: root_path)
    end
  end

  def record_in_reach(choice_id)
    REACH_CLIENT.record_response("#{Rails.configuration.reach.id_prefix}_#{voter.sos_id.to_s.rjust(8, "0")}",
                                 current_user.id,
                                 Rails.configuration.reach.question_id,
                                 choice_id)
  end
end
