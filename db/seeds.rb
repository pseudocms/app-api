# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin Application
Doorkeeper::Application.create!(
  name: "PseudoCMS Admin",
  redirect_uri: "https://pseudocms.com/",
  blessed: true
)

User.create!(email: "test@user.com", password: "password") if Rails.env.development?
