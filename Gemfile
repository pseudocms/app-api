source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.2.0.beta1"
gem "rails-api", github: "rails-api/rails-api"
gem "responders", "~> 2.0"
gem "pg"

gem "devise"
gem "doorkeeper"
gem "kaminari"
gem "browserify-rails"

gem "turbolinks"
gem "sass"
gem "bourbon"
gem "font-awesome-rails"

group :development do
  gem "thin"
  gem "spring"
  gem "pry-byebug"
  gem "spring-commands-testunit"
  gem "web-console", "2.0.0.beta3"
end

group :test do
  gem "mocha", require: false
  gem "factory_girl_rails"
end

group :production do
  gem "unicorn"
  gem "rails_12factor"
end
