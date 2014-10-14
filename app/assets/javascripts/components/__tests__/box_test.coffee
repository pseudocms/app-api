###* @jsx React.DOM ###

jest.dontMock("../box")

React = require("react/addons")
Test  = React.addons.TestUtils
Box   = require("../box")

describe "Box", ->

  it "renders a div with the box class", ->
    box = Test.renderIntoDocument(`<Box className="box--error" />`)
    node = Test.findRenderedDOMComponentWithTag(box, "div").getDOMNode()
    expect(node.className).toBe("box box--error")

  it "renders children inside the box", ->
    box = Test.renderIntoDocument `
      <Box>
        <nav>
          <ul>
            <li>My Item</li>
          </ul>
        </nav>
      </Box>
    `
    Test.findRenderedDOMComponentWithTag(box, "li")
