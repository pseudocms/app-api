require "test_helper"

class Admin::LoginControllerTest < ActionController::TestCase

  setup do
    config = Rails.application.config_for(:application)
    @app_params = { client_id: config["client_id"], client_secret: config["client_secret"] }
    make_app(@app_params)
  end

  test "#index renders the login page" do
    get :index, @app_params
    assert_response :ok
    assert_not_nil assigns(:login)
  end

  test "#create stores the auth token in the cookie" do
    user = create(:user, password: "somePAssword123")
    params = @app_params.merge({
      login: {
        email: user.email,
        password: "somePAssword123"
      }
    })

    post :create, params
    assert_not_nil cookies[:access_token]
    assert_redirected_to admin_root_path
  end

  test "#create re-renders the login page when credentials aren't valid" do
    user = create(:user, password: "somePAssword123")
    params = @app_params.merge({
      login: {
        email: user.email,
        password: "BAD PASSWORD"
      }
    })

    post :create, params
    assert_nil cookies[:auth_token]
    assert assigns(:login).errors.size > 0
    assert_template :index
  end

  test "#destroy invalidates the session" do
    delete :destroy
    assert_nil cookies[:auth_token]
    assert_redirected_to admin_root_path
  end

  private

  def make_app(options = {})
    app = create(:application)
    app.update_attributes(options)
    app
  end
end
