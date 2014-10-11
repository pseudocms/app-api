require "test_helper"

class Admin::LoginControllerTest < ActionController::TestCase

  test "renders the login page" do
    get :index
    assert_response :ok
  end
end
