class ActionController::TestCase

  attr_reader :current_auth_token

  def login_as_user(token_options: {})
    user = create(:user)
    app = create(:app)

    attrs = token_options.reverse_merge(application_id: app.id, resource_owner_id: user.id)
    token = Doorkeeper::AccessToken.create!(attrs)

    @current_auth_token = token
    @request.session[:auth_token] = token.token
  end

  def logout
    session.delete(:auth_token)
    current_auth_token.destroy unless current_auth_token.nil?
  end

  def assert_requires_valid_session(method, *args)
    logout
    send(method, *args)
    assert_redirected_to admin_login_path

    login_as_user(token_options: { expires_in: 0.seconds })
    send(method, *args)
    assert_redirected_to admin_login_path

    login_as_user
    current_auth_token.revoke
    send(method, *args)
    assert_redirected_to admin_login_path
  end
end
