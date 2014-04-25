require 'test_helper'

class V1::UserAPITest < ActionDispatch::IntegrationTest
  api_version 1

  test '/user returns the currently logged in user' do
    authenticate_as(:david)

    get '/user'
    assert_response :success
    refute response.body.include?('"auth_token":')
  end
end
