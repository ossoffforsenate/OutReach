class CronController < ApplicationController
  skip_before_action :authorized
  before_action      :ensure_cron

  private

  def ensure_cron
    if !request.headers['X-Appengine-Cron'] && Rails.env.production?
      puts "Got request from non cron user, sending 404"
      head :not_found
    end
  end

  def big_query_loader
    @big_query_loader ||= BigQueryLoader.new
  end
end
