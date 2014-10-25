require "test_helper"

class Admin::SitesControllerTest < ActionController::TestCase
  setup do
    login_as_user
  end

  test "index renders correctly" do
    get :index
    assert_response :ok
    assert_template :index
  end
end
