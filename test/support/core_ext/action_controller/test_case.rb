require "support/app_test"

class ActionController::TestCase
  include AppTest

  attr_reader :current_auth_token

  def login_as_user(options = {})
    user = create(:user)
    app = create(:app)

    attrs = options.reverse_merge(application_id: app.id, resource_owner_id: user.id)
    token = Doorkeeper::AccessToken.create!(attrs)

    @current_auth_token = token
    @request.session[:auth_token] = token.token
  end

  def logout
    session.delete(:auth_token)
    current_auth_token.destroy if current_auth_token
  end
end
