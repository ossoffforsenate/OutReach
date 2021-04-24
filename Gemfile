source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.6.3"


gem "autoprefixer-rails"

gem "bootsnap", require: false
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 6.0.0"
gem "recipient_interceptor"
gem "sassc-rails"
gem "sprockets", ">= 3.0.0"
gem "title"
gem 'twilio-ruby'
gem "tzinfo-data", platforms: [:mingw, :x64_mingw, :mswin, :jruby]
gem "webpacker"

group :development do
  gem "listen"
  gem "rack-mini-profiler", require: false
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "pry-byebug"
  gem "pry-rails"
end

group :test do
  gem "formulaic"
  gem "launchy"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

gem "dotenv-rails"

gem "suspenders", group: [:development, :test]

gem "faker", "~> 2.15"

gem "bulma-rails", "~> 0.9.1"

gem "irb", "~> 1.3"

gem "skylight", "~> 4.3"

gem "rails_autoscale_agent", "~> 0.9.1"

gem "rollbar", "~> 3.1"

gem "redis", "~> 4.2"
