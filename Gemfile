source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.1.5"
gem "rails-api", github: "rails-api/rails-api"
gem "pg"
gem "unicorn-rails"

gem "devise"
gem "doorkeeper"

gem "figaro"
gem "kaminari"

group :development do
  gem "spring"
  gem "pry-byebug"
  gem "spring-commands-testunit"
end

group :test do
  gem "mocha", require: false
  gem "factory_girl_rails"
end

group :production do
  gem "rails_12factor"
end
