require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "rails/all"
#require "active_model/railtie"
#require "active_job/railtie"
#require "active_record/railtie"
#require "action_controller/railtie"
#require "action_mailer/railtie"
#require "action_view/railtie"
#require "sprockets/railtie"
#require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # force after_commit callbacks to raise since this will
    # become the default
    config.active_record.raise_in_transactional_callbacks = true

    config.browserify_rails.commandline_options = "-t coffeeify --extension \".coffee\" --extension \".js.jsx\""
  end
end
