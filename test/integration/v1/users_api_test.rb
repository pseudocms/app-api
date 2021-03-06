require "test_helper"

class V1::UserAPITest < ActionDispatch::IntegrationTest
  api_version 1
  pagination_test :paged_users_request

  test "getting all users requires client credentials" do
    user_auth(:david)

    get "/users"
    assert_permission_denied
  end

  test "getting all users requires the authenticated client to be blessed" do
    client_auth

    get "/users"
    assert_permission_denied
  end

  test "getting all users returns users" do
    client_auth(blessed: true)
    make_users

    get "/users"
    assert_response :ok
    assert_kind_of Array, api_response
    assert api_response.size > 0
  end

  test "GET /user returns the currently logged in user" do
    user_auth(:david)

    get "/user"
    assert_response :success
    assert_equal User.find_by_email("david@pseudocms.com").email, api_response["email"]
  end

  test "/user requires an authenticated user" do
    client_auth

    get "/user"
    assert_permission_denied
  end

  test "the authenticated user can look up themselves" do
    user = user_auth(:david)

    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, api_response["email"]
  end

  test "the authenticated user can only look up themselves" do
    user_auth(:david)

    user = create(:user)
    get "/users/#{user.id}"
    assert_permission_denied
  end

  test "blessed clients can look up a specific user" do
    client_auth(blessed: true)

    user = create(:user)
    get "/users/#{user.id}"
    assert_response :success
    assert_equal user.email, api_response["email"]
  end

  test "looking up a specific user with client auth requires a blessed client" do
    client_auth

    user = create(:user)
    get "/users/#{user.id}"
    assert_permission_denied
  end

  test "creating a user requires client authentication" do
    user_auth(:david)

    post "/users", user_params
    assert_permission_denied
  end

  test "creating a user requires a blessed client" do
    client_auth

    post "/users", user_params
    assert_permission_denied
  end

  test "creating a user succeeds with valid parameters" do
    client_auth(blessed: true)

    assert_difference "User.count" do
      post "/users", user_params
      assert_response :success
    end
  end

  test "creating a user with invalid parameters fails as unprocessable" do
    client_auth(blessed: true)
    user = create(:user, email: "david@pseudocms.com")

    assert_no_difference "User.count" do
      post "/users", user_params(email: user.email)
      assert_error(:unprocessable_entity, no_body: true)
    end

    assert_no_difference "User.count" do
      post "/users", user_params(password: "")
      assert_error(:unprocessable_entity, no_body: true)
    end
  end

  test "a user can update their own account" do
    user = user_auth(:david)

    patch "/users/#{user.id}", user_params
    assert_successful_update
    assert_equal user_params[:email], user.reload.email
  end

  test "updating a user fails with invalid parameters" do
    user = user_auth(:david)

    patch "/users/#{user.id}", user_params(password: "")
    assert_error(:unprocessable_entity, no_body: true)
  end

  test "a user can only update their own account" do
    user_auth(:david)

    user = create(:user)
    patch "/users/#{user.id}", user_params
    assert_permission_denied
  end

  test "a blessed client can update any user account" do
    client_auth(blessed: true)

    user = create(:user, email: "david@pseudocms.com")
    patch "/users/#{user.id}", user_params
    assert_successful_update
    assert_equal user_params[:email], user.reload.email
  end

  test "normal clients can't update a user" do
    client_auth

    user = create(:user)
    patch "/users/#{user.id}", user_params
    assert_permission_denied
  end

  test "a blessed client can delete a user account" do
    client_auth(blessed: true)

    user = create(:user)
    assert_difference "User.count", -1 do
      delete "/users/#{user.id}"
      assert_successful_delete
    end
  end

  test "a 404 is returned when deleting a user that doesn't exist" do
    client_auth(blessed: true)

    assert_no_difference "User.count" do
      delete "/users/0"
      assert_not_found
    end
  end

  test "a 412 is returned when deleting a user that is an owner of a site" do
    client_auth(blessed: true)

    user = create(:user)
    site = create(:site, owner: user)

    assert_no_difference "User.count" do
      delete "/users/#{user.id}"
      assert_error(:precondition_failed, message: "User owns one or more sites")
    end
  end

  test "non-blessed clients can't delete a user" do
    client_auth

    user = create(:user)
    assert_no_difference "User.count" do
      delete "/users/#{user.id}"
      assert_permission_denied
    end
  end

  private

  def user_params(email: "test@pseudocms.com", password: "pAssword1")
    { email: email, password: password }
  end

  def paged_users_request(page, per_page)
    client_auth(blessed: true)
    make_users

    get "/users", page: page, per_page: per_page
  end

  def make_users(num: 10)
    [1, num].max.times { create(:user) }
  end
end
