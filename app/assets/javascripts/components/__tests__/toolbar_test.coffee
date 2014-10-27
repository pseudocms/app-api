###* @jsx React.DOM ###

jest.dontMock("../toolbar")

React   = require("react/addons")
Test    = React.addons.TestUtils
Toolbar = require("../toolbar")

describe "Toolbar", ->

  it "transfers props to a header element", ->
    toolbar = Test.renderIntoDocument(`<Toolbar className="myToolbar" />`)
    node = Test.findRenderedDOMComponentWithTag(toolbar, "header").getDOMNode()
    expect(node.className).toBe("toolbar myToolbar")

  it "renders it's children within it", ->
    toolbar = Test.renderIntoDocument `
      <Toolbar className="myToolbar">
        <h1>My Title</h1>
      </Toolbar>
    `

    Test.findRenderedDOMComponentWithTag(toolbar, "h1")
