# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin Application

if Rails.env.development? || Rails.env.test?
  config = Rails.application.config_for(:application)
  admin_app = Application.create!(
    name: "PseudoCMS Admin",
    blessed: true
  )

  admin_app.update_attributes(
    client_id: config["client_id"],
    client_secret: config["client_secret"]
  )

  User.create!(email: "test@user.com", password: "password")
end
