###* @jsx React.DOM ###

jest.dontMock("../heading")

describe "Heading", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "renders a heading with the right class name", ->
    Heading = require("../heading")
    heading = @utils.renderIntoDocument(`<Heading text="My Heading" />`)
    node = @utils.findRenderedDOMComponentWithTag(heading, "h1").getDOMNode()
    expect(node.className).toBe("heading")
    expect(/My\sHeading/.test(node.innerHTML)).toBe(true)

  it "renders an icon, if iconType is supplied", ->
    Heading = require("../heading")
    heading = @utils.renderIntoDocument(`<Heading text="My Heading" iconType="fa-lock" />`)
    node = @utils.findRenderedDOMComponentWithTag(heading, "h1").getDOMNode()
    expect(node.firstChild.tagName).toBe("I")
    expect(node.firstChild.className).toBe("fa fa-lock")

  it "transfers props to the heading", ->
    Heading = require("../heading")
    heading = @utils.renderIntoDocument(`<Heading text="My Heading" className="new" title="hello" />`)
    node = @utils.findRenderedDOMComponentWithTag(heading, "h1").getDOMNode()
    expect(node.className).toBe("heading new")
    expect(node.title).toBe("hello")
