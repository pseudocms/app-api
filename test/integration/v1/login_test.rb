require 'test_helper'

class V1::LoginTest < ActionDispatch::IntegrationTest
  api_version 1

  setup do
    authenticate_as(:david)
  end

  test 'succeeds and regenerates token with valid credentials' do
    user = users(:david)

    post '/users/login', nil, {
      'HTTP_AUTHORIZATION' => encode_credentials(user.email, 'pAssword1')
    }

    assert_response :success
    refute response.body.include?(user.auth_token)
  end

  test 'fails with invalid credentials' do
    post '/users/login', nil, {
      'HTTP_AUTHORIZATION' => encode_credentials('user', 'pass')
    }

    assert_response 401
    assert response.body.include?('"errors":')
  end

  test 'fails when credentials not supplied' do
    post '/users/login'

    assert_response 401
    assert response.body.include?('"errors":')
  end
end
