FactoryGirl.define do

  factory :application do
    sequence(:name) { |n| "Application #{n}" }
    client_id { SecureRandom.hex(6) }
    client_secret { SecureRandom.hex(6) }
  end
end
