require "test_helper"

class ReactHelperTest < ActionView::TestCase

  test "component divs are rendered with a random id" do
    assert_match /react\-(\w+)/, component.attributes["id"]
  end

  test "component is queued for rendering" do
    id = component.attributes["id"]
    assert_match /reactComponents\["#{id}"\] = "LoginForm"/, component.to_s
  end

  test "components are generated from {js_path}/components" do
    component_names = react_components
    component_names.each do |component|
      assert_match /\A.\/components\//, component
      refute_match /\.js\.jsx\z/, component
    end
  end

  private

  def component(name: "LoginForm")
    @component ||= node(react_component(name))
  end

  def node(html)
    HTML::Document.new(html).root.children.first
  end
end
