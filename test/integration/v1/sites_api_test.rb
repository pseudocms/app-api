require 'test_helper'

class V1::SitesAPITest < ActionDispatch::IntegrationTest
  api_version 1
  pagination_test :paged_sites_request

  test "getting all sites when logged in as a user returns only their sites" do
    user = user_auth(:david)
    other_user = create(:user)

    make_site(user, name: "SiteA")
    make_site(other_user, name: "SiteB")

    get "/sites"
    assert_response :success
    assert_kind_of Array, json_response
    assert_equal 1, json_response.size
    refute json_response.map { |site| site["name"] }.include?("SiteB")
  end

  test "getting all sites as a blessed app returns all sites" do
    client_auth(blessed: true)

    user, other_user = create(:user), create(:user)
    make_site(user, name: "SiteA")
    make_site(other_user, name: "SiteB")

    get "/sites"
    assert_response :success
    assert_kind_of Array, json_response

    names = json_response.map { |site| site["name"] }
    ["SiteA", "SiteB"].each { |name| assert names.include?(name) }
  end

  test "getting all sites requires blessed_app or user token" do
    client_auth

    get "/sites"
    assert_response :forbidden
  end

  test "a user can get a site they own" do
    user = user_auth(:david)
    site = make_site(user)

    get "/sites/#{site.id}"
    assert_response :success
    assert_equal site.name, json_response["name"]
  end

  test "a user can get a site they are associated with" do
    user, other_user = create(:user), user_auth(:david)
    site = make_site(user)
    site.users << other_user

    get "/sites/#{site.id}"
    assert_response :success
  end

  test "a user can't get a site they are not associated with" do
    user, other_user = create(:user), user_auth(:david)
    site = make_site(user)

    get "/sites/#{site.id}"
    assert_response :forbidden
  end

  test "a blessed app can get any site" do
    client_auth(blessed: true)

    user = create(:user)
    site = make_site(user)

    get "/sites/#{site.id}"
    assert_response :success
    assert_equal site.name, json_response["name"]
  end

  test "when a site is not found, a 404 is returned" do
    client_auth(blessed: true)

    get "/sites/0"
    assert_response :not_found
  end

  test "getting a site requires blessed app or user authentication" do
    client_auth

    user = create(:user)
    site = make_site(user)

    get "/sites/#{site.id}"
    assert_response :forbidden
  end

  test "users can create sites" do
    user = user_auth(:david)

    assert_difference ["Site.count", "user.owned_sites.count"] do
      post "/sites", site_params
      assert_response :success
    end
  end

  test "blessed apps can create sites for any user" do
    client_auth(blessed: true)
    user = create(:user)

    assert_difference ["Site.count", "user.owned_sites.count"] do
      post "/sites", site_params(owner_id: user.id)
      assert_response :success
    end
  end

  test "when creating a site, blessed apps must pass the owner_id" do
    client_auth(blessed: true)

    assert_no_difference "Site.count" do
      post "/sites", site_params
      assert_response :not_found
    end
  end

  test "when a user creates a site, the owner_id is ignored" do
    user = user_auth(:david)

    assert_difference ["Site.count", "user.owned_sites.count"] do
      post "/sites", site_params(owner_id: -200) #ignored
      assert_response :success
    end
  end

  test "creating a site requires blessed app or user authentication" do
    client_auth

    assert_no_difference ["Site.count"] do
      post "/sites", site_params
      assert_response :forbidden
    end
  end

  test "creating a site with invalid params returns unprocessable entity" do
    user = user_auth(:david)

    assert_no_difference "Site.count" do
      post "/sites", site_params(name: "")
      assert_response :unprocessable_entity
    end

    site = create(:site, owner: user)
    assert_no_difference "Site.count" do
      post "/sites", site_params(name: site.name)
      assert_response :unprocessable_entity
    end
  end

  private

  def paged_sites_request(page, per_page)
    user = user_auth(:david)
    make_sites(user)

    get "/sites", page: page, per_page: per_page
  end

  def make_sites(owner, num: 10)
    [1, num].max.times { make_site(owner) }
  end

  def make_site(owner, attrs = {})
    defaults = { owner: owner, users: Array.wrap(owner) }
    create(:site, defaults.merge(attrs))
  end

  def site_params(attrs = {})
    { site: { name: "Some Site", description: "Some description" }.merge(attrs) }
  end
end
