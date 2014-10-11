require "test_helper"

class Admin::ReactHelperTest < ActionView::TestCase

  test "#react generates a div with a unique id" do
    assert_match %r{<div id="react-(\w+)">}, result
  end

  test "#react registers the react component" do
    component_id = %r{<div id="react-(\w+)">}.match(result)[1]
    assert_includes result, "reactComponents.push({ id: \"react-#{component_id}\", component: "
  end

  test "#react compiles the jsx from the block" do
    Reactor::Compiler.any_instance.expects(:compile).returns("")
    assert_not_nil result
  end

  private

  def result
    @result ||= react do
      "<Page><h1>Hello</h1></Page>".html_safe
    end
  end
end
