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
end
