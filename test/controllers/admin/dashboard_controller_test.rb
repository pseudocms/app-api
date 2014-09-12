require "test_helper"

class Admin::DashboardControllerTest < ActionController::TestCase

  test "GET index" do
    get :index
    assert_response :ok
  end
end
