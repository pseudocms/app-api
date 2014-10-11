require "test_helper"

class Admin::DashboardControllerTest < ActionController::TestCase

  test "GET index renders the view" do
    get :index
    assert_response :ok
    assert_template :index
  end
end
