source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.2.0.beta2"
gem "rails-api", github: "rails-api/rails-api"
gem "responders", "~> 2.0"
gem "pg"

gem "devise"
gem "doorkeeper"
gem "kaminari"
gem "connection_pool"

gem "turbolinks"
gem "sass"
gem "coffee-rails"
gem "bourbon"
gem "browserify-rails"

group :development do
  gem "thin"
  gem "spring"
  gem "pry-byebug"
  gem "spring-commands-testunit"
end

group :test do
  gem "mocha", require: false
  gem "factory_girl_rails"
end

group :production do
  gem "unicorn"
  gem "rails_12factor"
end
