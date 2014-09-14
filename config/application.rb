require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # force after_commit callbacks to raise since this will become the default
    config.active_record.raise_in_transactional_callbacks = true

    # custom params for browserify
    config.browserify_rails.commandline_options = "-t coffeeify --extension \".coffee\" --extension \".js.jsx\""

    # no longer just an api app
    config.api_only = false
  end
end
