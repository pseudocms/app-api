require 'test_helper'

class SiteTest < ActiveSupport::TestCase

  test "name is required" do
    site = Site.new(description: 'some description')

    refute site.valid?
    assert_equal 1, site.errors.size
    assert site.errors.has_key?(:name)
  end

  test "name must be unique" do
    site = sites(:pseudocms)
    new_site = Site.new(name: site.name, description: 'some description')

    refute new_site.save
    assert_equal 1, new_site.errors.size
    assert new_site.errors.has_key?(:name)
  end
end
