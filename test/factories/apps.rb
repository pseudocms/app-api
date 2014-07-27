FactoryGirl.define do

  factory :app, class: Doorkeeper::Application do
    name "Application"
    uid { SecureRandom.uuid }
    secret "app_secret_value"
    redirect_uri "http://application.com/"

    factory :blessed_app do
      blessed true
    end
  end
end
