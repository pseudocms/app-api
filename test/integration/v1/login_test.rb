require 'test_helper'

class V1::LoginTest < ActionDispatch::IntegrationTest

  test 'succeeds with valid credentials' do
    user = users(:david)

    post '/users/login', nil, {
      'HTTP_AUTHORIZATION' => encode_credentials(user.email, 'pAssword1')
    }

    assert_response :success
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

  private

  DEFAULT_HEADERS = {
    'HTTP_ACCEPT' => 'vnd.pseudocms.v1+json'
  }

  def post(uri, params = {}, headers = {})
    super(uri, params, DEFAULT_HEADERS.merge(headers))
  end

  def encode_credentials(user, pass)
    ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
  end
end
