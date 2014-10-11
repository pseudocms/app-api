###* @jsx React.DOM ###

jest.dontMock("../icon")

React = require("react/addons")
Test  = React.addons.TestUtils
Icon  = require("../icon")

describe "Icon", ->

  it "renders an icon element", ->
    icon = Test.renderIntoDocument(`<Icon />`)
    Test.findRenderedDOMComponentWithTag(icon, "i")

  it "transfers properties to the icon element", ->
    icon = Test.renderIntoDocument(`<Icon className="fa-lock" />`)
    element = Test.findRenderedDOMComponentWithTag(icon, "i").getDOMNode()
    expect(element.className).toBe("fa fa-lock")
