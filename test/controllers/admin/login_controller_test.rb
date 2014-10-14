require "test_helper"

class Admin::LoginControllerTest < ActionController::TestCase

  test "#index renders the login page" do
    get :index
    assert_response :ok
    assert_not_nil assigns(:login)
  end

  test "#create logs the user in by setting auth token in the session" do
    user = create(:user, password: "pAssword1")
    post :create, login: { email: user.email, password: "pAssword1" }
    assert_response :redirect
    assert_not_nil session[:auth_token]
  end

  test "#create renders the login page when the credentials aren't valid" do
    post :create, login: { email: "some@email.com", password: "somePassword" }
    assert_response :ok
    assert_template :index
  end
end
