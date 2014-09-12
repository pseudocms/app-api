###* @jsx React.DOM ###

jest.dontMock("../icon.js.jsx")

describe "Icon", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "renders a font-awesome icon", ->
    Icon = require("../icon.js.jsx")

    icon = @utils.renderIntoDocument(`<Icon />`)
    node = @utils.findRenderedDOMComponentWithTag(icon, "i")
    expect(node.getDOMNode().className).toBe("fa")

  it "merges supplied props with icon", ->
    Icon = require("../icon.js.jsx")

    icon = @utils.renderIntoDocument(`<Icon className="fa-cogs" id="myId" />`)
    node = @utils.findRenderedDOMComponentWithTag(icon, "i").getDOMNode()
    expect(node.className).toBe("fa fa-cogs")
    expect(node.id).toBe("myId")
