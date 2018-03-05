# frozen_string_literal: true

require "prius"
require "sidekiq"
require "raven"
require "excon"
require "bundler"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "null_logger"

Prius.load(:bump_github_token)
Prius.load(:sentry_dsn, required: false)

Raven.configure do |config|
  config.dsn = Prius.get(:sentry_dsn) if Prius.get(:sentry_dsn)
  config.logger = NullLogger.new(STDOUT) unless Prius.get(:sentry_dsn)
end

# Heroku's ruby buildpack freezes the Gemfile to prevent accidental damage
# However, we actually *want* to manipulate Gemfiles for other repos.
Bundler.settings.temporary(frozen: 0)
