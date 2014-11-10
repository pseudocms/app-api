# Set RAILS_ROOT and load the environment if it's not already loaded.
unless defined?(Rails)
  ENV["RAILS_ROOT"] = File.expand_path("../../", __FILE__)
  require File.expand_path("../../config/environment", __FILE__)
end

Teaspoon.configure do |config|

  config.asset_paths = ["test/javascripts"]
  config.fixture_paths = ["test/javascripts/fixtures"]

  config.suite do |suite|
    suite.use_framework :mocha
    suite.matcher = "{test/javascripts,app/assets}/**/*_test.{js,js.coffee,coffee}"
    suite.helper = "test_helper"
  end

  config.coverage do |coverage|
  end

end
