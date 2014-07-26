source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.1.4'
gem 'rails-api', github: 'rails-api/rails-api'
gem 'pg'
gem 'unicorn-rails'

gem 'devise'
gem 'doorkeeper'
gem 'active_model_serializers'

gem 'figaro'
gem 'will_paginate', github: 'pseudomuto/will_paginate', ref: 'first_last_page_predicates_for_collection'

group :development do
  gem 'spring'
  gem 'pry-byebug'
  gem 'spring-commands-testunit'
end

group :test do
  gem 'mocha', require: false
  gem 'factory_girl_rails'
end

group :production do
  gem 'rails_12factor'
end
