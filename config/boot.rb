ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

if ENV["RAILS_ENV"] == "development" || ENV["RAILS_ENV"].nil?
  require "rails/commands/server"
  module Rails
    class Server
      alias_method :original_default_options, :default_options

      def default_options
        original_default_options.merge(Host: "0.0.0.0")
      end
    end
  end
end
