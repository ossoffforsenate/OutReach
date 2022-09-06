class User < ApplicationRecord
  include Skylight::Helpers

  self.primary_key = :id

  has_many :relationships
  has_many :voters, through: :relationships

  def phone_number_display
    PhoneNumberUtils.display(phone_number)
  end

  def display_name
    "#{first_name} #{last_name}"
  end

  def call_list
    relationship_call_list
  end

  def non_self_voters
    Voter.where(reach_id: Relationship.where(user_id: id).where.not(relationship: 'Me').select(:voter_reach_id))
  end

  def calls_logged
    REDIS_CLIENT.get("user:#{id}:contacts").to_i
  rescue
    0
  end

  def log_call!
    REDIS_CLIENT.incr("user:#{id}:contacts")
  rescue => e
    Rails.logger.error("Error logging call in redis: #{e.class} -- #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
  end

  def skips_logged
    REDIS_CLIENT.get("user:#{id}:skips").to_i
  rescue
    0
  end

  def log_skip!
    REDIS_CLIENT.incr("user:#{id}:skips")
  rescue => e
    Rails.logger.error("Error logging call in redis: #{e.class} -- #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
  end

  def seen_voters
    res = JSON.parse(REDIS_CLIENT.get("user:#{id}:seen") || {})
    res.is_a?(Hash) ? res : {}
  rescue => e
    Rails.logger.error("Error logging call in redis: #{e.class} -- #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    {}
  end

  def log_voter!(reach_id)
    seen = seen_voters
    seen[reach_id] = true
    set_voters!(seen)
  end

  def set_voters!(voter_hash)
    REDIS_CLIENT.set("user:#{id}:seen", JSON.dump(voter_hash))
  rescue => e
    Rails.logger.error("Error logging call in redis: #{e.class} -- #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
  end

  def relationship_call_list
    Voter.
      where(reach_id: Relationship.where(user_id: id).where.not(relationship: 'Me').select(:voter_reach_id)).
      order(:reach_id).
      where(last_call_status: [:not_yet_called, :should_call_again])
  end
end
