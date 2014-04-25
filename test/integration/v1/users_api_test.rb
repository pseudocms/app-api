require 'test_helper'

class V1::UserAPITest < ActionDispatch::IntegrationTest
  api_version 1

  test '/user returns the currently logged in user' do
    authenticate_as(:david)

    get '/user'
    assert_response :success
    refute body.has_key?('auth_token')
  end

  test '/user/:id requires the trusted_app scope' do
    authenticate_as(:david)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response 401
  end

  test '/user/:id returns the user with the specified id' do
    authenticate_as(:david, :trusted_app)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, body['user']['email']
  end

  private

  def body
    @body ||= JSON.parse(response.body)
  end
end
