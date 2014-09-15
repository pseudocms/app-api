require "test_helper"

class RoutesHelperTest < ActionView::TestCase

  test "renders a json object called routes" do
    json = routes_as_json
    assert_match /\Avar routes = \{\};/, json
  end

  test "adds a definition for all named routes" do
    json = routes_as_json
    named_routes.each do |route|
      path = route.path.sub(/\(.:format\)\z/, "")
      assert_match /^routes\["#{route.name}"\] = "#{path}";$/, json
    end
  end

  private

  def named_routes
    Rails.application.routes.routes.collect { |route|
      ActionDispatch::Routing::RouteWrapper.new(route)
    }.reject { |route| route.name.blank? }
  end
end
