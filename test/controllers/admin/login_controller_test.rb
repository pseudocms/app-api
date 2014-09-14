require "test_helper"

class Admin::LoginControllerTest < ActionController::TestCase

  test "GET index renders the login page" do
    get :index
    assert_response :ok
    assert_template :index
  end

  test "POSTing to create stores the supplied token in the session" do
    post :create, token: "12345"
    assert_equal "12345", session[:auth_token]
  end

  test "POSTing to create redirects to admin_root" do
    post :create, token: "12345"
    assert_redirected_to admin_root_path
  end
end
