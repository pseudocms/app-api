require 'test_helper'

class SiteTest < ActiveSupport::TestCase

  test "name is required" do
    site = Site.new(description: 'some description')

    refute site.valid?
    assert_equal 1, site.errors.size
    assert site.errors.has_key?(:name)
  end

  test "name must be unique" do
    user = create(:user)
    site = create(:site, owner: user)
    new_site = Site.new(name: site.name, description: 'some description', owner: user)

    refute new_site.save
    assert_equal 1, new_site.errors.size
    assert new_site.errors.has_key?(:name)
  end

  test "creating a site, creates the association with the owner" do
    new_site = Site.new(name: 'some site', owner: create(:user))
    new_site.run_callbacks(:commit) do
      new_site.save!
    end

    assert_equal 1, new_site.users.size
  end
end
