FactoryGirl.define do
  factory :site do
    sequence(:name) { |n| "site ##{n}" }
    description "Site description"
  end
end
