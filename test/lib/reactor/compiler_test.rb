require "test_helper"

class Reactor::CompilerTest < ActiveSupport::TestCase

  test "#compile when no modifiers present returns source" do
    input = "var someFunc = function() { doSomething(); };"
    assert_equal input, Reactor::Compiler.new(input).compile
  end

  test "#compile when coffee compiles to js" do
    input = "React = require(\"react\")"
    expected = "var React;\n\nReact = require(\"react\");"
    assert_equal expected, Reactor::Compiler.new(input, coffee: true).compile.chomp
  end

  test "#compile when jsx compiles to js" do
    input = <<-CODE
    var page = React.createClass({
      render: function() {
        return (
          <div className="test">
            <h1>Hello</h1>
          </div>
        );
      }
    });
    CODE

    compiled_js = Reactor::Compiler.new(input, jsx: true).compile

    %w(React.DOM.div React.DOM.h1 Hello).each do |substr|
      assert_includes compiled_js, substr
    end
  end

  test "#compile when both coffee and jsx compiles to js" do
    input = <<-CODE
    Page = React.createClass
      render: -> `
        <div className="test">
          <h1>Hello</h1>
        </div>`
    CODE

    compiled_js = Reactor::Compiler.new(input, coffee: true, jsx: true).compile

    %w(React.DOM.div React.DOM.h1 Hello).each do |substr|
      assert_includes compiled_js, substr
    end
  end
end
