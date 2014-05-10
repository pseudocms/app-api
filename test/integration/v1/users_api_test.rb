require 'test_helper'

class V1::UserAPITest < ActionDispatch::IntegrationTest
  api_version 1
  pagination_test :paged_users_request

  test 'getting all users requires client credentials' do
    user_auth(:david)

    get '/users'
    assert_response 403
  end

  test 'getting all users requires the authenticated client to be blessed' do
    client_auth(:normal_app)

    get '/users'
    assert_response 403
  end

  test 'getting all users returns users' do
    client_auth(:blessed_app)

    get '/users'
    assert_response :ok
    assert_kind_of Array, response_hash['users']
    assert response_hash['users'].size > 0
  end

  test 'getting all users sets the link header' do
    client_auth(:blessed_app)

    get '/users'
    assert_response :ok
    assert response.headers.has_key?('Link')
  end

  test 'GET /user returns the currently logged in user' do
    user_auth(:david)

    get '/user'
    assert_response :success
    assert_equal users(:david).email, response_hash['user']['email']
  end

  test '/user requires an authenticated user' do
    client_auth(:normal_app)

    get '/user'
    assert_response 403
  end

  test 'the authenticated user can look up themselves' do
    user_auth(:david)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, response_hash['user']['email']
  end

  test 'the authenticated user can only look up themselves' do
    user_auth(:david)

    user = users(:xavier)
    get "/users/#{user.id}"
    assert_response 403
  end

  test 'blessed clients can look up a specific user' do
    client_auth(:blessed_app)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, response_hash['user']['email']
  end

  test 'looking up a specific user with client auth requires a blessed client' do
    client_auth(:normal_app)

    user = users(:david)
    get "/users/#{user.id}"
    assert_response 403
  end

  test 'creating a user requires client authentication' do
    user_auth(:david)

    post '/users', user_params
    assert_response 403
  end

  test 'creating a user requires a blessed client' do
    client_auth(:normal_app)

    post '/users', user_params
    assert_response 403
  end

  test 'creating a user succeeds with valid parameters' do
    client_auth(:blessed_app)

    assert_difference 'User.count' do
      post '/users', user_params
      assert_response :success
    end
  end

  test 'creating a user with invalid parameters fails as unprocessable' do
    client_auth(:blessed_app)

    assert_no_difference 'User.count' do
      post '/users', user_params(email: users(:david).email)
      assert_response 422
    end

    assert_no_difference 'User.count' do
      post '/users', user_params(password: '')
      assert_response 422
    end
  end

  test 'a user can update their own account' do
    user_auth(:david)

    user = users(:david)
    patch "/users/#{user.id}", user_params
    assert_response :success
    assert_equal user_params[:user][:email], user.reload.email
  end

  test 'updating a user fails with invalid parameters' do
    user_auth(:david)

    user = users(:david)
    patch "/users/#{user.id}", user_params(password: '')
    assert_response 422
  end

  test 'a user can only update their own account' do
    user_auth(:david)

    user = users(:xavier)
    patch "/users/#{user.id}", user_params
    assert_response 403
  end

  test 'a blessed client can update any user account' do
    client_auth(:blessed_app)

    user = users(:david)
    patch "/users/#{user.id}", user_params
    assert_response :success
    assert_equal user_params[:user][:email], user.reload.email
  end

  test 'normal clients can\'t update a user' do
    client_auth(:normal_app)

    user = users(:xavier)
    patch "/users/#{user.id}", user_params
    assert_response 403
  end

  private

  def user_params(email: 'test@pseudocms.com', password: 'pAssword1')
    { user: { email: email, password: password } }
  end

  def paged_users_request(page, per_page)
    client_auth(:blessed_app)
    get '/users', page: page, per_page: per_page
  end
end
