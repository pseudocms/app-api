require "test_helper"

class ReactorTest < ActiveSupport::TestCase

  test ".compile delegates to a compiler from the pool" do
    input = "var page = React.createClass({ render: function() { return \"\"; } });"
    Reactor.any_instance.expects(:compile).with(input)
    Reactor.compile(input)
  end

  test "#compile compiles jsx string into js" do
    input = <<-CODE
    <div className="test">
      <h1>Hello</h1>
    </div>
    CODE

    compiled_js = Reactor.new.compile(input)

    %w(React.DOM.div React.DOM.h1 Hello).each do |substr|
      assert_includes compiled_js, substr
    end
  end
end
