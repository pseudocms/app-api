require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.api_only = false
  end
end
