Rails.application.configure do
  review_app_host = "#{ENV.fetch("HEROKU_APP_NAME")}.herokuapp.com"

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.action_controller.asset_host = review_app_host
  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
  config.middleware.use Rack::CanonicalHost, review_app_host
  config.middleware.use Rack::Deflater
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=31557600",
  }
  config.action_mailer.default_url_options = { host: review_app_host }
  config.action_mailer.asset_host = review_app_host

  # handles read-write routing
  config.active_record.database_selector = { delay: 2.seconds }
  config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
