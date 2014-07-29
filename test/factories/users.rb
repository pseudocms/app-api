FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@pseudocms.com" }
    password "pAssword1"
  end
end
