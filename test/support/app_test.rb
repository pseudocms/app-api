module AppTest
  extend ActiveSupport::Concern

  def assert_requires_valid_session(method, *args)
    logout
    send(method, *args)
    assert_redirected_to admin_login_path

    login_as_user(expires_in: 0.seconds)
    send(method, *args)
    assert_redirected_to admin_login_path

    login_as_user
    current_auth_token.revoke
    send(method, *args)
    assert_redirected_to admin_login_path
  end
end
