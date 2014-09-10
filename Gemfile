source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.2.0.beta1"
gem "rails-api", github: "rails-api/rails-api"
gem "responders", "~> 2.0"
gem "pg"

gem "devise"
gem "doorkeeper"
gem "kaminari"

gem "turbolinks"
gem "sass"
gem "bourbon"
gem "font-awesome-rails"
gem "react-rails", "~> 1.0.0.pre", github: "reactjs/react-rails"

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
