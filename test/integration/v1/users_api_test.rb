require 'test_helper'

class V1::UserAPITest < ActionDispatch::IntegrationTest
  api_version 1

  test 'GET /user returns the currently logged in user' do
    authenticate_as(:david)

    get '/user'
    assert_response :success
    refute response_hash.has_key?('auth_token')
  end

  test 'getting all users requires trusted_app scope' do
    authenticate_as(:david)

    get '/users'
    assert_response 401
  end

  test 'getting all users returns users' do
    authenticate_as(:david, :trusted_app)

    get '/users'
    assert_response 200
    assert_kind_of Array, response_hash['users']
    assert response_hash['users'].size > 0
  end

  test 'looking up a specific user requires the trusted_app scope' do
    authenticate_as(:david)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response 401
  end

  test 'looking up a specific user returns the user with the specified id' do
    authenticate_as(:david, :trusted_app)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, response_hash['user']['email']
  end

  test 'creating a user requires the trusted_app scope' do
    authenticate_as(:david)

    post '/users', user_params
    assert_response 401
  end

  test 'creating a user succeeds with valid parameters' do
    authenticate_as(:david, :trusted_app)

    post '/users', user_params
    assert_response :success
  end

  test 'creating a user with invalid parameters fails as unprocessable' do
    authenticate_as(:david, :trusted_app)

    post '/users', user_params(email: users(:david).email)
    assert_response 422

    post '/users', user_params(password: '')
    assert_response 422
  end

  private

  def user_params(email: 'test@pseudocms.com', password: 'pAssword1')
    { user: { email: email, password: password } }
  end
end
