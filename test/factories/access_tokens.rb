FactoryGirl.define do
  factory :access_token do
    application { create(:application) }
    user { create(:user) }
  end
end
