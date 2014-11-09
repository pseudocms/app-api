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

gem "turbograft", github: "Shopify/turbograft", ref: "bugfix/28_compute_redirect_to_location_signature"
gem "sass"
gem "coffee-rails"
gem "bourbon"
gem "font-awesome-rails"

group :development do
  gem "thin"
  gem "spring"
  gem "pry-byebug"
  gem "spring-commands-testunit"
end

group :test do
  gem "mocha", require: false
  gem "factory_girl_rails"
  gem "webmock"
end

group :development, :test do
  gem "teaspoon"
end

group :production do
  gem "unicorn"
  gem "rails_12factor"
end
